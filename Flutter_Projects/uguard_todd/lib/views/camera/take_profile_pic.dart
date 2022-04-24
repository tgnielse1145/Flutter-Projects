

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart'; 
 import 'package:image_picker/image_picker.dart';
 import 'package:flutter/rendering.dart';
 import 'package:image_cropper/image_cropper.dart';
import 'package:uguard_app/bloc/photo_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uguard_app/models/uguarduser.dart';
import 'package:uguard_app/route/route_names.dart';
import 'package:uguard_app/views/drawer/footer_drawer.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';
import 'package:uguard_app/views/camera/edit_photo_page.dart';
import 'package:uguard_app/controllers/user_controller.dart';
import 'package:provider/provider.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';
import 'package:uguard_app/views/contact/contact_item.dart';

//  class TakeProfilePic extends StatefulWidget{
//    static const routeName ='/take-profile-pic';
   
//    @override
//   _TakeProfilePicState createState()=>_TakeProfilePicState();
//  }
//  class _TakeProfilePicState extends State<TakeProfilePic>{
//    UguardUser? _user;//Provider.of<UserController>(context, listen: false).g
//    @override
//    Widget build(BuildContext context){
//          _user= Provider.of<UserController>(context, listen: false).findByUser;

//      return MaterialApp(
//        title:'Profile Pic',
//        theme:ThemeData(
//          // ignore: deprecated_member_use
//          accentColor: Colors.black,
//        fontFamily: 'Lato',
//        scaffoldBackgroundColor: Colors.white,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//        ),
    
//        home:LandingScreen(),
//        routes: {MenuDrawer.routeName:(ctx)=>MenuDrawer(),
//        }
//      );
//    }
//  }
 

 class TakeProfilePic extends StatefulWidget{
   static const routeName ='/take-profile-pic';
   @override
   _TakeProfilePicState createState()=>_TakeProfilePicState();
    }
    class _TakeProfilePicState extends State<TakeProfilePic>{
      File? imageFile;
      File? finalFile;
      UguardUser? _user; //= Provider.of<UserController>(context,listen:false).findByUser;
     
     _openCamera(BuildContext context)async{
      
        var picker = ImagePicker();      
        final picture = await picker.pickImage(source: ImageSource.camera,
        maxHeight: 300,maxWidth: 300,);
        if(picture==null){
          return;
        }
        else{
          imageFile=File(picture.path);
          _cropImage();
        }
        Navigator.of(context).pop();
        // this.setState(() {
        //   //convertToFile(XFile picture)=>File(picture.path);
          
        //  // imageFile=File(picture.path);
        //  // Navigator.of(context).pushNamed(EditPhotoPage.routeName,arguments: picture);
        // //  imageFile=picture as File?;
          
        // });
      }
        _openGallery(BuildContext context)async{
        var picker = ImagePicker();
        final picture = await picker.pickImage(source: ImageSource.gallery,
        maxHeight: 300,maxWidth: 300,imageQuality: 100, );
        if(picture==null){
          return;
        }
       // Navigator.of(context).pop();
        this.setState(() {
          imageFile=File(picture.path);
          
        });
      }
      Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile!.path,
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
  
     // finalFile = croppedFile;
      print("FINALFILE_PATH "+ finalFile!.path.toString());
      _user!.profilePic=croppedFile.path.toString();
   //  context.read<PhotoBloc>().add(GetPhoto(finalFile!));
     // Navigator.pop(context);//, routeHome);
      //Navigator.of(context).pushNamed(ContactItem.routeName);
    }

  }
      Future<void>_showChoiceDialog(BuildContext context){
        return showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title:Text('Make a Choice'),
            content:SingleChildScrollView(
              child:ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: (){
                      _openCamera(context);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child:Text('Gallery'),
                    onTap:(){
                      _openGallery(context);
                    }
                  ),
                ],
              )
            )
          );
        });
      }
      Widget _decideImageView(){
        if(imageFile==null){
          return Text('No image Selected');
        }
        else{          
         return Image.file(imageFile!,width: 100,height: 100,fit:BoxFit.contain );
        }
       // return widget;
      }
@override
Widget build(BuildContext context){
       _user = Provider.of<UserController>(context,listen:false).findByUser;

  return Scaffold(
    appBar: AppBar(title: Text('Take a Pic'),
    ),
    
    drawer: MenuDrawer(),
     body:Container(
          child: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             _decideImageView(),
              ElevatedButton(onPressed:(){
                _showChoiceDialog(context);
              },
             child: Text('Select an Image'),)
            ],
            )
          ),
        ),
    floatingActionButton: FooterDrawer(),
  );
}
      
    }
