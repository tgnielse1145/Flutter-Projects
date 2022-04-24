import 'package:cloud_firestore/cloud_firestore.dart';

class ListingReviewModel {
  String authorID;

  String content;

  Timestamp createdAt;

  String firstName;

  String lastName;

  String listingID;

  String profilePictureURL;

  double starCount;

  ListingReviewModel(
      {this.authorID = '',
      this.content = '',
      createdAt,
      this.firstName = '',
      this.lastName = '',
      this.listingID = '',
      this.profilePictureURL = '',
      this.starCount = 0})
      : this.createdAt = createdAt ?? Timestamp.now();

  String fullName() => '$firstName $lastName';

  factory ListingReviewModel.fromJson(Map<String, dynamic> parsedJson) {
    return ListingReviewModel(
        authorID: parsedJson['authorID'] ?? '',
        content: parsedJson['content'] ?? '',
        createdAt: parsedJson['createdAt'] ?? Timestamp.now(),
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        listingID: parsedJson['listingID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '',
        starCount: parsedJson['starCount'] ?? 0.0);
  }

  Map<String, dynamic> toJson() {
    return {
      'authorID': this.authorID,
      'content': this.content,
      'createdAt': this.createdAt,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'listingID': this.listingID,
      'profilePictureURL': this.profilePictureURL,
      'starCount': this.starCount
    };
  }
}
