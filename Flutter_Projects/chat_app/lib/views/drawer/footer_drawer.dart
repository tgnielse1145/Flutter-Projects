import 'package:flutter/material.dart';


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
       
      icon:Icon(Icons.message,
        color: Colors.black,
        ),
       backgroundColor: Colors.yellow,
        
        onPressed: (){
            //  Navigator.push(context,MaterialPageRoute(builder: (context)=>NavigationDrawer()));

        },
   
      
    );
  }
}