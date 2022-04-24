import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uguard_app/models/uguarduser.dart';
import 'package:http/http.dart' as http;
import 'package:uguard_app/models/contact.dart';

class UserController with ChangeNotifier{
 List<UguardUser> _users = [];
 UguardUser _user=UguardUser(name: '', phone: '', email: '', );
final String? authToken;
final String? userId;


UserController(this.authToken,this.userId);

List<UguardUser> get users{
  return _users;
}
UguardUser findById(String? _id){
  return _users.firstWhere((element) =>element.id==_id);
}
String? userName;

String? get getUserName{
  return _user.name;
}
UguardUser get findByUser{
  return _user;
}
set profilePic(String? _profilePic){
  _user.profilePic=_profilePic;
}
   //add contacts
  Future<void> addUser(UguardUser user, String authToken) async {
    List<Contact>tempContacts=[];
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';
    var addFilterString = '/users/$userId.json';
    var params = {
      'auth': authToken,
    };
    print("authToken"+ authToken);
    var url = Uri.https(urlFirebase, addFilterString, params);
    try {
      final response = await http.put(
        url,
        body: json.encode({
          'id': user.id,
          'name': user.name,   

          'phone': user.phone,
          'email': user.email,
          'latitude':user.latitude,
          'longitude':user.longitude,
          'imageUrl':user.imageUrl,
          'userContacts':tempContacts
          .map((cont)=>{
            'id': '',
            'name': '',
            'email': '',
            'phone': '',

          }).toList(),       
        }),
      );
      // print(json.decode(response.body)); // generates a map wih a name key
      // final newUser = UguardUser(
      //     id: json.decode(response.body)['name'],
      //     name: user.name,
      //     phone: user.phone,
      //     email: user.email,      
      //     latitude: user.latitude,
      //     longitude: user.longitude,  
      //     imageUrl: user.imageUrl, 
      //    // userContacts: user.userContacts,  
      //     profilePic: user.profilePic,     
      //     );
      //    userName=user.name;
      //    _user=newUser;
      // _users.add(newUser);
      notifyListeners();
     
    } catch (error) {
      print(error);
      throw (error);
    }
    
  }
  Future<void>getUsersPic()async{
       var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';
    var addFilterString = '/users/$userId.json';
    var params = {
      'auth': authToken,
    };
        var url = Uri.https(urlFirebase, addFilterString, params);

    final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String?, dynamic>?;
      if(extractedData==null){
        print("extractedData in getUserFireBaseId was null");
        return;
      }
      
      UguardUser newUser=UguardUser(
        id:extractedData.entries.first.key,
        name:extractedData['name'],
        phone: extractedData['phone'],
        email:extractedData['email'],
        latitude:extractedData['latitude'],
        longitude:extractedData['longitude'],
        uguardUserId:extractedData['uguardUserId'],
       // userContacts: extractedData['userContacts'],
        profilePic: extractedData['profilePic'],

      );
      _user=newUser;;
  }
  Future<void> addEditedUser(UguardUser user) async {
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';
    var addFilterString = '/users/$userId.json';
    var params = {
      'auth': authToken,
    };
   // print("authToken"+ authToken!);
    var url = Uri.https(urlFirebase, addFilterString, params);
    try {
      final response = await http.put(
        url,
        body: json.encode({
          'id': user.id,
          'name': user.name,
          'phone': user.phone,
          'email': user.email,
          'latitude':user.latitude,
          'longitude':user.longitude,        
        }),
      );
      print(json.decode(response.body)); // generates a map wih a name key
      final newUser = UguardUser(
          id: json.decode(response.body)['name'],
          name: user.name,
          phone: user.phone,
          email: user.email,      
          latitude: user.latitude,
          longitude: user.longitude, 
        //  userContacts: user.userContacts         
          );
         userName=user.name;
      _users.add(newUser);
      notifyListeners();
     
    } catch (error) {
      print(error);
      throw (error);
    }
    
  }
   Future<void> updateUser(String id, UguardUser user) async {
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';

    var params = {
      'auth': authToken,
    };
    var idFilterString = '/$id.json';

    var url = Uri.https(urlFirebase, idFilterString, params);
    final userIndex = _users.indexWhere((cont) => cont.id == id);

    if (userIndex >= 0) {
      await http.patch(url,
         body: json.encode({
          'id': user.id,
          'name': user.name,
          'phone': user.phone,
          'email': user.email,
          'latitude':user.latitude,
          'longitude':user.longitude,        
        }));

      _users[userIndex] = user;
      notifyListeners();
    } else {
      print('....');
    }
  }
  Future<void> getUserFireBaseId([bool filterByUser = true]) async {
    print("here is getUserFireBaseId");
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';
    var fetchFilterString = '/users/$userId.json';
    var params = {
      'auth': authToken,
    //   'orderBy': '"uguardUserId"',
    //  'equalTo': '"$userId"',
    
    };
    var url = Uri.https(urlFirebase, fetchFilterString, params);
   
    try {
     
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String?, dynamic>?;
      if(extractedData==null){
        print("extractedData in getUserFireBaseId was null");
        return;
      }
      
      UguardUser newUser=UguardUser(
        id:extractedData.entries.first.key,
        name:extractedData.entries.first.value['name'],
        phone: extractedData.entries.first.value['phone'],
        email:extractedData.entries.first.value['email'],
        latitude:extractedData.entries.first.value['latitude'],
        longitude:extractedData.entries.first.value['longitude'],
        uguardUserId:extractedData.entries.first.value['uguardUserId'],
     //   userContacts: extractedData.entries.first.value['userContacts']

      );
      _users.add(newUser);
      
    } catch (error) {
      print(error);
      throw (error);
    }
  }
  Future<void>addProfilePic(UguardUser picUser)async{
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';

    var params = {
      'auth': authToken,
    };
    var idFilterString = '/users/$userId.json';

    var url = Uri.https(urlFirebase, idFilterString, params);

      await http.patch(url,
         body: json.encode({
         
          'profilePic':picUser.profilePic.toString(),      
        }
        ));

      notifyListeners();
   
  }
     Future<void> updateUserFireBaseId(String _currId,String fireBaseId, UguardUser newUser) async {
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';
    var fetchFilterString = '/users/$_currId.json';
    var params = {
      'auth': authToken,
    };
    var url = Uri.https(urlFirebase, fetchFilterString, params);
   final userIndex=_users.indexWhere((element) => element.id==_currId);
    try {

      if(userIndex>=0){
        await http.patch(url,
        body:json.encode({
           'id': newUser.id,
          'name': newUser.name,
          'phone': newUser.phone,
          'email': newUser.email,          
          'latitude': newUser.latitude,
          'longitude': newUser.longitude,          
          'uguardUserId': newUser.uguardUserId,
        }));
        _users[userIndex]=newUser;
      }   
     
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
    if(_users.length>0){
     for(var item in _users){
       if(item.id==userId){
         print('item.fireBaseId '+ item.uguardUserId.toString());
         return;
       }
       print('item.name '+ item.name.toString());

     }
    }
  }
 
}