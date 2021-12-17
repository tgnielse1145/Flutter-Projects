import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
const GOOGLE_API_KEY = 'AIzaSyAAfQrwB2dKtjUIVxj4z8Fseq2n6_0XDtU';

class Address with ChangeNotifier {
  String? placeFormattedAddress;
  double? latitude;
  double? longitude;
  String? placeName;
  String? placeId;
  Address({this.placeFormattedAddress,this.placeName,this.placeId,this.latitude,this.longitude});
 
  double? get userLat {
    return latitude;
  }

  double? get userLgt {
    return longitude;
  }

  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat,double lng) async {
      
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
  }

  Future<void> getUserAddress() async {

    LocationPermission permission;
    permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        return Future.error('Location permissions are denied');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //Position currentPosition = position;
    double? lat = position.latitude;
    double? lng = position.longitude;
    //  user.latitude=lat;
    //  user.longitude=lng;
    latitude = position.latitude;
    longitude = position.longitude;
   
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
    //  String place_Address = extractedData["results"][0]["formatted_address"];
     // String pl = "";
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
     String pl = st1 + ", " + st2 + ", " + st3 + ", " + st4 + ", " + st5 + ", " + st6;
     print('Address = '+ pl);
      return; // pl;
    } catch (error) {
      print(error);
      throw (error);
    }
   
  }
  void updateDropOffLocationAddress(Address address){

    Address dropOff=address;
    notifyListeners();
  }
}
//   static Future<void> getDirections(double initLat, double initLgt,
//       double finalLat, double finalLgt) async {
//     var url = Uri.parse(
//         'https://maps.googleapis.com/maps/api/directions/json?origin=$initLat,$initLgt&destination=$finalLat,$finalLgt&key=$GOOGLE_API_KEY');
//     Map<String, String> header = {
//       'Content-Type': 'application/json',
//       'Charset': 'utf-8'
//     };
//     try {
//       final response = await http.get(url, headers: header);
//       final extractedData = json.decode(response.body);
//       if (extractedData == null) {
//         return; // "extractedData was null";
//       }
//       DirectionDetails directionDetails = DirectionDetails();

//       directionDetails.encodedPoints =
//           extractedData["routes"][0]["overview_polyline"]["points"];

//       directionDetails.distanceText =
//           extractedData["routes"][0]["legs"][0]["distance"]["text"];
//       directionDetails.distanceValue =
//           extractedData["routes"][0]["legs"][0]["distance"]["value"];

//       directionDetails.durationText =
//           extractedData["routes"][0]["legs"][0]["duration"]["text"];
//       directionDetails.durationValue =
//           extractedData["routes"][0]["legs"][0]["duration"]["value"];
//       List<LatLng> pLineCoordinates = [];
//      // Set<Polyline> polyLineSet = {};
//       PolylinePoints polylinePoints = PolylinePoints();
//       List<PointLatLng> decodedPolyLinePointsResult =
//           polylinePoints.decodePolyline(directionDetails.encodedPoints!);
//           if(decodedPolyLinePointsResult.isEmpty){
//             decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
//               pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
//              });
//           }
//           Polyline polyline= Polyline(
//             color: Colors.pink,
//             polylineId: PolylineId("PolylineID"),
//             jointType: JointType.round,
//             points: pLineCoordinates,
//             width: 5,
//             startCap: Cap.roundCap,
//             endCap: Cap.roundCap,
//             geodesic: true,);

//       print("encodedPoints = " + directionDetails.encodedPoints!);
//       print("distancetext = " + directionDetails.distanceText!);
//       print("directionvalue = " + directionDetails.distanceValue.toString());
//       print("durationtext = " + directionDetails.durationText!);
//       print("durationvalue = " + directionDetails.durationValue.toString());
//     } catch (error) {
//       print(error);
//       throw (error);
//     }
//   }
// }
