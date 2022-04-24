import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';
import 'package:uguard_app/models/address.dart';
import 'package:uguard_app/models/direction_details.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:uguard_app/models/nearby_available_contacts.dart';
import 'package:uguard_app/controllers/nearby_available_contacts_controller.dart';
import 'package:uguard_app/models/contact.dart';
import 'package:uguard_app/controllers/contacts_controller.dart';
const GOOGLE_API_KEY = 'AIzaSyDFuJnXrGg1179H6ALtyaafUBB_Z7v0nhE';

class PlaceOverviewScreen extends StatefulWidget {
  static const routeName = '/place-overview';
  @override
  _PlaceOverviewScreenState createState() => _PlaceOverviewScreenState();
}

class _PlaceOverviewScreenState extends State<PlaceOverviewScreen> {
  List<LatLng>pLineCoordinates=[];
  Set<Polyline>polylineSet={};
 
   Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;
  String displayAddress='123 fart street';
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Position? currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;
  BitmapDescriptor? nearByIcon;

 void _savePlace() {
    // if (_titleController.text.isEmpty || _pickedImage == null) {
    //   return;
    // }
    // Provider.of<PlacesController>(context, listen: false)
    //     .addPlace(_titleController.text, _pickedImage!,_pickedLocation!);
    // Navigator.of(context).pop();
  }
  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    //String address = await AssistantMethods.searchCoordinateAddress(position);
    //print("this is your address " + address);
    final address =  Address.getPlaceAddress(position.latitude,position.longitude);
        print("here is the address"+address.toString());
  }
  void getDirections()async{
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
        double finalLat=40.759689;
       // double final_lat=40.759689;
        double finalLgt=-111.848555;
        double initLat=position.latitude;
        double initLgt=position.longitude;
        var pickUpLatLng=LatLng(initLat,initLgt);
        var dropOffLatLng=LatLng(finalLat, finalLgt);
   // Address.getDirections(position.latitude, position.longitude, final_lat, final_lgt);
     currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
   
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=$initLat,$initLgt&destination=$finalLat,$finalLgt&key=$GOOGLE_API_KEY');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };
          DirectionDetails directionDetails = DirectionDetails();

    try {
      final response = await http.get(url, headers: header);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return; // "extractedData was null";
      }
    //  DirectionDetails directionDetails = DirectionDetails();

      directionDetails.encodedPoints = extractedData["routes"][0]["overview_polyline"]["points"];
      directionDetails.distanceText = extractedData["routes"][0]["legs"][0]["distance"]["text"];
      directionDetails.distanceValue = extractedData["routes"][0]["legs"][0]["distance"]["value"];
      directionDetails.durationText =  extractedData["routes"][0]["legs"][0]["duration"]["text"];
      directionDetails.durationValue = extractedData["routes"][0]["legs"][0]["duration"]["value"];
      print("encodedPoints = " + directionDetails.encodedPoints!);
      print("distancetext = " + directionDetails.distanceText!);
      print("directionvalue = " + directionDetails.distanceValue.toString());
      print("durationtext = " + directionDetails.durationText!);
      print("durationvalue = " + directionDetails.durationValue.toString());
      } catch (error) {
      print(error);
      throw (error);
    }
      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> decodedPolyLinePointsResult =
          polylinePoints.decodePolyline(directionDetails.encodedPoints!);

