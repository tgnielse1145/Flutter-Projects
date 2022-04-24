import 'dart:convert';

import 'package:flutter_qcabtaxi/core/constants/app_contstants.dart';
import 'package:flutter_qcabtaxi/core/models/distance.dart';
import 'package:flutter_qcabtaxi/core/models/geoobj.dart';
import 'package:flutter_qcabtaxi/core/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Api {
  var endpoint = "";
  var client = new http.Client();

  //=========================================================================================== <GG Map>
  static const GOOGLE = "";

  Future<List<Results>> gg_search_place(String keyword) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
            Constants.keyMap +
            "&language=vi&region=VN&query=" +
            Uri.encodeQueryComponent(keyword);
    print("search >>: " + url);
    var res = await http.get(url);
    print("res " + json.decode(res.body).toString());
    if (res.statusCode == 200) {
      PlaceItemRes placeItemRes = PlaceItemRes.fromJson(json.decode(res.body));
      return placeItemRes.results;
    } else {
      return new List();
    }
  }

  Future<String> gg_find_nameplace(LatLng latLng) async {
    String url = "https://maps.googleapis.com/maps/api/geocode/json?key=" +
        Constants.keyMap +
        "&latlng=" +
        latLng.latitude.toString() +
        "," +
        latLng.longitude.toString();
    print("findnameplace >>: " + url);
    var res = await http.get(url);
    print("res " + json.decode(res.body).toString());
    if (res.statusCode == 200) {
      Geoobj geoobj = Geoobj.fromJson(json.decode(res.body));
      return geoobj.results[0].formattedAddress;
    } else {
      return "";
    }
  }

  Future<DistanttimeObj> gg_distanttime(LatLng latLng1, LatLng latLng2) async {
    String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?key=" +
            Constants.keyMap +
            "&origins=" +
            latLng1.latitude.toString() +
            "," +
            latLng1.longitude.toString() +
            "&destinations=" +
            latLng2.latitude.toString() +
            "," +
            latLng2.longitude.toString();
    print("gg_distanttime >>: " + url);
    var res = await http.get(url);
    print("res " + json.decode(res.body).toString());
    if (res.statusCode == 200) {
      DistanttimeObj distanttimeObj =
      DistanttimeObj.fromJson(json.decode(res.body));
      return distanttimeObj;
    } else {
      return null;
    }
  }


}