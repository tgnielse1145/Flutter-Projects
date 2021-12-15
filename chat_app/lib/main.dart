import 'package:flutter/material.dart';
import 'package:chat_app/views/user_registration_screen.dart';
import 'package:chat_app/provider/address.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Address(),
        ),
      ],
      child:Consumer<Address>(
        builder:(ctx,auth,user)=>MaterialApp(
           title: 'FlutterChat',
        theme: ThemeData(
          backgroundColor: Colors.red,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.yellow,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith(secondary: Colors.deepPurple),
        ),
          
      
        home: const UserRegistrationScreen(),
        ),
      ),
        
      );

    
    
  }
}
