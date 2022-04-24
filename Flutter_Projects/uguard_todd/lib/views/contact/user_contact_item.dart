import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uguard_app/views/contact/edit_contact_screen.dart';
import 'package:uguard_app/controllers/contacts_controller.dart';

class UserContactItem extends StatelessWidget{
  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? imageUrl;

  UserContactItem(this.id, this.name, this.phone, this.email, this.imageUrl);

  @override
  Widget build(BuildContext context){
    return ListTile(
      title: Text(name!),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl!),
      ),
      trailing: Container(
        width: 100,
        child:Row(
          children:<Widget>[
            IconButton(
             icon: Icon(Icons.edit),
             onPressed:(){
               Navigator.of(context).pushNamed(EditContactScreen.routeName,arguments: id);
             },
             color: Theme.of(context).primaryColor,
             //color: Colors.red,
             ),
             IconButton(
               icon: Icon(Icons.delete),
               onPressed: (){
                 Provider.of<ContactsController>(context,listen:false).deleteContact(id!);
               },
               color: Theme.of(context).errorColor,
             )
           
          ]
        )
      ),


    );
  }
}