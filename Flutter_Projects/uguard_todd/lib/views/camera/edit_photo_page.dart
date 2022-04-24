import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uguard_app/bloc/photo_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:photo_app/route/routes.dart';

class EditPhotoPage extends StatefulWidget {
  static const routeName='/edit-photo-page';
  final File? image;

  const EditPhotoPage({@required this.image});

  @override
  _EditPhotoPageState createState() => _EditPhotoPageState();
}

class _EditPhotoPageState extends State<EditPhotoPage> {
  File? imageFile;

  @override
  void initState() {
    super.initState();
    imageFile = widget.image;
    if (imageFile != null) _cropImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile!.path,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            hideBottomControls: true,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    if (croppedFile != null) {
      imageFile = croppedFile;
      context.read<PhotoBloc>().add(GetPhoto(imageFile!));
      Navigator.of(context).pushNamed(MenuDrawer.routeName);
    }

  }
}