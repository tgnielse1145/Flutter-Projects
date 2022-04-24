import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uguard_app/bloc/photo_bloc.dart';
//import 'package:photo_app/route/route_names.dart';

class PhotoHomePage extends StatefulWidget {
  @override
  _PhotoHomePageState createState() => _PhotoHomePageState();
}

class _PhotoHomePageState extends State<PhotoHomePage> {
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _showChoiceDialog(context);
                },
                child: BlocBuilder<PhotoBloc, PhotoState>(
                  bloc: BlocProvider.of<PhotoBloc>(
                      context), // provide the local bloc instance
                  builder: (context, state) {
                    return Container(
                      height: 150,
                      width: 150,
                      child: state is PhotoInitial
                          ? Image.asset(
                              'assets/images/user.png') // set a placeholder image when no photo is set
                          : Image.file((state as PhotoSet).photo),
                    );
                  },
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Please select your profile photo',
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Method for sending a selected or taken photo to the EditPage
  Future selectOrTakePhoto(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.pushNamed(context, '/edit-photo-page', arguments: _image);
      } else
        print('No photo was selected or taken');
    });
  }
 Future<void>_showChoiceDialog(BuildContext context){
        return showDialog(context: context, builder: (BuildContext context){
          return SimpleDialog(
            title: Text('Select a photo'),
            children: <Widget>[
              SimpleDialogOption(
                child:Text('From gallery'),
                onPressed:() {
                  selectOrTakePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },

              ),
              SimpleDialogOption(
                child: Text('Take a photo'),
                onPressed: (){
                  selectOrTakePhoto(ImageSource.camera);
                  Navigator.pop(context);
                } ,)
            ],
          );
          // return AlertDialog(
          //   title:Text('Make a Choice'),
          //   content:SingleChildScrollView(
          //     child:ListBody(
          //       children: <Widget>[
          //         GestureDetector(
          //           child: Text('Camera'),
          //           onTap: (){
          //             _openCamera(context);
          //           },
          //         ),
          //         SizedBox(
          //           height: 20,
          //         ),
          //         GestureDetector(
          //           child:Text('Gallery'),
          //           onTap:(){
          //             _openGallery(context);
          //           }
          //         ),
          //       ],
          //     )
          //   )
          // );
        });
      }
       _openCamera(BuildContext context)async{
      
        var picker = ImagePicker();
      File? imageFile;
        final picture = await picker.pickImage(source: ImageSource.camera,
        maxHeight: 300,maxWidth: 300,);
        if(picture==null){
          return;
        }
        Navigator.of(context).pop();
        this.setState(() {
          //convertToFile(XFile picture)=>File(picture.path);
          imageFile=File(picture.path);
          
        //  imageFile=picture as File?;
          
        });
      }
        _openGallery(BuildContext context)async{
        var picker = ImagePicker();
        File? imageFile;
        final picture = await picker.pickImage(source: ImageSource.gallery,
        maxHeight: 300,maxWidth: 300,imageQuality: 100, );
        if(imageFile==null){
          return;
        }
        Navigator.of(context).pop();
        this.setState(() {
          imageFile=File(picture!.path);
          
        });
      }
  /// Selection dialog that prompts the user to select an existing photo or take a new one
  // Future _showSelectionDialog() async {
  //   await showDialog(
  //     context: context,
  //     child: SimpleDialog(
  //       title: Text('Select photo'),
  //       children: <Widget>[
  //         SimpleDialogOption(
  //           child: Text('From gallery'),
  //           onPressed: () {
  //             selectOrTakePhoto(ImageSource.gallery);
  //             Navigator.pop(context);
  //           },
  //         ),
  //         SimpleDialogOption(
  //           child: Text('Take a photo'),
  //           onPressed: () {
  //             selectOrTakePhoto(ImageSource.camera);
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}