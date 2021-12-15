import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:uguard_app/models/contact.dart';
import 'package:uguard_app/controllers/contacts_controller.dart';

class ContactDetailScreen extends StatelessWidget {
  static const routeName = '/contact-detail';

  @override
  Widget build(BuildContext context) {
    final contactId =
        ModalRoute.of(context)!.settings.arguments as String; //is the id
    final loadedContact = Provider.of<ContactsController>(
      context,
      listen: false,
    ).findById(contactId);
    return Scaffold(
        appBar: AppBar(
          title: Text(loadedContact.name!),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedContact.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedContact.name!,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 30)
                )
                ),
                SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedContact.phone!,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 30)
                )
                ),
                 SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedContact.email!,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 30)
                )
                ),
          ],
        )
      )
    );
  }
}
