import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/user.dart';


class FirebaseUtil {
  
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  ///
  static Future<String?> firebaseCreateNewUser(User user) async =>
      await firestore
          .collection(USERS)
          .doc(user.userID)
          .set(user.toJson())
          .then((value) => null, onError: (e) => e);

  ///
  static createNewUser(String? _email, String? _password) async{
     //  FirebaseFirestore firestore = FirebaseFirestore.instance;
     print('why wont this work ' + _email!);
  try {
      // auth.UserCredential result =
        await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email, password: _password!);
              //print(result.user!.uid);
  }catch(error){
    return;
  }
  }

  static signUpUserWithEmailAndPassword(User user, String _password) async {
     //  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
    try {
      // auth.UserCredential result = await auth.FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(
      //         email: user.email!, password: _password);

              await FirebaseFirestore.instance.collection(USERS)
          .doc(user.userID)
          .set(user.toJson());
         // .then((value) => null, onError: (e) => e);
     // String? errorMessage = await firebaseCreateNewUser(user);
      // if (errorMessage == null) {
      //   return user;
      // } else {
      //   return 'Couldn\'t create new user with phone number.';
      // }
     } on auth.FirebaseAuthException catch (error) {
      
       
      print(error.toString() + '${error.stackTrace}');
      String message = 'Couldn\'t sign up';
      switch (error.code) {
        case 'email-already-in-use':
          message = 'Email already in use, Please pick another email!';
          break;
        case 'invalid-email':
          message = 'Enter valid e-mail';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          message = 'Password must be more than 5 characters';
          break;
        case 'too-many-requests':
          message = 'Too many requests, Please try again later.';
          break;
      }
    //   //print(message);
      return message;
      
    }  catch (e) {
      //print(error);
      return;
    }
  }
  static Future<User?> getCurrentUser(String? uid) async {
    print('USER_ID '+ uid!);
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await firestore.collection(USERS).doc(uid).get();
    if (userDocument.exists) {
     
      return User.fromJson(userDocument.data() ?? {});
    } else {
      return null;
    }
  }
  static Future<User?> updateUser(User? user)async{
    return await firestore
    .collection(USERS)
    .doc(user!.userID)
    .set(user.toJson())
    .then((document){
      print('updated user');
      return user;
    }, onError: (e){
      return null;
    });
  
  }
  static Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firestore.collection(USERS).doc(result.user?.uid ?? '').get();
      User? user;
      if (documentSnapshot.exists) {
        user = User.fromJson(documentSnapshot.data() ?? {});
      
       // user.active = true;
       // user.fcmToken = await firebaseMessaging.getToken() ?? '';
        //await updateCurrentUser(user);
      }
      return user;
    } on auth.FirebaseAuthException catch (exception, s) {
      print(exception.toString() + '$s');
      switch ((exception).code) {
        case 'invalid-email':
          return 'Email address is malformed.';
        case 'wrong-password':
          return 'Wrong password.';
        case 'user-not-found':
          return 'No user corresponding to the given email address.';
        case 'user-disabled':
          return 'This user has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts to sign in as this user.';
      }
      return 'Unexpected firebase error, Please try again.';
    } catch (e, s) {
      print(e.toString() + '$s');
      return 'Login failed, Please try again.';
    }
  }
    static Future<List<User>> getAllUsers(String _id) async {
      print('getAllUsers '+ _id);
     List<User>users=[];
      await firestore.collection(USERS).get().then((onValue){
        Future.forEach(onValue.docs,
         (DocumentSnapshot<Map<String, dynamic>>document){
           if(document.id !=_id){
             users.add(User.fromJson(document.data()??{}));
           }
         });
      });
      print('USERS.LENGTH '+ users.length.toString());
return users;
          }
  
}
