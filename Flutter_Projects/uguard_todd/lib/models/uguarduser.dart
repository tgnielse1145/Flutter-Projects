import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';

class UguardUser with ChangeNotifier {
  String? id;
  String? uguardUserId;
  String? name;
  String? phone;
  String? email;
  String? imageUrl;
  bool? isFavorite;
  double? latitude;
  double? longitude;
  String? token;
  String? profilePic;
  // final late List<String?> userContacts;

  UguardUser({
     this.id,
    @required this.name,
    @required this.phone,
    @required this.email,
    this.uguardUserId, 
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.isFavorite,
    this.token,
    this.profilePic,
    //required userContacts,
   //this.userContacts
  });
  UguardUser.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key;
    name = dataSnapshot.value['name'];
    phone = dataSnapshot.value['phone'];
    email = dataSnapshot.value['email'];
    latitude = dataSnapshot.value['latitude'];
    longitude = dataSnapshot.value['longitude']; 
    imageUrl = dataSnapshot.value['imageUrl'];
    isFavorite = dataSnapshot.value['isFavorite'];
    uguardUserId=dataSnapshot.value['uguardUserId'];
   // userContacts=dataSnapshot.value['userContacts'];
    profilePic=dataSnapshot.value['profilePic'];
  }
}
