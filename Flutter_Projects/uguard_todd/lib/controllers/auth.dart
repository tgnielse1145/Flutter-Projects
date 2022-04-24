import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:uguard_app/models/configMaps.dart';
import 'package:uguard_app/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uguard_app/models/configMaps.dart';

class Auth with ChangeNotifier {
  String? _token; //expires after one hour
  DateTime? _expiryDate;
  String? _authUserId;
  Timer? _authTimer;
  String? _authUserEmail;
  bool _emailVerified = false;
  User? user;
  
bool get isAuth{
  return _token !=null;
}

bool get emailVerified{
  return _emailVerified;
}

String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }
  String? get userId {
    return _authUserId;
  }
  String? get userEmail{
    return _authUserEmail;
  }

// bool get emailVerified{
//   return _emailVerified;
// }
  Future<void> _authenticate(String email, String password, String urlSegment) async {
   
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyC4757uOGySvpbD_eix3tkmh6lqLsl4Q6o');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      
      //print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _authUserId = responseData['localId'];
      _authUserEmail=responseData['email'];
     
      print("_AUTHUSERID= "+ _authUserId.toString());
      print("_AUTHUSEREMAIL= "+ _authUserEmail.toString());
      print("_TOKEN= "+ _token.toString());
      currentfirebaseUser=_authUserId;

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
       _autoLogout();//set time to automatically logout after 
       notifyListeners();
      
       //shared preferences gives us access to on device key value pair 
      final prefs = await SharedPreferences.getInstance(); // gets a future 
      final userData = json.encode(
        {
          'token': _token,
          'userId': _authUserId,
          'userEmail':_authUserEmail,         
          //.toIso8601String() gives a date time string that is easy to work with and convet
          'expiryDate': _expiryDate!.toIso8601String(),
          
        },
      );
      ///userData is the key by which we will use to retrieve the userData that we encoded 
      ///using JSON.ENCODE
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
    
    
  }

  Future<void> signup(String email, String password) async {

    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
   // return
    _authenticate(email, password, 'signInWithPassword');
    
  }
  ///Returns a boolean because it shoudl signal whether we are successful or
  ///not when we try to auto login
  ///A future is used to represent a potential value, or error that will be available
  ///at some time in the future. Recieivers of a future can register callbacks
  ///that handle or error once it is available 
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    //see if the token has expired userData won't be there so it
    //won't be able to auto login 
    if (!prefs.containsKey('userData')) {
      ///this false will automatically be wrapped in a future cuz of the async
      ///
      return false;
    }
    //we can get data if might be expired but we can still get it 
    ///use JSON decode to convert it to a map 
    final extractedUserData = json.decode(prefs.getString('userData')!) as Map<String?, Object?>;
    ///check the date to see if it's still in the future
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']as String);
///if the date has expired returned false
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    ///now we know that we have valid data so we want to re-initialize the 
    ///the private variables from above i.e the _token, _expiryDate, _authUserId, 
    ///_authTime, _authUserEmail
    ///
    _token = extractedUserData['token']! as String?;
    _authUserId = extractedUserData['userId'] as String?;
    _authUserEmail=extractedUserData['userEmail'] as String?;
    _expiryDate = expiryDate;
    currentfirebaseUser=_authUserId;
    
    notifyListeners();
    ///call autoLogout to reset the timer that
    _autoLogout();
    ///return true
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _authUserId = null;
    _expiryDate = null;
    
    ///cancel any current timers before setting a new one 
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    ///need to clear the data in the sharedpreferences so that when the
    ///Consumer in the main.dart file doesn't rebuilt and auto-log the user
    ///back in, basically this will make the autoLogin function fail 
    prefs.clear();
  }
///set a timer that will expire when the timer expires token expires and
///then call logout for us 
  void _autoLogout() {
    ///if we have an existing timer cancel it before we set a new one
    ///
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    ///
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    ///Duration determines when it will expire, the logout function 
    ///will be executed when the timer expires 
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }   
  
}
