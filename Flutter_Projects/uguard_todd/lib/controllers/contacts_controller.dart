import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uguard_app/models/contact.dart';
import 'package:http/http.dart' as http;
import 'package:uguard_app/models/http_exception.dart';

//change notifier is kinda like inheritance in flutter it's called  a mixin
class ContactsController with ChangeNotifier {

  //the _ makes it "private"
  List<Contact> _contacts = [];

  final String? authToken;
  final String? userId;

  ContactsController(this.authToken, this.userId, this._contacts);

//getter for the private list of contacts
  List<Contact> get contacts {
    return [..._contacts];
  }

  //find the id that was passed in
  Contact findById(String? ident) {
    return _contacts.firstWhere((cont) => cont.id == ident);
  }
  List<Contact>get favoriteContacts{
    return _contacts.where((ct) =>ct.isFavorite!).toList(); 
  }
void showFavoritesOnly(){
  //_showFavoritesOnly=true;
}
// void _showAll(){
//  // _showFavoritesOnly=false;
// }
  //add contacts
  Future<void> addContacts(Contact contact) async {
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';
    var addFilterString = '/contacts.json';
    var params = {
      'auth': authToken,
    };
    var url = Uri.https(urlFirebase, addFilterString, params);
  
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'id': contact.id,
          'name': contact.name,
          'phone': contact.phone,
          'email': contact.email,
          'imageUrl': contact.imageUrl,
          'latitude': 40.759689,
          'longitude': -111.84855,
          'uguardUserId':userId,
        }),
      );

      final newContact = Contact(
          id: json.decode(response.body)['name'],
          name: contact.name,
          phone: contact.phone,
          email: contact.email,
          imageUrl: contact.imageUrl,
          latitude:contact.latitude,
          longitude: contact.longitude,
          uguardUserId:contact.uguardUserId,
          );
          
      _contacts.add(newContact);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }
  
  ///

  Future<void> getAndSetContacts([bool filterByUser = true]) async {
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';
    var fetchFilterString = '/contacts.json';

    var params = {
      'auth': authToken,
      'orderBy': '"uguardUserId"',
      'equalTo': '"$userId"',

    };
    var url = Uri.https(urlFirebase, fetchFilterString, params);
   
    try {
      print("here is getSetContacts ");
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String?, dynamic>?;
      if(extractedData==null){
        print("extractedData was null");
        return;
      }
      final List<Contact> loadedContacts = [];
      extractedData.forEach((contId, contData) {
        loadedContacts.add(Contact(
          id: contId,
          name: contData['name'],
          phone: contData['phone'],
          email: contData['email'],
          imageUrl: contData['imageUrl'],
          latitude: contData['latitude'],
          longitude: contData['longitude'],
          uguardUserId: contData['uguardUserId'],
        ));
      });
      _contacts = loadedContacts;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
   }
  }

  //update a contact
  Future<void> updateContacts(String id, Contact newContact) async {
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';

    var params = {
      'auth': authToken,
    };
    var idFilterString = '/contacts/$id.json';

    var url = Uri.https(urlFirebase, idFilterString, params);
    final contactIndex = _contacts.indexWhere((cont) => cont.id == id);

    if (contactIndex >= 0) {
      await http.patch(url,
          body: json.encode({        
            'name': newContact.name,
            'phone': newContact.phone,
            'email': newContact.email,
            'imageUrl': newContact.imageUrl,
            'latitude':newContact.latitude,
            'longitude':newContact.longitude,
          }));

      _contacts[contactIndex] = newContact;
      notifyListeners();
    } else {
      print('....');
    }
  }

  //delete a Contact
  Future<void> deleteContact(String id) async {
    var urlFirebase = 'uguard-todd-default-rtdb.firebaseio.com';
    var params = {
      'auth': authToken,
    };
    
    var delFilterString = '/contacts/$id.json';

    final url = Uri.https(urlFirebase, delFilterString,params);
    final existingContactsIndex = _contacts.indexWhere((cont) => cont.id == id);
    print('this is existingContactsIndex'+ existingContactsIndex.toString());
    print('contactID?'+_contacts[existingContactsIndex].id.toString());

    Contact? existingContact = _contacts[existingContactsIndex];
    _contacts.removeAt(existingContactsIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _contacts.insert(existingContactsIndex, existingContact);
      notifyListeners();
      throw HttpException('could not delete contact');
    }
    existingContact = null;
  }
}
