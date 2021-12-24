import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:chat_app/views/drawer/menu_drawer.dart';
import 'package:chat_app/provider/address.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/validate.dart';
import 'package:chat_app/provider/firebase_util.dart';

File? _image;


class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup-screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _form = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final _auth = auth.FirebaseAuth.instance;
  String? _name,
      _userName,
      _email,
      _phone,
      _city,
      _state,
      _street,
      _postalCode,
      _profilePic,
      _password;
  double? _lat, _lgt;
  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _imageFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void locatePosition() async {
    // User user=User(name:'')
    await Provider.of<Address>(context, listen: false).getUserAddress();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse? response = await _imagePicker.retrieveLostData();
    if (response == null) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = File(response.file!.path);
      });
    }
  }

  _onCameraClick() {
    final action = CupertinoActionSheet(
      message: Text(
        'Add Profile Picture',
        style: TextStyle(fontSize: 45.0,
        fontFamily: 'HelloKetta'),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text('Choose From Gallery',
          style: TextStyle(
             fontFamily: 'ChanceryCursive',
            fontSize: 30
          )),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
            XFile? image =
                await _imagePicker.pickImage(source: ImageSource.gallery);
            if (image != null)
              setState(() {
                _image = File(image.path);
                _profilePic = image.path;
              });
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Take A Picture',
          style:TextStyle(
             fontFamily: 'ChanceryCursive',
            fontSize: 30
          )),
          //  isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            XFile? image = await _imagePicker.pickImage(
              source: ImageSource.camera,
            );
            if (image == null) {
              return;
            }
            //if (image != null)
            else {
              setState(() {
                _image = File(image.path);
                _profilePic = image.path;
              });
            }
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('cancel'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    // setState(() {

    // });
    auth.UserCredential authResult;
    try {
//    authResult = await _auth.createUserWithEmailAndPassword(email: _email!, password: _password!);
//CAUser user = new CAUser(name: _name,userName: _userName, email: _email,phone: _phone,lat: _lat,lgt: _lgt,street: _street,city:_city, state: _state,postalCode: _postalCode);
      //FirebaseUtil firebaseUtil = FirebaseUtil();
      authResult = await _auth.createUserWithEmailAndPassword(
          email: _email!, password: _password!);
      //CAUser user = new CAUser(name: _name,userName: _userName, email: _email,phone: _phone,lat: _lat,lgt: _lgt,street: _street,city:_city, state: _state,postalCode: _postalCode);
      User user = new User(
          userID: authResult.user!.uid,
          name: _name,
          userName: _userName,
          email: _email,
          phone: _phone,
          lat: _lat,
          lgt: _lgt,
          street: _street,
          city: _city,
          state: _state,
          postalCode: _postalCode,
          profilePic: _profilePic);
      await FirebaseUtil.signUpUserWithEmailAndPassword(user, _password!);
      //await firebaseUtil.createNewUser(user, _email, _password);
//     await FirebaseFirestore.instance.collection(USERS)
//           .doc(authResult.user!.uid)
//           .set(user.toJson());
    } on PlatformException catch (err) {
//         var message = 'An error occurred, pelase check your credentials!';
  if (err.message != null) {
       String message = err.message!;
       print(message);
      }
    }
    Navigator.of(context).pop();
  }

  ///
  Future<void> getUserAddress() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //double?
    _lat = position.latitude;
    //double?
    _lgt = position.longitude;
    print('here is lat ' + _lat.toString() + ' here is lng ' + _lgt.toString());
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$_lat,$_lgt&key=AIzaSyAAfQrwB2dKtjUIVxj4z8Fseq2n6_0XDtU');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };

    try {
      final response = await http.get(url, headers: header);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return; // "extractedData was null";
      }
      //  String place_Address = extractedData["results"][0]["formatted_address"];
      // String pl = "";
      String st1, st2, st3, st4, st5, st6;
      st1 = extractedData["results"][0]["address_components"][0]
          ["long_name"]; //street_number
      st2 = extractedData["results"][0]["address_components"][1]
          ["long_name"]; //route or street name
      st3 = extractedData["results"][0]["address_components"][2]
          ["long_name"]; //city or sublocality
      st4 = extractedData["results"][0]["address_components"][4]
          ["long_name"]; //state name or administrative_area_level_1
      st5 = extractedData["results"][0]["address_components"][5]
          ["long_name"]; //country
      st6 = extractedData["results"][0]["address_components"][6]
          ["long_name"]; //postal code
      //String pl = st1 + ", " + st2 + ", " + st3 + ", " + st4 + ", " + st5 + ", " + st6;
      // String streetAddress= st1 + " "+ st2;
      _street = st1 + " " + st2;
      // String city = st3;
      _city = st3;
      // String state=st4;
      _state = st4;
      //String postalCode = st6;
      _postalCode = st6;
      print("Street Adress " + _street!);
      print("City " + _city!);
      print("State " + _state!);
      print("Postal Code " + _postalCode!);
      print('st5 '+ st5);

      // print('Address = '+ pl);
      return; // pl;
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      retrieveLostData();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up',
        style:TextStyle(
          fontFamily: 'CandyCaneRegular',
          fontSize:40
        )),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.save), onPressed: () {})
        ],
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      //  padding: const EdgeInsets.all(11.0),
                      child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            CircleAvatar(
                                radius: 65,
                                child: ClipOval(
                                    child: SizedBox(
                                  width: 170,
                                  height: 170,
                                  child: _image == null
                                      ? Image.asset(
                                          'assets/images/placeholder.jpg',
                                          fit: BoxFit.cover)
                                      : Image.file(_image!, fit: BoxFit.cover),
                                ))),
                            Positioned(
                              right: 10,
                              bottom: 0,
                              child: FloatingActionButton(
                                  backgroundColor: Colors.yellow,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  mini: true,
                                  onPressed: _onCameraClick),
                            ),
                          ]),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'User Name'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                      validator: validateName,
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                      validator: validateName,
                      onSaved: (value) {
                        _name = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_phoneFocusNode);
                      },
                      validator: validateEmail,
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Phone'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      focusNode: _phoneFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      validator: validatePhone,
                      onSaved: (value) {
                        _phone = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_confirmPasswordFocusNode);
                      },
                      validator: validatePassword,

                      // validator: (value) {
                      //   validations.validatePassword(value!);
                      // },
                      // onSaved: (value) {
                      //   _authData['password'] = value!;
                      // },
                    ),
                    TextFormField(
                      // enabled: _authMode == AuthMode.Signup,
                      decoration:
                          InputDecoration(labelText: 'Confirm Password'),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      focusNode: _confirmPasswordFocusNode,
                      //controller: _passwordController,
                      validator: (val) => validateConfirmPassword(
                          _passwordController.text, val),
                      onFieldSubmitted: (_) {
                        // _saveForm();
                      },
                      onSaved: (value) {
                        _password = value;
                      },
                      // validator: _authMode == AuthMode.Signup
                      //     ? (value) {
                      //         if (value != _passwordController.text) {
                      //           return 'Passwords do not match!';
                      //         }
                      //       }
                      //     : null,
                    ),
                    ElevatedButton(
                      child: Text(
                        'Provide Location',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          shape: const BeveledRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ))),
                      onPressed: getUserAddress,
                    ),
                    ElevatedButton(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            shape: const BeveledRectangleBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ))),
                        onPressed: _saveForm),
                  ],
                ),
              )
            )
          ),
      // floatingActionButton: FooterDrawer(),
    );
  }
}