pLineCoordinates.clear();
          if(decodedPolyLinePointsResult.isNotEmpty){
            decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
              pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
             });
          }
          polylineSet.clear();//so that it knows were drawing new lines
          setState(() {
            Polyline polyline= Polyline(
            color: Colors.pink,
            polylineId: PolylineId("PolylineID"),
            jointType: JointType.round,
            points: pLineCoordinates,
            width: 5,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            geodesic: true,
            );
            polylineSet.add(polyline); // add a polyline for each 
          });
     LatLngBounds latLngBounds;
     if(pickUpLatLng.latitude>dropOffLatLng.latitude&&pickUpLatLng.longitude> dropOffLatLng.longitude){
             latLngBounds = LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);

     }
        else if(pickUpLatLng.longitude > dropOffLatLng.longitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude), northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    }
    else if(pickUpLatLng.latitude > dropOffLatLng.latitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude), northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    }
    else
    {
      latLngBounds = LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }
    newGoogleMapController!.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow: InfoWindow(title: 'Home', snippet: "my Location"),
      position: pickUpLatLng,
      markerId: MarkerId("pickUpId"),
    );

    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow: InfoWindow(title: 'Rice Eccles Stadium', snippet: "DropOff Location"),
      position: dropOffLatLng,
      markerId: MarkerId("dropOffId"),
    );

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
    });

    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blueAccent,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("pickUpId"),
    );

    Circle dropOffLocCircle = Circle(
      fillColor: Colors.blueAccent,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("dropOffId"),
    );

    setState(() {
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropOffLocCircle);
    });
    newGoogleMapController!.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Overview'),
        actions: <Widget>[
          IconButton(
            onPressed: _savePlace,
             icon: Icon(Icons.save),
             )
        ],),
        drawer: MenuDrawer(),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap, top: 25.0),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: polylineSet,
           markers: markersSet,
            circles: circlesSet,
            onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 300.0;
              });

              locatePosition();
            },
          ),
          ElevatedButton(
            
            onPressed: getDirections, 
            child: Text('get directions',
            style: TextStyle(backgroundColor: Colors.black,
            color: Colors.white),)
            ),
             Container(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: initGeoFireListener,
          child: Text(
            'get availContacts',
            style:
                TextStyle(backgroundColor: Colors.black, color: Colors.white),
          ),
        ),
      ),
              ]
            ),
      );
    
  }
  void initGeoFireListener() async {
    Geofire.initialize("availableContacts");
//display nearby drivers within a 75km radius of the given latitude and longitue
//the currentPosition.latitude represents the current latitude of the current user same goes for the longitude
    Geofire.queryAtLocation(
            currentPosition!.latitude, currentPosition!.longitude, 75)!
        .listen((map) {
      print(map);
      if (map != null) {
        var callBack = map['callBack'];

        //latitude will be retrieved from map['latitude']
        //longitude will be retrieved from map['longitude']
//the key is the  id from the database, the id is equal to the userId?
        switch (callBack) {
          case Geofire.onKeyEntered:
            NearbyAvailableContactsController.nearByAvailableContactsList=getAvailableContacts();
            print("here is the key of the contact " +  NearbyAvailableContactsController.nearByAvailableContactsList.elementAt(0).key!);
            //     NearbyAvailableContacts();
            // nearbyAvailableContacts.key = (map["key"]);
            // nearbyAvailableContacts.latitude = map['latitude'];
            // nearbyAvailableContacts.longitude = map['longitude'];
            // NearbyAvailableContactsController.nearByAvailableContactsList
            //     .add(nearbyAvailableContacts);
            break;

          case Geofire.onKeyExited:
            NearbyAvailableContactsController.removeContactFromList(map["key"]);
            updateAvailableContactsOnMap();
            break;

          case Geofire.onKeyMoved:
                      NearbyAvailableContactsController.nearByAvailableContactsList=getAvailableContacts();

            // NearbyAvailableContacts nearbyAvailableContacts =
            //     NearbyAvailableContacts();
            // nearbyAvailableContacts.key = (map["key"]);
            // nearbyAvailableContacts.latitude = map['latitude'];
            // nearbyAvailableContacts.longitude = map['longitude'];
            for(var person in NearbyAvailableContactsController.nearByAvailableContactsList){
            NearbyAvailableContactsController.updateContactNearbyLocation(
                person);
            updateAvailableContactsOnMap();
            }
            // Update your key's location
            break;

          case Geofire.onGeoQueryReady:
            // All Intial Data is loaded
            updateAvailableContactsOnMap();

            break;
        }
      }

      setState(() {});
    });
  }
List<NearbyAvailableContacts> getAvailableContacts(){
  List<Contact>listOfContacts=Provider.of<ContactsController>(context,listen:false).contacts;
  NearbyAvailableContacts nearByContacts= NearbyAvailableContacts();
  List<NearbyAvailableContacts>listNearByContacts= [];
  for(var person in listOfContacts){
    nearByContacts.key=person.id;
    nearByContacts.latitude=person.latitude;
    nearByContacts.longitude=person.longitude;
    listNearByContacts.add(nearByContacts);
    print("here is personId "+ person.id!);

  }
  return listNearByContacts;
}
void updateAvailableContactsOnMap() {
    setState(() {
      markersSet.clear();
    });

    Set<Marker> tMakers = Set<Marker>();
    for (NearbyAvailableContacts contact
        in NearbyAvailableContactsController.nearByAvailableContactsList) {
      LatLng driverAvaiablePosition =
          LatLng(contact.latitude!, contact.longitude!);

      Marker marker = Marker(
        markerId: MarkerId('contact${contact.key}'),
        position: driverAvaiablePosition,
        icon: nearByIcon!,
        //rotation: AssistantMethods.createRandomNumber(360),
      );

      tMakers.add(marker);
    }
    setState(() {
      markersSet = tMakers;
    });
  }
}
