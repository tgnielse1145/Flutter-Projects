import 'dart:io';

class User {
  String email;

  String phone;

  String firstName;

  String lastName;

  String userName;

  String userID;

  Map<String, dynamic> contacts;

  Map<String, dynamic> dependents;

  String profilePictureURL;

  double lat;

  double lgt;

  String appIdentifier;

  String tokenId;

  User(
      {this.email = '',
      this.phone = '',
      this.firstName = '',
      this.lastName = '',
      this.userName = '',
      this.userID = '',
      this.contacts = const {},
      this.dependents = const {},
      this.tokenId = '',
      this.profilePictureURL = '',
      this.lat=0.0,
      this.lgt=0.0})
      : appIdentifier = Platform.operatingSystem;

  String fullName() => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'] ?? '',
        phone: parsedJson['phone'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        userName: parsedJson['userName'] ?? '',
        contacts: parsedJson['contacts']??'',
        dependents: parsedJson['dependents']??'',
        tokenId: parsedJson['tokenId']??'',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '',
        lat: parsedJson['lat']??0.0,
        lgt: parsedJson['lgt']?? 0.0,
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'contacts': contacts,
      'dependents': dependents,
      'id': userID,
      'tokenId': tokenId,
      'profilePictureURL': profilePictureURL,
      'lat':lat,
      'lgt':lgt,
      'appIdentifier': appIdentifier
    };
  }
}
