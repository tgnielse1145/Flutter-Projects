import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:uguard_app/models/address.dart';

const GOOGLE_API_KEY ='AIzaSyDFuJnXrGg1179H6ALtyaafUBB_Z7v0nhE';

class LocationController extends ChangeNotifier {
  static String generateLocationPreviewImage({required double latitude, required double longitude,}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
   var url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');

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
      String placeAddress = extractedData["results"][0]["formatted_address"];
      return placeAddress;
    } catch (error) {
      print(error);
      throw (error);
    }
  
  }
  static Future<dynamic>getRequest(String _url)async{
    var url = Uri.parse(_url);
    http.Response response=await http.get(url);
    try{
      if(response.statusCode==200){
        String jSonData=response.body;
        var decodeData=json.decode(jSonData);
        return decodeData;
      }
      else{
        return "failed";
      }

    }catch(exp){
        return 'failed';
    }
  }
  void updateDropOffLocationAddress(Address address){

    Address dropOff=address;
    notifyListeners();
  }
}