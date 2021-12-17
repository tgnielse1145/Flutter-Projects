import 'package:chat_app/views/user/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/views/home/home_screen.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/views/animation/animation_screen.dart';

class FooterDrawer extends StatefulWidget{
  @override
  _FooterDrawerState createState()=>_FooterDrawerState();
}

class _FooterDrawerState extends State<FooterDrawer>{
  
  @override
  Widget build(BuildContext context){
   return FloatingActionButton.extended (
       label: Text(
         "Fart",
         style: TextStyle(color:Colors.red),
       ),
       
      icon:Icon(Icons.car_rental,
        color: Colors.black,
        ),
       backgroundColor: Colors.yellow,
        
        onPressed: (){
            //  Navigator.push(context,MaterialPageRoute(builder: (context)=>NavigationDrawer()));

        },
   
      
    );
  }
}