import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class TakeProfilePic extends StatefulWidget {
  final Function onSelectedImage;
  TakeProfilePic(this.onSelectedImage);

  @override
  _TakeProfilePicState createState() => _TakeProfilePicState();
}

class _TakeProfilePicState extends State<TakeProfilePic> {
   File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile= await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
      );
      if(imageFile==null){
        return;
      }
    // final imageFile = await ImagePicker.pickImage(
    //   source: ImageSource.camera,
    //   maxWidth: 600,
    // );
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectedImage(savedImage);
    //final savedImage = await imageFile.copy('${appDir.path}/$fileName'); // orginal_code
  }

  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          // ignore: deprecated_member_use
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
