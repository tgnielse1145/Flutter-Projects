import 'dart:io';
import 'dart:async';
import 'package:chat_app/views/drawer/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/provider/address.dart';

File? _image;

class UserRegistrationScreen extends StatefulWidget {
  static const routeName = '/user-registration';
  const UserRegistrationScreen({Key? key}) : super(key: key);

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _imageFocusNode.dispose();
  }

  void locatePosition() async {
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
        'addProfilePicture',
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text('chooseFromGallery'),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
            XFile? image =
                await _imagePicker.pickImage(source: ImageSource.gallery);
            if (image != null)
              setState(() {
                _image = File(image.path);
              });
          },
        ),
        CupertinoActionSheetAction(
          child: Text('takeAPicture'),
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

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      retrieveLostData();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.save), onPressed: () {})
          ],
        ),
        drawer: MenuDrawer(),
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 32, right: 8, bottom: 8),
                        //  padding: const EdgeInsets.all(11.0),
                        child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 65,
                                child:ClipOval(
                                child:SizedBox( 
                                  width: 170,
                                  height: 170,
                                  child: _image == null
                                    ? Image.asset(
                                        'assets/images/placeholder.jpg',
                                        fit:BoxFit.cover)
                                    : Image.file(_image!,
                                    fit:BoxFit.cover),
                               ) )),
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
                        decoration: const InputDecoration(labelText: 'Name'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
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
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Phone'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        focusNode: _phoneFocusNode,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        controller: _passwordController,
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
                        onPressed: locatePosition,
                      )
                    ],
                  ),
                ))));
  }
}