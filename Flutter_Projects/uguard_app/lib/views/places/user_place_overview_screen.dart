import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:uguard_app/controllers/push_notification_controller.dart';
import 'package:uguard_app/models/configMaps.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uguard_app/models/nearby_available_contacts.dart';
import 'package:uguard_app/controllers/nearby_available_contacts_controller.dart';
import 'package:uguard_app/models/contact.dart';
import 'package:uguard_app/controllers/contacts_controller.dart';
import 'package:uguard_app/models/uguarduser.dart';

DatabaseReference userRequestRef = FirebaseDatabase.instance
    .reference()
    .child("users")
    .child(currentfirebaseUser!)
    .child("newRequest");
//DatabaseReference driversRef = FirebaseDatabase.instance.reference().child("drivers");

DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child("users");
//DatabaseReference rideRequestRef = FirebaseDatabase.instance.reference().child("drivers").child(currentfirebaseUser.uid).child("newRide");

class UserPlaceOverviewScreen extends StatefulWidget {
  static const routeName = '/user-place-overview';
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _UserPlaceOverviewScreenState createState() =>
      _UserPlaceOverviewScreenState();
}

class _UserPlaceOverviewScreenState extends State<UserPlaceOverviewScreen> {
  bool isUserAvailable = false;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  String displayAddress = '123 fart street';
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Position? currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;
  double rideDetailsContainerHeight = 0;
  double requestRideContainerHeight = 0;
  double searchContainerHeight = 300.0;
  double driverDetailsContainerHeight = 0;

  bool drawerOpen = true;
  bool nearbyAvailableContactKeysLoaded = false;

  //DatabaseReference rideRequestRef;

  BitmapDescriptor? nearByIcon;//=createIconMarker();
  List<NearbyAvailableContacts>? availableContacts;
  //NearbyAvailableContacts nearByContacts= NearbyAvailableContacts();

  String state = "normal";

  StreamSubscription<Event>? userStreamSubscription;

  bool isRequestingPositionDetails = false;

  String uName = "";

void getContactInfo() async {   
    ///get the current users id from firebase
    
userRef.child(currentfirebaseUser!).once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        UguardUser contact = UguardUser.fromSnapshot(dataSnapshot);
      }
    });
    // PushNotificationController pushNotifications = PushNotificationController();
    // pushNotifications.initialize(context);
    // pushNotifications.getToken();
  }
