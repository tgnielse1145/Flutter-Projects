import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uguard_app/models/uguarduser.dart';
import 'package:http/http.dart' as http;

class UserController with ChangeNotifier{
 List<UguardUser> users = [];
final String? authToken;
final String? userId;


UserController(this.authToken,this.userId, this.users);

UguardUser? _user;

UguardUser? get currUser{
  return _user;
}
String? get currUserId{
  return userId;
}
UguardUser findById(String? _id){
  return users.firstWhere((element) =>element.id==_id);
}
String? userName;

String? get getUserName{
  return userName;
}
   //add contacts
  Future<void> addUser(UguardUser user) async {
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';
    var addFilterString = '/users/$userId.json';
    var params = {
      'auth': authToken,
    };
    print("authToken"+ authToken!);
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
          imageUrl: user.imageUrl        
          );
          print('bout to add to users');
      users.add(newUser);
      notifyListeners();
     
    } catch (error) {
      print(error);
      throw (error);
    }
    
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
          );
         userName=user.name;
      users.add(newUser);
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
    var idFilterString = '/users/$id.json';

    var url = Uri.https(urlFirebase, idFilterString, params);
    final userIndex = users.indexWhere((cont) => cont.id == id);

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

      users[userIndex] = user;
      notifyListeners();
    } else {
      print('....');
    }
  }
  Future<void> getAndSetUsers() async {
print('here is userid '+ userId!);    
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';
    var fetchFilterString = '/users.json';
    var params = {
      'auth': authToken,
       'orderBy': '"id"',
     'equalTo': '"$userId"',
    
    };
    var url = Uri.https(urlFirebase, fetchFilterString, params);
   
    try {
     
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String?, dynamic>?;
      if(extractedData==null){
        print("extractedData in getUserFireBaseId was null");
        return;
      }
      final List<UguardUser>loadedUsers=[];
      extractedData.forEach((userId,userData){
        loadedUsers.add(UguardUser(
          id:userId,
        name:userData['name'],
        phone: userData['phone'],
        email:userData['email'],
        latitude:userData['latitude'],
        longitude:userData['longitude'],
        uguardUserId:userData['uguardUserId'],
        imageUrl: userData['imageUrl'],
        ));
      });
   
     users=loadedUsers;
     notifyListeners();
      print('iam about to set _user to user');
     
      
    } catch (error) {
      print(error);
      throw (error);
    }
   
  }
     Future<void> updateUserFireBaseId(String _currId,String fireBaseId, UguardUser newUser) async {
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';
    var fetchFilterString = '/users/$_currId.json';
    var params = {
      'auth': authToken,
    };
    var url = Uri.https(urlFirebase, fetchFilterString, params);
   final userIndex=users.indexWhere((element) => element.id==_currId);
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
        users[userIndex]=newUser;
      }   
     
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
    if(users.length>0){
     for(var item in users){
       if(item.id==userId){
         print('item.fireBaseId '+ item.uguardUserId.toString());
         return;
       }
       print('item.name '+ item.name.toString());

     }
    }
  }
 
}