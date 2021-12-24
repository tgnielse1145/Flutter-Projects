import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chat_app/views/drawer/menu_drawer.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/validate.dart';
import 'package:chat_app/provider/firebase_util.dart';

File? _image;

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user-profile-screen';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? user;
  late Future<User?> tempUser;
  final ImagePicker _imagePicker = ImagePicker();

  String? _id, _name, _profilePic, _userName, _phone, _email;
  final _form = GlobalKey<FormState>();


Future<void> _saveForm() async{
  final isValid=_form.currentState!.validate();
  if(!isValid){
    return;
  }
  _form.currentState!.save();
  try{
    await FirebaseUtil.updateUser(user);
  }on PlatformException catch (err) {
//         var message = 'An error occurred, pelase check your credentials!';
  if (err.message != null) {
       String message = err.message!;
       print(message);
      }
    }
    Navigator.of(context).pop();
}
  _onCameraClick() {
    final action = CupertinoActionSheet(
      message: Text(
        'Add Profile Picture',
        style: TextStyle(fontSize: 45.0, fontFamily: 'HelloKetta'),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text('Choose From Gallery',
              style: TextStyle(fontFamily: 'ChanceryCursive', fontSize: 30)),
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
              style: TextStyle(fontFamily: 'ChanceryCursive', fontSize: 30)),
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

  createProfileView() {
    String? _id = auth.FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<DocumentSnapshot>(
        // future:  FirebaseUtil.getCurrentUser(_id),
        future: usersReference.doc(_id).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          user = User.fromDocument(snapshot.data!);
          _image = File(user!.profilePic!);
          //user = await FirebaseUtil.getCurrentUser(_id);
          return SingleChildScrollView(
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
                                          : Image.file(_image!,
                                              fit: BoxFit.cover),
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
                          decoration:
                              InputDecoration(labelText: 'UserName'),
                              initialValue: user!.userName,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          onFieldSubmitted: (_) {
                            // FocusScope.of(context).requestFocus(_emailFocusNode);
                          },
                          validator: validateName,
                          onSaved: (value) {
                            user!.userName=value;
                           // _userName = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Name'),
                          initialValue: user!.name,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          onFieldSubmitted: (_) {
                            // FocusScope.of(context).requestFocus(_emailFocusNode);
                          },
                          validator: validateName,
                          onSaved: (value) {
                            user!.name=value;
                            //_name = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          initialValue: user!.email,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          // focusNode: _emailFocusNode,
                          onFieldSubmitted: (_) {
                            //  FocusScope.of(context).requestFocus(_phoneFocusNode);
                          },
                          validator: validateEmail,
                          onSaved: (value) {
                            user!.email=value;
                           // _email = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Phone'),
                          initialValue: user!.phone,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          // focusNode: _phoneFocusNode,
                          onFieldSubmitted: (_) {
                            //  FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          validator: validatePhone,
                          onSaved: (value) {
                            user!.phone=value;
                            //_phone = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Street'),
                          initialValue: user!.street,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.streetAddress,
                          // focusNode: _phoneFocusNode,
                          onFieldSubmitted: (_) {
                            //  FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          // validator: validatePhone,
                          onSaved: (value) {
                            user!.street=value;
                            // _phone = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'City'),
                          initialValue: user!.city,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.streetAddress,
                          // focusNode: _phoneFocusNode,
                          onFieldSubmitted: (_) {
                            //  FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          //validator: validatePhone,
                          onSaved: (value) {
                            user!.city=value;
                            //_phone = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'State'),
                          initialValue: user!.state,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.streetAddress,
                          // focusNode: _phoneFocusNode,
                          onFieldSubmitted: (_) {
                            //  FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          // validator: validatePhone,
                          onSaved: (value) {
                            user!.state=value;
                            // _phone = value;
                          },
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Postal Code'),
                              initialValue: user!.postalCode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          // focusNode: _phoneFocusNode,
                          onFieldSubmitted: (_) {
                            //  FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          // validator: validatePhone,
                          onSaved: (value) {
                            user!.postalCode=value;
                            //_phone = value;
                          },
                        ),
                        // TextFormField(
                        //   decoration: InputDecoration(labelText: 'Password'),
                        //   keyboardType: TextInputType.visiblePassword,
                        //   obscureText: true,
                        //  // controller: _passwordController,
                        //  // focusNode: _passwordFocusNode,
                        //   onFieldSubmitted: (_) {
                        //     FocusScope.of(context)
                        //         .requestFocus(_confirmPasswordFocusNode);
                        //   },
                        //   validator: validatePassword,

                        //   // validator: (value) {
                        //   //   validations.validatePassword(value!);
                        //   // },
                        //   // onSaved: (value) {
                        //   //   _authData['password'] = value!;
                        //   // },
                        // ),
                        // TextFormField(
                        //   // enabled: _authMode == AuthMode.Signup,
                        //   decoration:
                        //       InputDecoration(labelText: 'Confirm Password'),
                        //   keyboardType: TextInputType.visiblePassword,
                        //   obscureText: true,
                        //   focusNode: _confirmPasswordFocusNode,
                        //   //controller: _passwordController,
                        //   validator: (val) => validateConfirmPassword(
                        //       _passwordController.text, val),
                        //   onFieldSubmitted: (_) {
                        //     // _saveForm();
                        //   },
                        //   onSaved: (value) {
                        //     _password = value;
                        //   },
                        //   // validator: _authMode == AuthMode.Signup
                        //     ? (value) {
                        //         if (value != _passwordController.text) {
                        //           return 'Passwords do not match!';
                        //         }
                        //       }
                        //     : null,
                        //  ),
                        // ElevatedButton(
                        //   child: Text(
                        //     'Provide Location',
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        //   style: ElevatedButton.styleFrom(
                        //       onPrimary: Colors.white,
                        //       shape: const BeveledRectangleBorder(
                        //           borderRadius: BorderRadius.all(
                        //         Radius.circular(5),
                        //       ))),
                        //  // onPressed: getUserAddress,
                        //  onPressed: (){},
                        // ),
                        // ElevatedButton(
                        //     child: Text(
                        //       'Sign Up',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     style: ElevatedButton.styleFrom(
                        //         onPrimary: Colors.white,
                        //         shape: const BeveledRectangleBorder(
                        //             borderRadius: BorderRadius.all(
                        //           Radius.circular(5),
                        //         ))),
                        //    // onPressed: _saveForm
                        //    onPressed: (){},
                        //    ),
                      ],
                    ),
                  )));
        });
  }

// @override
// void initState(){
//  // super.initState();
//   hasFinishedLoading();
//   super.initState();
// }
  @override
  Widget build(BuildContext context) {
    //String? _fart = hasFinishedLoading().toString();

    return Scaffold(
        appBar: AppBar(
          title: const Text('User Profile'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save), 
              onPressed: _saveForm
            ),
          ],
        ),
        drawer: MenuDrawer(),
        body: ListView(
          children: <Widget>[
            createProfileView(),
          ],
        ));
  }
}
