import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uguard_app/controllers/contacts_controller.dart';
import 'package:uguard_app/views/contact/contact_item.dart';

class ContactGrid extends StatelessWidget{
  final bool showFavs;
  ContactGrid(this.showFavs);
  //this widget will rebuild anytime there is a change in the contacts controller
  @override
  Widget build(BuildContext context){
    //listen to the provider of "contacts" i.e. the ContactsController
    final contactsData=Provider.of<ContactsController>(context);
    //get the list of contacts from the ContactsController
    final loadedcontacts=showFavs ? contactsData.favoriteContacts : contactsData.contacts;
    return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: loadedcontacts.length,
          itemBuilder: (ctx, i)=>ChangeNotifierProvider.value(
            //send the contacts one by one to the ContactItem view 
            value: loadedcontacts[i],
            child:ContactItem(),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3/2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
    );
  }
}
