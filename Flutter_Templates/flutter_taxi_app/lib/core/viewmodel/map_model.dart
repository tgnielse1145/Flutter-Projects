import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/constants/app_contstants.dart';
import 'package:flutter_qcabtaxi/core/constants/enum.dart';
import 'package:flutter_qcabtaxi/core/constants/mockdata.dart';
import 'package:flutter_qcabtaxi/core/models/placeobj.dart';
import 'package:flutter_qcabtaxi/core/utils/device_utils.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapModel extends ChangeNotifier {
  static const String MAP = "";

  CustomerStatus _customerstatus = CustomerStatus.none;
  LatLng _currentPosition, _destinationPosition, _pickupPosition;
  double currentZoom = 15;
  String _mapStyle;

  // Set of all the markers on the map
  final Set<Marker> _markers = Set();

  // Set of all the polyLines/routes on the map
  final Set<Polyline> _polyLines = Set();

  //final Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};
  // Pickup Predictions using Places Api, It is the list of Predictions we get from the textchanges the PickupText field in the mainScreen

  //Map Controller
  GoogleMapController _mapController;

  // Location Object to get current Location
  Location _location = Location();

  //Polyline patterns
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[], //line
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
    <PatternItem>[
      //dash-dot
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  LatLng get currentPosition => _currentPosition;

  LatLng get destinationPosition => _destinationPosition;

  Set<Marker> get markers => _markers;

  Set<Polyline> get polyLines => _polyLines;

  CustomerStatus get customerstatus => _customerstatus;

  init() {
    get_UserLocation();

    notifyListeners();
    /*_location.onLocationChanged().listen((event) async {
      _currentPosition = LatLng(event.latitude, event.longitude);
      notifyListeners();
    });*/
  }

  void get_UserLocation() async {
    _location.getLocation().then((data) async {
      _currentPosition = LatLng(data.latitude, data.longitude);
      _pickupPosition = _currentPosition;

      //LatLng tmp = LatLng(To['lat'], To['lng']);
      //_destinationPosition = tmp;
      updatePickupMarker(200);

      notifyListeners();
    });
  }

  ///Adding or updating Destination Marker on the Map
  updatePickupMarker(int size) async {
    if (currentPosition == null) return;
    markers.add(Marker(
        markerId: MarkerId(Constants.pickupMarkerId),
        position: currentPosition,
        draggable: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(
            await Utils.getBytesFromAsset("assets/icons/location.png", size))));
    notifyListeners();
  }

  updateDestinationMarker() async {
    if (destinationPosition == null) return;
    markers.add(Marker(
        markerId: MarkerId(Constants.destinationMarkerId),
        position: destinationPosition,
        draggable: true,
        //onDragEnd: onDestinationMarkerDragged,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(
            await Utils.getBytesFromAsset("assets/icons/icodes.png", 100))));
    notifyListeners();
  }

  ///Adding or updating Destination Marker on the Map
  updateCarDriverMarker(double lat, double lng, int id) async {
    LatLng latLng = LatLng(lat, lng);
    markers.add(Marker(
        markerId: MarkerId(id.toString()),
        position: latLng,
        draggable: true,
        //onDragEnd: onDestinationMarkerDragged,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(
            await Utils.getBytesFromAsset("assets/icons/iconcar.png", 200))));
    notifyListeners();
  }

  ///Creating a Route
  Future<void> createCurrentRoute() async {
    //LatLng _from = LatLng(fromobj.lat, fromobj.lng);
    //LatLng _to = LatLng(_toobj.lat, _toobj.lng);
    // _destinationPosition = _to;
    GoogleMapPolyline _googleMapPolyline =
        new GoogleMapPolyline(apiKey: Constants.keyDirectionMap);
    List<LatLng> _coordinates =
        await _googleMapPolyline.getCoordinatesWithLocation(
            origin: _currentPosition,
            destination: _destinationPosition,
            mode: RouteMode.driving);
    _polyLines.clear();
    PolylineId id = PolylineId("poly1");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: patterns[0],
        color: PrimaryColor,
        points: _coordinates,
        width: 3,
        onTap: () {});
    _polyLines.add(polyline);
    notifyListeners();
  }

  void onMyLocationFabClicked() {
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(
        currentPosition, 15.0 + Random().nextInt(4)));
  }

  /// when map is created
  Future<void> onMapCreated(GoogleMapController controller) async {
    await rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
      notifyListeners();
    });
    //print("_mapStyle: $_mapStyle");
    _mapController = controller;
    _mapController.setMapStyle(_mapStyle);
    notifyListeners();
  }

  /// listening to camera moving event
  void onCameraMove(CameraPosition position) {
    currentZoom = position.zoom;
    notifyListeners();
  }

  Future<void> selected_destination(FarPlaceObj farPlaceObj) {
    LatLng _to = LatLng(farPlaceObj.lat, farPlaceObj.lng);
    _destinationPosition = _to;
    _markers.clear();
    createCurrentRoute();
    updateDestinationMarker();
    updatePickupMarker(100);
    notifyListeners();
  }

  Future<void> go_book() {
    updateCarDriverMarker(cars[0]['lat'], cars[0]['lng'], 0);
    updateCarDriverMarker(cars[1]['lat'], cars[1]['lng'], 1);
    _customerstatus = CustomerStatus.book;
    notifyListeners();
  }
  Future<void> go_waiting() {
    _customerstatus = CustomerStatus.waiting;
    notifyListeners();
  }
  Future<void> go_onway() {
    _markers.clear();
    updatePickupMarker(100);
    updateDestinationMarker();
    updateCarDriverMarker(cars[1]['lat'], cars[1]['lng'], 1);
    //createCurrentRoute();
    _customerstatus = CustomerStatus.onway;
    notifyListeners();
  }

  Future<void> go_rating() {
    _customerstatus = CustomerStatus.rating;
    notifyListeners();
  }

  Future<void> reset() {
    _destinationPosition = null;
    _polyLines.clear();
    _markers.clear();
    updatePickupMarker(200);
    _customerstatus = CustomerStatus.none;
    notifyListeners();
  }
}
