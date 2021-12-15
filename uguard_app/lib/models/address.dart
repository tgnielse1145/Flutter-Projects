import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uguard_app/models/direction_details.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
const GOOGLE_API_KEY = 'AIzaSyDFuJnXrGg1179H6ALtyaafUBB_Z7v0nhE';

class Address with ChangeNotifier {
  double? _latitude;
  double? _longitude;

  double? get userLat {
    return _latitude;
  }

  double? get userLgt {
    return _longitude;
  }

  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat,double lng) async {
   
   
    // var getPlaceString = 'maps.googleapis.com'; var addressFilterString ='/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };
    try {
      final response = await http.get(url, headers: header);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return "extractedData was null";
      }
      // String place_Address = extractedData["results"][0]["formatted_address"];
      String pl = "";
      String st1, st2, st3, st4, st5, st6;
      st1 = extractedData["results"][0]["address_components"][0]
          ["long_name"]; //street_number
      st2 = extractedData["results"][0]["address_components"][1]
          ["long_name"]; //route or street name
      st3 = extractedData["results"][0]["address_components"][2]
          ["long_name"]; //city or sublocality
      st4 = extractedData["results"][0]["address_components"][4]
          ["long_name"]; //state name or administrative_area_level_1
      st5 = extractedData["results"][0]["address_components"][5]
          ["long_name"]; //country
      st6 = extractedData["results"][0]["address_components"][6]
          ["long_name"]; //postal code
      pl = st1 + ", " + st2 + ", " + st3 + ", " + st4 + ", " + st5 + ", " + st6;
      return pl;
    } catch (error) {
      print(error);
      throw (error);
    }
    //   var url = Uri.https(getPlaceString,addressFilterString);//, unencodedPath)
    //   final response = await http.get(url);
    // //  return
    //   String placeAddress= json.decode(response.body)['results'][0]['formatted_address'];
    //   print("here is my address part 2 "+ placeAddress);
    //   return placeAddress;
  }

  Future<void> getUserAddress() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //Position currentPosition = position;
    double? lat = position.latitude;
    double? lng = position.longitude;
    //  user.latitude=lat;
    //  user.longitude=lng;
    _latitude = position.latitude;
    _longitude = position.longitude;
    //GoogleMapController? newGoogleMapController;
   // LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    // CameraPosition cameraPosition =
    //     new CameraPosition(target: latLngPosition, zoom: 14);
    //if(newGoogleMapController!)
    //newGoogleMapController!
    //  .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    // var getPlaceString = 'maps.googleapis.com'; var addressFilterString ='/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };
    try {
      final response = await http.get(url, headers: header);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return; // "extractedData was null";
      }
      // String place_Address = extractedData["results"][0]["formatted_address"];
      //String pl = "";
      // String st1, st2, st3, st4, st5, st6;
      // st1 = extractedData["results"][0]["address_components"][0]
      //     ["long_name"]; //street_number
      // st2 = extractedData["results"][0]["address_components"][1]
      //     ["long_name"]; //route or street name
      // st3 = extractedData["results"][0]["address_components"][2]
      //     ["long_name"]; //city or sublocality
      // st4 = extractedData["results"][0]["address_components"][4]
      //     ["long_name"]; //state name or administrative_area_level_1
      // st5 = extractedData["results"][0]["address_components"][5]
      //     ["long_name"]; //country
      // st6 = extractedData["results"][0]["address_components"][6]
      //     ["long_name"]; //postal code
     // String pl = st1 + ", " + st2 + ", " + st3 + ", " + st4 + ", " + st5 + ", " + st6;
      return; // pl;
    } catch (error) {
      print(error);
      throw (error);
    }
    //   var url = Uri.https(getPlaceString,addressFilterString);//, unencodedPath)
    //   final response = await http.get(url);
    // //  return
    //   String placeAddress= json.decode(response.body)['results'][0]['formatted_address'];
    //   print("here is my address part 2 "+ placeAddress);
    //   return placeAddress;
  }

  static Future<void> getDirections(double initLat, double initLgt,
      double finalLat, double finalLgt) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=$initLat,$initLgt&destination=$finalLat,$finalLgt&key=$GOOGLE_API_KEY');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };
    try {
      final response = await http.get(url, headers: header);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return; // "extractedData was null";
      }
      DirectionDetails directionDetails = DirectionDetails();

      directionDetails.encodedPoints =
          extractedData["routes"][0]["overview_polyline"]["points"];

      directionDetails.distanceText =
          extractedData["routes"][0]["legs"][0]["distance"]["text"];
      directionDetails.distanceValue =
          extractedData["routes"][0]["legs"][0]["distance"]["value"];

      directionDetails.durationText =
          extractedData["routes"][0]["legs"][0]["duration"]["text"];
      directionDetails.durationValue =
          extractedData["routes"][0]["legs"][0]["duration"]["value"];
      List<LatLng> pLineCoordinates = [];
     // Set<Polyline> polyLineSet = {};
      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> decodedPolyLinePointsResult =
          polylinePoints.decodePolyline(directionDetails.encodedPoints!);
          if(decodedPolyLinePointsResult.isEmpty){
            decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
              pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
             });
          }
          Polyline polyline= Polyline(
            color: Colors.pink,
            polylineId: PolylineId("PolylineID"),
            jointType: JointType.round,
            points: pLineCoordinates,
            width: 5,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            geodesic: true,);

      print("encodedPoints = " + directionDetails.encodedPoints!);
      print("distancetext = " + directionDetails.distanceText!);
      print("directionvalue = " + directionDetails.distanceValue.toString());
      print("durationtext = " + directionDetails.durationText!);
      print("durationvalue = " + directionDetails.durationValue.toString());
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
