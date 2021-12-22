import 'dart:async';
import 'package:flutter/material.dart';
import 'package:chat_app/views/home/home_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}): super(key: key);

  @override
  _SplashScreenState createState()=>_SplashScreenState();


}

class _SplashScreenState extends State<SplashScreen>
{
  startTimer(){
    Timer(Duration(seconds: 2),()async{
      Navigator.push(context,MaterialPageRoute(builder: (c)=>HomeScreen()));
    });
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