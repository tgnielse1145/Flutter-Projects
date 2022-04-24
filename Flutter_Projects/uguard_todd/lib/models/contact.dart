import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';

class Contact with ChangeNotifier {
  late final String? id;
  late final String? name;
  late final String? phone;
  late final String? email;
  late final String? imageUrl;
  late final bool? isFavorite;
  late final double? latitude;
  late final double? longitude;
  late final String? uguardUserId;
   List<String?>? fart;

  Contact({
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.email,
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.isFavorite,
    this.uguardUserId,
    this.fart,
  });

  Contact.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key;
    name = dataSnapshot.value['name'];
    phone = dataSnapshot.value['phone'];
    email = dataSnapshot.value['email'];
    latitude = dataSnapshot.value['latitude'];
    longitude = dataSnapshot.value['longitude'];
    imageUrl = dataSnapshot.value['imageUrl'];
    isFavorite = dataSnapshot.value['isFavorite'];
    uguardUserId=dataSnapshot.value['uguardUserId'];
  }
}
