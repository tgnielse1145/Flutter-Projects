import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:uguard_app/models/picture.dart';
import 'package:uguard_app/models/db_helper.dart';

class PictureProvider with ChangeNotifier{

  Picture? _profilePic;
  String? _title;
  String? _image;
  bool _isLoaded=false;

 bool get isLoaded{
  return _isLoaded;
}
 Picture? get profilePic{
  return _profilePic;
 }
 String? get title{
  return _title;
 }
 String? get image{
  return _image;
 }

 Future<void> addProfilePic(String? pickedTitle, String? pickedImage)async
  {
    final newProfilePic=Picture(
      id:DateTime.now().toString(),
      image:pickedImage,
      title: pickedTitle,
       );
      _profilePic=newProfilePic;  
     
       DBHelper.insert('pic',newProfilePic);
      notifyListeners();
     // DBHelper.insert('pic',newProfilePic);
            
  }
   Future<void> fetchAndSetProfilePic() async {
      final dataPic= await DBHelper.getData('pic');
        List<Picture>_items=dataPic.map((item)=>Picture(
         id: item['id'],
         title: item['title'],
         image:item['image'],
         ),
        ).toList();
       _profilePic=_items.first;
       notifyListeners();
    }
}