import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:chat_app/views/home/home_screen.dart';
import 'package:chat_app/views/splash/email_verification_splash_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}): super(key: key);

  @override
  _SplashScreenState createState()=>_SplashScreenState();


}

class _SplashScreenState extends State<SplashScreen>
{
  final _auth= auth.FirebaseAuth.instance;
 // bool _authUser= _auth.currentUser!.emailVerified;
 
  startTimer(){
    // if(_auth.currentUser!.emailVerified==false){
    //   _auth.currentUser!.sendEmailVerification();
    // }
    Timer(Duration(seconds: 2),()async{
      if(_auth.currentUser==null){
              Navigator.push(context,MaterialPageRoute(builder: (c)=>HomeScreen()));

      }

      else if(_auth.currentUser!.emailVerified){
      Navigator.push(context,MaterialPageRoute(builder: (c)=>HomeScreen()));
      }
      else{
      Navigator.push(context,MaterialPageRoute(builder: (c)=>EmailVerificationSplashScreen()));
     // Navigator.push(context,MaterialPageRoute(builder: (c)=>HomeScreen()));

      }
    });
  }
Future<void>_verifiedEmail()async{
   final _auth= auth.FirebaseAuth.instance;
  bool _authUser= _auth.currentUser!.emailVerified;
}
@override
void initState(){
  super.initState();
  startTimer();
}
  @override
  Widget build (BuildContext context){
    return Material(
    child: Container(
      color: Colors.white,
      child: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/unicorns.png"),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Fart Jones",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 40,
                fontFamily: "CandyCaneRegular",
                letterSpacing: 3,
                  ),
                ),
              ), 
             // startTimer        
            ],
          ),
        ),
      ),
    );
  }
}