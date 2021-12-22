import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class User with ChangeNotifier{
  String? userID;

  String? name;
  String? userName;
  String? email;
  String? phone;
  String? city;
  String? state;
  String? street;
  String? postalCode;
  double? lat;
  double? lgt;
  String? profilePic;

  User({
    this.userID,
    this.name,
    this.userName,
    this.email,
    this.phone,
    this.lat,
    this.lgt,
    this.city,
    this.state,
    this.street,
    this.postalCode,
    this.profilePic,
    
  });
  
Map<String, dynamic> toJson(){
  return {
    'userID': this.userID,
     'name':this.name,
     'userName':this.userName,
    'email':this.email,
    'phone':this.phone,
    'lat':this.lat,
    'lgt':this.lgt,
    'city':this.city,
    'state':this.state,
    'street':this.street,
    'postalCode':this.postalCode,
    'profilePic':this.profilePic,

  };
}
factory User.fromJson(Map<String,dynamic>parsedJson){
  return User(
    userID: parsedJson['userID']?? '',
    name: parsedJson['name']??'',
    userName: parsedJson['userName']??'',
    email: parsedJson['email']?? '',
    phone: parsedJson['phone'] ?? '',
    lat: parsedJson['lat']??'',
    lgt: parsedJson['lgt']??'',
    city:parsedJson['city']??'',
    state:parsedJson['state']?? '',
    street:parsedJson['street']??'',
    postalCode:parsedJson['postalCode']??'',
    profilePic:parsedJson['profilePic']??'',

     );

}
}