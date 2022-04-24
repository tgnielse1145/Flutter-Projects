import 'package:cloud_firestore/cloud_firestore.dart';

class ListingModel {
  String authorID;

  String authorName;

  String authorProfilePic;

  String categoryID;

  String categoryPhoto;

  String categoryTitle;

  Timestamp createdAt;

  String description;

  Map<String, dynamic> filters;

  String id;

  bool isApproved;

  double latitude;

  double longitude;

  String photo;

  List<dynamic> photos;

  String place;

  String price;

  num reviewsCount;

  num reviewsSum;

  String title;

  //internal use only, don't save to db
  bool isFav = false;

  ListingModel(
      {this.authorID = '',
      this.authorName = '',
      this.authorProfilePic = '',
      this.categoryID = '',
      this.categoryPhoto = '',
      this.categoryTitle = '',
      createdAt,
      this.description = '',
      this.filters = const {},
      this.id = '',
      this.isApproved = false,
      this.latitude = 0.1,
      this.longitude = 0.1,
      this.photo = '',
      this.photos = const [],
      this.place = '',
      this.price = '',
      this.reviewsCount = 0,
      this.reviewsSum = 0,
      this.title = ''})
      : this.createdAt = createdAt ?? Timestamp.now();

  factory ListingModel.fromJson(Map<String, dynamic> parsedJson) {
    return ListingModel(
      authorID: parsedJson['authorID'] ?? '',
      authorName: parsedJson['authorName'] ?? '',
      authorProfilePic: parsedJson['authorProfilePic'] ?? '',
      categoryID: parsedJson['categoryID'] ?? '',
      categoryPhoto: parsedJson['categoryPhoto'] ?? '',
      categoryTitle: parsedJson['categoryTitle'] ?? '',
      createdAt: parsedJson['createdAt'] is Timestamp
          ? parsedJson['createdAt']
          : Timestamp(parsedJson['createdAt']['_seconds'] ?? 0,
              parsedJson['createdAt']['_nanoseconds'] ?? 0 ?? Timestamp.now()),
      description: parsedJson['description'] ?? '',
      filters: parsedJson['filters'] ?? Map(),
      id: parsedJson['id'] ?? '',
      isApproved: parsedJson['isApproved'] ?? false,
      latitude: parsedJson['latitude'] ?? 0.1,
      longitude: parsedJson['longitude'] ?? 0.1,
      photo: parsedJson['photo'] ?? '',
      photos: parsedJson['photos'] ?? [],
      place: parsedJson['place'] ?? '',
      price: parsedJson['price'] ?? '',
      reviewsCount: parsedJson['reviewsCount'] ?? 0,
      reviewsSum: parsedJson['reviewsSum'] ?? 0,
      title: parsedJson['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authorID': this.authorID,
      'authorName': this.authorName,
      'authorProfilePic': this.authorProfilePic,
      'categoryID': this.categoryID,
      'categoryPhoto': this.categoryPhoto,
      'categoryTitle': this.categoryTitle,
      'createdAt': this.createdAt,
      'description': this.description,
      'filters': this.filters,
      'id': this.id,
      'isApproved': this.isApproved,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'photo': this.photo,
      'photos': this.photos,
      'place': this.place,
      'price': this.price,
      'reviewsCount': this.reviewsCount,
      'reviewsSum': this.reviewsSum,
      'title': this.title,
    };
  }
}
