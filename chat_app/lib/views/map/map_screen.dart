import 'dart:async';
import 'dart:convert';
import 'package:chat_app/views/drawer/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:chat_app/provider/firebase_util.dart';
import 'package:chat_app/models/user.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-screen';
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
   // target: LatLng(40.759689, -111.848555),
    zoom: 14.4746,
  );

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late User user;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<User> userList = [];
  List<User> contactList = [];
  final _auth = auth.FirebaseAuth.instance;

  bool isUserAvailable = false;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  String displayAddress = '123 main street';
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Position? currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;
  double rideDetailsContainerHeight = 0;
  double requestRideContainerHeight = 0;
  double searchContainerHeight = 300.0;
  double driverDetailsContainerHeight = 0;
  bool drawerOpen = true;
  bool nearbyAvailableContactKeysLoaded = false;
  BitmapDescriptor? nearByIcon;
  List<User>? availableContacts;
  String state = "normal";
 // StreamSubscription<Event>? userStreamSubscription;
  StreamSubscription<Position>? userOverviewScreenStreamSubscription;
  bool isRequestingPositionDetails = false;
  String uName = "";
  DatabaseReference userRequestRef = FirebaseDatabase.instance.ref();
  String? encodedPoints;
  String? distanceText;
  int? distanceValue;
  String? durationText;
  int? durationValue;

  User findById(String? ident) {
    return userList.firstWhere((cont) => cont.userID == ident);
  }

  @override
  void initState() {
    super.initState();
   // user = widget.user;
   getUserList();
  }

  void getContactInfo() async {
    userList.forEach((element) {
      // if (user.contacts.containsKey(element.userID)) {
      //   if (user.contacts.containsValue(true)) {
      //     contactList.add(findById(element.userID));
      //   }
      // }
    });
  }

  Future<void> getUserList() async {
    QuerySnapshot<Map<String, dynamic>> result =
        await firestore.collection('users').get();
    Future.forEach(result.docs,
        (QueryDocumentSnapshot<Map<String, dynamic>> element) {
      try {
        userList.add(User.fromJson(element.data())); //.contacts = MyAppState.

      } catch (e) {
        print('FireStoreUtils.getMyUserList failed to parse object '
            '${element.id} $e');
      }
    });
    // userList.forEach((element) {
    //   element.userID;
    // });
    print('USER_LIST3 '+ userList.length.toString());
    getContactInfo();
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    isUserAvailable = true;
    updateAvailableContactsOnMap();
    initGeoFireListener();
    
  }

  @override
  Widget build(BuildContext context) {

    createIconMarker();
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen',
        style: TextStyle(
          fontFamily: 'CandyCaneRegular',
          fontSize: 40
        ))
      ),
      drawer: MenuDrawer(),
      body:Stack(children: [
      GoogleMap(
        padding: EdgeInsets.only(bottom: bottomPaddingOfMap, top: 25.0),
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        initialCameraPosition: MapScreen._kGooglePlex,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        polylines: polylineSet,
        markers: markersSet,
        circles: circlesSet,
        onMapCreated: (GoogleMapController controller) {
          _controllerGoogleMap.complete(controller);
          newGoogleMapController = controller;

          locatePosition();
          getContactInfo();
         // getAvailableContacts();
         // getUserList();
        },
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          // width:deviceSize.width/3,
          alignment: Alignment.bottomLeft,
          child: ElevatedButton(
            onPressed: makeUserOnlineNow,
            child: const Text(
              'user online',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          // width: deviceSize.width/3,
          alignment: Alignment.bottomRight,

          child: ElevatedButton(
            onPressed: getLocationLiveUpdates,
            child: const Text(
              'get live updates',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          //width: deviceSize.width/3,
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: getDirections,
            child: const Text(
              'get directions',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    ]));
  }

  void makeUserOnlineNow() async {
   
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // currentPosition = position;

    // try {
    //   Geofire.initialize("availableContacts");
    //   Geofire.setLocation(
    //       user.userID, currentPosition!.latitude, currentPosition!.longitude);
    //   userRequestRef
    //       .child("users")
    //       .child(user.userID)
    //       .child("newRequest")
    //       .set("searching");
    //   // userRequestRef.set("searching");
    //   userRequestRef.onValue.listen((event) {});
    // } catch (error) {
    //   rethrow;
    // }
    
  }

  void getLocationLiveUpdates() async {
    // userOverviewScreenStreamSubscription =
    //     Geolocator.getPositionStream().listen((Position position) {
    //   currentPosition = position;
    //   if (isUserAvailable == true) {
    //     Geofire.setLocation(user.userID, position.latitude, position.longitude);
    //   }
    //   LatLng latLng = LatLng(position.latitude, position.longitude);
    //   newGoogleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
    // });
  }

  void initGeoFireListener() {
    Geofire.initialize("availableContacts");
    Geofire.queryAtLocation(
            currentPosition!.latitude, currentPosition!.longitude, 20)!
        .listen((map) {
      //  print(map);
      if (map != null) {
        var callBack = map['callBack'];

     
        switch (callBack) {
          case Geofire.onKeyEntered:
           
            if (contactList.isNotEmpty) {
              updateAvailableContactsOnMap();
            }

            break;

          case Geofire.onKeyExited:
            removeContactFromList(map["key"]);
            updateAvailableContactsOnMap();
            break;

          case Geofire.onKeyMoved:
            getAvailableContacts();

            for (var user in contactList) {
              updateContactLocation(user);
              updateAvailableContactsOnMap();
            }
           
            break;

          case Geofire.onGeoQueryReady:
            //   // All Intial Data is loaded
            updateAvailableContactsOnMap();

            break;
        }
      }

      setState(() {});
    });
  }

  void removeContactFromList(String key) {
   
    //int index = contactList.indexWhere((element) => element.userID == key);

  }

  void updateContactLocation(User use) {}

  List<User> getAvailableContacts() {
    String? _id = _auth.currentUser!.uid;
    List<User>listOfUsers=[];
    Future<List<User>> listOfContacts = FirebaseUtil.getAllUsers(_id);
    listOfContacts.then((value){
      if(value.isNotEmpty) value.forEach((element)=>listOfUsers.add(element));
    });
    print('listOfUsers.length '+ listOfUsers.length.toString());
    //List<User>listOfUsers= listOfContacts.
    // userList.forEach((element) {
    //   if (user.contacts.containsKey(element.userID)) {
    //     if (user.contacts.containsValue(true)) {
    //       print('it was TRUE');
    //       contactList.add(findById(element.userID));
    //     }
    //   }
    // });
    // if (contactList.length > 0) {
    // }
    // listOfContacts = contactList;
    
     return listOfUsers;
  }

  void updateAvailableContactsOnMap() {
    // setState(() {
    //   markersSet.clear();
    // });

    // // Set<Marker> tMakers = Set<Marker>();
    // Set<Marker> contMarkers = <Marker>{};
    
    // if (contactList.isNotEmpty) {
    //   for (var contData in contactList) {
    //     if (contData.lat != 0 && contData.lgt != 0) {
    //       LatLng contPosition = LatLng(contData.lat, contData.lgt);
    //       Marker cMarker = Marker(
    //         markerId: MarkerId('contact${contData.firstName}'),
    //         //markerId: MarkerId('bob'),
    //         position: contPosition,
    //         infoWindow: InfoWindow(
    //           title: 'Hello my name is ${contData.firstName}',
    //         ),
    //         // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    //         icon: nearByIcon!,
    //       );
    //       contMarkers.add(cMarker);
    //     }
    //   }
    // } else {
    //   LatLng contPosition =
    //       LatLng(currentPosition!.latitude, currentPosition!.longitude);
    //   Marker cMarker = Marker(
    //     markerId: MarkerId('user${user.firstName}'),
    //     // markerId: MarkerId('Hi my name is Slim Shady'),
    //     position: contPosition,
    //     infoWindow: InfoWindow(
    //       title: 'Hello my name is ${user.firstName}',
    //     ),
    //     // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    //     icon: nearByIcon!,
    //   );
    //   contMarkers.add(cMarker);
    // }
    // setState(() {
    //   markersSet = contMarkers;
    // });
  }

  void getDirections() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double finalLat = 40.76022;
    double finalLgt = -111.84883;
    double initLat = 41.2808;
    double initLgt = -111.983758;
   // print('USERlAT ='+ user.lat);
    var pickUpLatLng = LatLng(initLat, initLgt);
    var dropOffLatLng = LatLng(finalLat, finalLgt);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=$initLat,$initLgt&destination=$finalLat,$finalLgt&key=AIzaSyBPD5RqWQRtCvsBoTzUs6maD_7XBZZW2dg');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };

    try {
      final response = await http.get(url, headers: header);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return; 
      }

      encodedPoints = extractedData["routes"][0]["overview_polyline"]["points"];

      distanceText = extractedData["routes"][0]["legs"][0]["distance"]["text"];

      distanceValue =
          extractedData["routes"][0]["legs"][0]["distance"]["value"];

      durationText = extractedData["routes"][0]["legs"][0]["duration"]["text"];

      durationValue =
          extractedData["routes"][0]["legs"][0]["duration"]["value"];

    






      print("encodedPoints = " + encodedPoints!);
      print("distancetext = " + distanceText!);
      print("directionvalue = " + distanceValue.toString());
      print("durationtext = " + durationText!);
      print("durationvalue = " + durationValue.toString());
    } catch (error) {
      print(error);
      throw (error);
    }
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(encodedPoints!);

    pLineCoordinates.clear();
    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    polylineSet.clear(); //so that it knows were drawing new lines
    setState(() {
      Polyline polyline = Polyline(
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
    if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
        pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }
    newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow: InfoWindow(title: 'Home', snippet: "my Location"),
      position: pickUpLatLng,
      markerId: MarkerId("pickUpId"),
    );

    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow:
          InfoWindow(title: 'Rice Eccles Stadium', snippet: "DropOff Location"),
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
    newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
  }

  void createIconMarker() {
    ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context, size: const Size(2, 2));
    BitmapDescriptor.fromAssetImage(
            imageConfiguration, "assets/images/uGuardBitMap.png")
        .then((value) {
      nearByIcon = value;
    });
  }
}
