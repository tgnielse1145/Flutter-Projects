import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  String email;

  String firstName;

  String lastName;

  UserSettings settings;

  String phoneNumber;

  bool active;

  Timestamp lastOnlineTimestamp;

  String userID;

  String profilePictureURL;

  String appIdentifier;

  String fcmToken;

  bool? isVip;

  bool isAdmin;

  List<dynamic> likedListingsIDs;

  List<dynamic> photos;

  //internal use only, don't save to db
  bool selected = false;

  User({
    this.email = '',
    this.userID = '',
    this.profilePictureURL = '',
    this.firstName = '',
    this.phoneNumber = '',
    this.lastName = '',
    this.active = false,
    lastOnlineTimestamp,
    settings,
    this.fcmToken = '',
    this.isVip = false,
    this.isAdmin = false,
    this.likedListingsIDs = const [],
    this.photos = const [],
  })  : this.appIdentifier = 'Flutter Universal Listing ${Platform.operatingSystem}',
        this.lastOnlineTimestamp = lastOnlineTimestamp ?? Timestamp.now(),
        this.settings = settings ?? UserSettings();

  String fullName() {
    return '$firstName $lastName';
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        active: parsedJson['active'] ?? false,
        lastOnlineTimestamp: parsedJson['lastOnlineTimestamp'],
        settings: parsedJson.containsKey('settings')
            ? UserSettings.fromJson(parsedJson['settings'])
            : UserSettings(),
        phoneNumber: parsedJson['phoneNumber'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '',
        fcmToken: parsedJson['fcmToken'] ?? '',
        isVip: parsedJson['isVip'] ?? false,
        isAdmin: parsedJson['isAdmin'] ?? false,
        likedListingsIDs: parsedJson['likedListingsIDs'] ?? [],
        photos: parsedJson['photos'] ?? [].cast<String>());
  }

  factory User.fromPayload(Map<String, dynamic> parsedJson) {
    return new User(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        active: parsedJson['active'] ?? false,
        lastOnlineTimestamp:
            Timestamp.fromMillisecondsSinceEpoch(parsedJson['lastOnlineTimestamp']),
        settings: parsedJson.containsKey('settings')
            ? UserSettings.fromJson(parsedJson['settings'])
            : UserSettings(),
        phoneNumber: parsedJson['phoneNumber'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '',
        fcmToken: parsedJson['fcmToken'] ?? '',
        isVip: parsedJson['isVip'],
        isAdmin: parsedJson['isAdmin'],
        likedListingsIDs: parsedJson['likedListingsIDs'] ?? [],
        photos: parsedJson['photos'] ?? [].cast<String>());
  }

  Map<String, dynamic> toJson() {
    photos.toList().removeWhere((element) => element == null);
    return {
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'settings': this.settings.toJson(),
      'phoneNumber': this.phoneNumber,
      'id': this.userID,
      'active': this.active,
      'lastOnlineTimestamp': this.lastOnlineTimestamp,
      'profilePictureURL': this.profilePictureURL,
      'appIdentifier': appIdentifier,
      'fcmToken': this.fcmToken,
      'isVip': this.isVip,
      'isAdmin': this.isAdmin,
      'likedListingsIDs': this.likedListingsIDs,
      'photos': this.photos,
    };
  }

  Map<String, dynamic> toPayload() {
    photos.toList().removeWhere((element) => element == null);
    return {
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'settings': this.settings.toJson(),
      'phoneNumber': this.phoneNumber,
      'id': this.userID,
      'active': this.active,
      'lastOnlineTimestamp': this.lastOnlineTimestamp.millisecondsSinceEpoch,
      'profilePictureURL': this.profilePictureURL,
      'appIdentifier': this.appIdentifier,
      'fcmToken': this.fcmToken,
      'isVip': this.isVip,
      'isAdmin': this.isAdmin,
      'likedListingsIDs': this.likedListingsIDs,
      'photos': this.photos,
    };
  }
}

class UserSettings {
  bool pushNewMessages;

  UserSettings({this.pushNewMessages = true});

  factory UserSettings.fromJson(Map<dynamic, dynamic> parsedJson) {
    return new UserSettings(pushNewMessages: parsedJson['pushNewMessages'] ?? true);
  }

  Map<String, dynamic> toJson() {
    return {'pushNewMessages': this.pushNewMessages};
  }
}
