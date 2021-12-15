import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uguard_app/views/contact/contact_detail_screen.dart';
import 'package:uguard_app/views/contact/edit_contact_screen.dart';
import 'package:uguard_app/controllers/contacts_controller.dart';
import 'package:uguard_app/models/contact.dart';
import 'package:uguard_app/views/places/place_overview_screen.dart';
import 'package:uguard_app/views/places/user_place_overview_screen.dart';
//import 'package:uguard_app/controllers/push_notification_controller.dart';

class ContactItem extends StatelessWidget {

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
             // Navigator.push(context,MaterialPageRoute(builder: (context)=>MapScreen()))
              //Navigator.push(context,MaterialPageRoute(builder: (context)=>PlacesListScreen()))
               // Navigator.of(context).pushNamed(AddPlaceScreen.routeName)
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

             // Navigator.push(context,MaterialPageRoute(builder: (context)=>MapScreen()))
              //Navigator.push(context,MaterialPageRoute(builder: (context)=>AddPlaceScreen()))

            },
            //color: Theme.of(context).accentColor,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
