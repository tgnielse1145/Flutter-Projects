import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uguard_app/models/image_input.dart';
import 'package:uguard_app/views/camera/take_picture_screen.dart';
import 'package:uguard_app/views/contact/contact_detail_screen.dart';
import 'package:uguard_app/views/contact/edit_contact_screen.dart';
import 'package:uguard_app/controllers/contacts_controller.dart';
import 'package:uguard_app/models/contact.dart';
import 'package:uguard_app/views/places/place_overview_screen.dart';
import 'package:uguard_app/models/image_input.dart';
import 'package:uguard_app/views/camera/take_profile_pic.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:uguard_app/views/camera/take_picture_screen.dart';
import 'package:uguard_app/views/places/user_place_overview_screen.dart';
import 'package:uguard_app/controllers/push_notification_controller.dart';
import 'package:camera/camera.dart';

late final cameras;
class ContactItem extends StatefulWidget {
  static const routeName='/contact-item';
@override
_ContactItemState createState()=>_ContactItemState();
}
class _ContactItemState extends State<ContactItem>{
// await _takePicture();
//   Future<void> _takePicture() async {
//       cameras = await availableCameras();

//   // Get a specific camera from the list of available cameras.
//   final firstCamera = cameras.first;

//     TakePictureScreen(camera:firstCamera);
    
//    
   //}
   File? _pickedImage;
   void _selectImage(File pickedImage){
     _pickedImage=pickedImage;
   }
    
  @override
  Widget build(BuildContext context) {
   
    final contacts=Provider.of<Contact>(context,listen:false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ContactDetailScreen.routeName,
              arguments: contacts.id,
            );
          },
          child: Image.network(
            contacts.imageUrl!,
            fit: BoxFit.cover,  
          ),
        ),
        header: GridTileBar(  
           leading: IconButton(
             icon: Icon(
              Icons.location_on_outlined,
            ),
            onPressed: ()=> {
               Navigator.of(context).pushNamed(PlaceOverviewScreen.routeName)

            },
            //color: Theme.of(context).accentColor,
            color: Colors.red, 
          ),
          title: Text(
          'uguardApp',
            textAlign: TextAlign.center,
          ),
        trailing: IconButton(
          alignment: Alignment.topLeft,
            icon: Icon(Icons.camera_enhance),
            //color: Theme.of(context).accentColor,
            color: Colors.red,
            onPressed: () {
              //_takePicture();
              //ImageInput(_selectImage);
             // Navigator.of(context).pushNamed(TakeProfilePic.routeName);
                 // Navigator.of(context).pushNamed(ImageInput.routeName,arguments: _pickedImage);                
              
            //  Future<String?>token = PushNotificationController().getToken();
              //print('here is the token'+ token.toString());
            //  print("here is the token "+ token.toString());
              //Navigator.of(context).pushNamed(EditContactScreen.routeName, arguments: contacts.id);
                         //  Navigator.push(context,MaterialPageRoute(builder: (context)=>TakeProfilePic()))
               Navigator.of(context).pushNamed(UserPlaceOverviewScreen.routeName);

            },
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(Icons.edit),
            //color: Theme.of(context).accentColor,
            color: Colors.red,
            onPressed: () {
              Navigator.of(context).pushNamed(EditContactScreen.routeName, arguments: contacts.id);
            },
          ),
          title: Text(
            contacts.name!,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
            ),
            onPressed: (){
             Provider.of<ContactsController>(context,listen:false).deleteContact(contacts.id!);
            },
            //color: Theme.of(context).accentColor,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
