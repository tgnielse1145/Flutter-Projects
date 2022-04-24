import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uguard_app/controllers/contacts_controller.dart';
import 'package:uguard_app/views/contact/user_contact_item.dart';
import 'package:uguard_app/views/contact/edit_contact_screen.dart';
import 'package:uguard_app/views/drawer/footer_drawer.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';

class UserContactsScreen extends StatelessWidget{
  static const routeName = '/user-contacts';

  @override
  Widget build(BuildContext context){
    final contactsData=Provider.of<ContactsController>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Your Contacts'),
        actions:<Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed:(){
              Navigator.of(context).pushNamed(EditContactScreen.routeName);
            },
          ),
        ],
      ),
      drawer: MenuDrawer(),
      body:Padding(
        padding: EdgeInsets.all(8),
        child:ListView.builder(
          itemCount: contactsData.contacts.length,
          
          itemBuilder: (_, i)=>Column(
            children: [
              UserContactItem(
                contactsData.contacts[i].id, 
                contactsData.contacts[i].name, 
                contactsData.contacts[i].phone, 
                contactsData.contacts[i].email,
                contactsData.contacts[i].imageUrl
                ),
                Divider(),
                
            ],
          ),
        )
      ),
      floatingActionButton: FooterDrawer(),
    );
  }
}
