import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uguard_app/controllers/auth.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uguard_app/views/contact/user_contacts_screen.dart';
import 'package:uguard_app/views/search/search.dart';
import 'package:uguard_app/views/user/edit_user_screen.dart';
import 'package:uguard_app/controllers/picture_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uguard_app/models/picture.dart';

class MenuDrawer extends StatefulWidget {
  static const routeName = '/menu-drawer';
  @override
  _MenuDrawer createState() => _MenuDrawer();
}

class _MenuDrawer extends State<MenuDrawer> {
  File? imageFile;
  File? finalFile;
  File? _profilePic;
  File? croppedFile;
  late final picture;
  bool isLoaded =false;

  _openCamera(BuildContext context) async {
    var picker = ImagePicker();
    picture = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 300,
    );

    if (picture == null) {
      return;
    } else {
      _profilePic = File(picture.path);

       croppedFile = await ImageCropper.cropImage(
          sourcePath: _profilePic!.path,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Crop ya pic',
              toolbarColor: Colors.red,
              hideBottomControls: true,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            title: 'Crop ya pic',
          ));

      if (croppedFile != null) {
        // print('is it even calling the provider ');
         await Provider.of<PictureProvider>(context, listen: false).addProfilePic('Profile Pic', croppedFile!.path);
        
        
        // print("CROPPED_FILE_PATH " + croppedFile.path.toString());
        // String fart =
        //     Provider.of<PictureProvider>(context, listen: false).title!;
        // print("fart = " + fart);
      }
    }
    //Navigator.of(context).pop();
    //this.setState(() {
       _profilePic=croppedFile;
        isLoaded=true;
  // });
    
  }

  _openGallery(BuildContext context) async {
    var picker = ImagePicker();
    final picture = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 300,
      maxWidth: 300,
      imageQuality: 100,
    );
    if (picture == null) {
      return;
    }
    Navigator.of(context).pop();
    this.setState(() {
      imageFile = File(picture.path);
    });
  }

  Future<void> _showChoicDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Make a Choice'),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      child: Text('Gallery'),
                      onTap: () {
                        _openGallery(context);
                      }),
                ],
              )));
        });
  }

  @override
  Widget build(BuildContext context) {
  //   Provider.of<PictureProvider>(context,listen: false).fetchAndSetProfilePic();
  //  Picture? picture= Provider.of<PictureProvider>(context,listen:false).profilePic;
  //  print ('this is the picture '+ picture!.title!);
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
              title: Text("Hello Friend"),             
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.search),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pushNamed(SearchScreen.routeName);
                },
              )),
          Divider(),
          ListTile(
            leading: isLoaded==false?  Image.asset('assets/images/user_icon.png', height: 65.0, width: 65.0):ListTile(leading: Image.file(_profilePic!,width: 65,height: 65,),),
          ),
          // FutureBuilder(
          //   future: Provider.of<PictureProvider>(context, listen: false)
          //       .fetchAndSetProfilePic(),
          //   builder: (ctx, snapshot) => snapshot.connectionState ==
          //           ConnectionState.waiting
          //       ? CircularProgressIndicator()
          //       : Consumer<PictureProvider>(
          //           builder: (ctx, pics, ch) => pics.isLoaded
          //               ? ListTile(
          //                   leading: Image.asset('assets/images/user_icon.png',
          //                       height: 65.0, width: 65.0))
          //               : ListTile(
          //                   leading: Image.file(
          //                   File(picture!.image!),
          //                   height: 65.0,
          //                   width: 65.0,
          //                 ))),
          // ),
          //if(_user!.profilePic==null)
          Divider(),
          //if(_user!.profilePic==null)
          ListTile(
              title: Text('Upload profile pic'),
              onTap: () {
                // Navigator.of(context).pushNamed(TakeProfilePic.routeName);
                _showChoicDialog(context);
              }),

          Divider(),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contacts'),
              onTap: () {
                Navigator.of(context).pushNamed(UserContactsScreen.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pop(); //close the drawer
                ///the below function simply calls the home route, in other words
                ///by just passing / into pushReplacementNamed it will navigate back
                ///to the main.dart file this insures that the consumer will run
                ///run again anytime we press logout
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
                //Navigator.of(context).pushReplacementNamed('/');
              }),
              FloatingActionButton(onPressed: (){})
        ],
      
      ),
    );
  }
}