///
  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    isUserAvailable = true;
     updateAvailableContactsOnMap();
    initGeoFireListener();
    if(currentfirebaseUser!=null){
      print('currentfirebaseUser='+ currentfirebaseUser!);

    }
    else{
      print('currentFirebaseUser = null');
    }
  }

  @override
  void initState() {
    super.initState();
    getContactInfo();
  }

  @override
  Widget build(BuildContext context) {
    createIconMarker();
    return Stack(children: [
      GoogleMap(
        padding: EdgeInsets.only(bottom: bottomPaddingOfMap, top: 25.0),
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        initialCameraPosition: UserPlaceOverviewScreen._kGooglePlex,
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
        },
      ),
      Container(
        alignment: Alignment.topCenter,
        child: ElevatedButton(
          onPressed: makeUserOnlineNow,
          child: Text(
            'user online',
            style:
                TextStyle(backgroundColor: Colors.black, color: Colors.white),
          ),
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: getLocationLiveUpdates,
          child: Text(
            'get live updates',
            style:
                TextStyle(backgroundColor: Colors.black, color: Colors.white),
          ),
        ),
      ),
     
    ]);
  }

  void makeUserOnlineNow() async {
    if (currentfirebaseUser == null) {
      print('currentfirebaseUser is null');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    try {
      Geofire.initialize("availableContacts");
      Geofire.setLocation(currentfirebaseUser!, currentPosition!.latitude,
          currentPosition!.longitude);
      userRequestRef.set("searching");
      userRequestRef.onValue.listen((event) {});
    } catch (error) {
      throw (error);
    }
    //DatabaseReference userRequestRef = FirebaseDatabase.instance.reference().child("users").child(currentfirebaseUser!).child("newRequest");
    // DatabaseReference userRequestRef = FirebaseDatabase.instance.reference().child("fart");//.child(currentfirebaseUser!).child("newRequest");

    // userRequestRef.set("searching");
    // userRequestRef.onValue.listen((event) {

    //  });
  }

  void getLocationLiveUpdates() async {
    userOverviewScreenStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;
      if (isUserAvailable == true) {
        Geofire.setLocation(
            currentfirebaseUser!, position.latitude, position.longitude);
      }
      LatLng latLng = LatLng(position.latitude, position.longitude);
      newGoogleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  void initGeoFireListener() {
    Geofire.initialize("availableContacts");
//display nearby drivers within a 75km radius of the given latitude and longitue
//the currentPosition.latitude represents the current latitude of the current user same goes for the longitude
    Geofire.queryAtLocation(
            currentPosition!.latitude, currentPosition!.longitude, 20)!
        .listen((map) {
      print(map);
      if (map != null) {
        var callBack = map['callBack'];

        //latitude will be retrieved from map['latitude']
        //longitude will be retrieved from map['longitude']
        //the key is the  id from the database, the id is equal to the userId?
        switch (callBack) {
          case Geofire.onKeyEntered:
            NearbyAvailableContactsController.nearByAvailableContactsList =
                getAvailableContacts();

            if (NearbyAvailableContactsController
                    .nearByAvailableContactsList.length >
                0) {
              //if (nearbyAvailableContactKeysLoaded == true) {
              updateAvailableContactsOnMap();
            }
            //     NearbyAvailableContacts();
            // nearbyAvailableContacts.key = (map["key"]);
            // nearbyAvailableContacts.latitude = map['latitude'];
            // nearbyAvailableContacts.longitude = map['longitude'];
            // NearbyAvailableContactsController.nearByAvailableContactsList
            //     .add(nearbyAvailableContacts);
            break;

          case Geofire.onKeyExited:
            NearbyAvailableContactsController.removeContactFromList(map["key"]);
            print("here is the map[key] " + map["key"].toString());
            updateAvailableContactsOnMap();
            break;

          case Geofire.onKeyMoved:
            NearbyAvailableContactsController.nearByAvailableContactsList =
                getAvailableContacts();

            for (var person in NearbyAvailableContactsController
                .nearByAvailableContactsList) {
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

  List<NearbyAvailableContacts> getAvailableContacts() {
    List<Contact> listOfContacts =
        Provider.of<ContactsController>(context, listen: false).contacts;
    NearbyAvailableContacts nearByContacts = NearbyAvailableContacts();
    List<NearbyAvailableContacts> listNearByContacts = [];
    for (var person in listOfContacts) {
      nearByContacts.key = person.id;
      nearByContacts.latitude = person.latitude;
      nearByContacts.longitude = person.longitude;
      listNearByContacts.add(nearByContacts);
      print("here is personId " + person.id!);
      print("here is person.name " + person.name!);
      print("here is person.latitude " + person.latitude.toString());
    }
    return listNearByContacts;
  }

  

  void updateAvailableContactsOnMap() {
    setState(() {
      markersSet.clear();
    });

   // Set<Marker> tMakers = Set<Marker>();
    Set<Marker> contMarkers = Set<Marker>();
    // if(NearbyAvailableContactsController.nearByAvailableContactsList.length==0){
    //   print("list is empty");
    //    NearbyAvailableContactsController.nearByAvailableContactsList=getAvailableContacts();

    // }

    List<Contact> contList =
        Provider.of<ContactsController>(context, listen: false).contacts;
    if (contList.isNotEmpty) {
      for (var contData in contList) {
        if(contData.latitude!=null && contData.longitude!=null){
        LatLng contPosition = LatLng(contData.latitude!, contData.longitude!);
        Marker cMarker = Marker(
          markerId: MarkerId('contact${contData.id}'),
          position: contPosition,
          infoWindow: InfoWindow(
            title: 'HELLO MY NAME IS ${contData.name}',
          ),
          // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          icon: nearByIcon!,
        );
        contMarkers.add(cMarker);
        }
      }
    } else {
      LatLng contPosition =
          LatLng(currentPosition!.latitude, currentPosition!.longitude);
      Marker cMarker = Marker(
        markerId: MarkerId('contact$currentfirebaseUser'),
        position: contPosition,
        infoWindow: InfoWindow(
          title: 'HELLO MY NAME IS $currentfirebaseUserId',
        ),
        // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        icon: nearByIcon!,
      );
      contMarkers.add(cMarker);
    }
    setState(() {
      markersSet = contMarkers;
    });
    //   for (NearbyAvailableContacts contact
    //       in NearbyAvailableContactsController.nearByAvailableContactsList) {
    //     LatLng contactAvailablePosition =
    //         LatLng(contact.latitude!, contact.longitude!);

    //     Marker marker = Marker(
    //       markerId: MarkerId('contact${contact.key}'),
    //       position: contactAvailablePosition,
    //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    //       // rotation: createRandomNumber(360),
    //     );

    //     tMakers.add(marker);
    //   }
    //   setState(() {
    //  // markersSet.add(tMakers.elementAt(0));
    //     markersSet = tMakers;
    //   });
  }

  void createIconMarker() {
    ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context, size: Size(2, 2));
    BitmapDescriptor.fromAssetImage(
            imageConfiguration, "assets/images/uGuardBitMap.png")
        .then((value) {
      nearByIcon = value;
    });
  }
}
