import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uguard_app/models/place.dart';
import 'package:uguard_app/controllers/location_controller.dart';
import 'package:uguard_app/models/uguarduser.dart';

class PlacesController with ChangeNotifier {
  List<Place> _items = [];

final String? authToken;
final String? userId;

PlacesController(this.authToken, this.userId);
  List<Place> get items {
    return [..._items];
  }
Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
   String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  )  async {
    final address = await LocationController.getPlaceAddress(
        pickedLocation.latitude!, pickedLocation.longitude!);
    print("ADDRESS IS EQUAL TO "+ address);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    
  }
  Future<void> fetchAndSetPlaces() async {
    // final dataList = await DBController.getData('user_places');
    // _items = dataList
    //     .map(
    //       (item) => Place(
    //             id: item['id'],
    //             title: item['title'],
    //             image: File(item['image']),
    //             location: PlaceLocation(
    //               latitude: item['loc_lat'],
    //               longitude: item['loc_lng'],
    //               address: item['address'],
    //             ),
    //           ),
    //     )
    //     .toList();
    // notifyListeners();
  }

  Future<void> updatePlace(UguardUser user, String id) async{
  //   var urlFirebase = 'uguard-app-default-rtdb.firebaseio.com';

  //   var params = {
  //     'auth': authToken,
  //   };
  // var idFilterString = '/users/$id.json';

   // var url = Uri.https(urlFirebase, idFilterString, params);
  }

}
