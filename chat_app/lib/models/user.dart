import 'package:flutter/material.dart';
class User with ChangeNotifier{
  String? userID;

  String? name;
  String? email;
  String? phone;
  String? image;
  String? city;
  String? state;
  String? street;
  int? zipCode;
  double? lat;
  double? lgt;

  User({
    this.userID,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.lat,
    this.lgt,
    this.city,
    this.state,
    this.street,
    this.zipCode,
    
  });

}