import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uguard_app/views/contact/contact_grid.dart';
import 'package:uguard_app/views/contact/edit_contact_screen.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';
import 'package:uguard_app/views/drawer/footer_drawer.dart';
import 'package:uguard_app/controllers/contacts_controller.dart';
import 'package:uguard_app/controllers/user_controller.dart';

import 'package:uguard_app/message/message.dart';

class ContactOverviewScreen extends StatefulWidget{
   static const routeName = '/contact-overview';
  @override
  _ContactOverviewScreenState createState()=>_ContactOverviewScreenState();
}
class _ContactOverviewScreenState extends State<ContactOverviewScreen>{
  var _isInit =true;
  var _isLoading =false;
  var _showOnlyFavorites=false;

  @override
  void initState(){
    super.initState();
  }
  @override
  void didChangeDependencies(){
    if(_isInit){
      setState(() {
        _isLoading=true;
      });
      Provider.of<UserController>(context).getAndSetUsers();
      //change the getAndSetContacts below back to fetchAndSetContacts
      Provider.of<ContactsController>(context).getAndSetContacts().then((_){
        setState(() {
          _isLoading=false;


        });
      });
    }
_isInit=false;
super.didChangeDependencies();
  }
  void startMessage()async{
    Navigator.of(context).pushNamed(Message.routeName);
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        
        title: Text('My Contacts'), 
        centerTitle: true,
      
        actions:<Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(EditContactScreen.routeName);
            },
          ),
        ],
        ),
        
        drawer: MenuDrawer(),
        body:_isLoading ? Center(
          child:CircularProgressIndicator(),
        ):
          ContactGrid(_showOnlyFavorites),
          //  ElevatedButton(
                      
          //         child: Text( 'Notification',
          //         style:TextStyle(
          //           color: Colors.white,
          //         ),),
          //         style: ElevatedButton.styleFrom(
          //           onPrimary: Colors.white,
                    
          //           shape:const BeveledRectangleBorder(
          //             borderRadius: BorderRadius.all(
          //               Radius.circular(5),
          //             )
          //           )
          //         ),
          //         onPressed: startMessage
          //         ),      
                  
    
          floatingActionButton:FooterDrawer(),
          
          // ignore: deprecated_member_use
          
    );
  }
}