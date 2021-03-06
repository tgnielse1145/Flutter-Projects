import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  late File _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
        //final pickedImageFile = await ImagePicker.pickImage(source: ImageSource.camera);
            final pickedImageFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _pickedImage = pickedImageFile as File;
    });
    widget.imagePickFn(pickedImageFile as File);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        // ignore: deprecated_member_use
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
