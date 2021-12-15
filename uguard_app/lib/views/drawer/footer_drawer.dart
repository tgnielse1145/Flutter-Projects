import 'package:flutter/material.dart';

class FooterDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return FloatingActionButton.extended(
       label: Text(
         "help  me",
         style: TextStyle(color:Colors.red),
       ),
       
      icon:Icon(Icons.local_hospital_outlined,
        color: Colors.red,
        ),
       backgroundColor: Colors.black,
        
        onPressed: (){
            //  Navigator.push(context,MaterialPageRoute(builder: (context)=>NavigationDrawer()));

        },
   
      
    );
  }
}