import 'package:chat_app/models/validate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:chat_app/views/drawer/menu_drawer.dart';
import 'package:chat_app/views/home/home_screen.dart';
import 'package:flutter/services.dart';


final _auth =auth.FirebaseAuth.instance;
var fart = _auth.currentUser;
class EmailVerificationSplashScreen extends StatefulWidget {
  static const routeName='/email-verification-splash-screen';
 // const EmailVerificationSplashScreen({ Key? key }) : super(key: key);

  @override
  _EmailVerificationSplashScreenState createState() => _EmailVerificationSplashScreenState();
}

class _EmailVerificationSplashScreenState extends State<EmailVerificationSplashScreen> {
  resendEmailVerification(){
     _auth.currentUser!.sendEmailVerification();
     print(_auth.currentUser!.email!);
    // while(_auth.currentUser!.emailVerified==false){
    //    if(_auth.currentUser!.emailVerified){
    //      Navigator.push(context,MaterialPageRoute(builder: (c)=>HomeScreen()));
    //    }
    // // }
    // _auth.currentUser!.emailVerified;
  }
  recheckEmailVerfication(){
    print('here i am ');
    try{
    if(_auth.currentUser!=null){
      if(_auth.currentUser!.emailVerified){
        Navigator.of(context).pushNamed(HomeScreen.routeName);

      }else{
        showSnackBar(context, 'Please verify your email bitch');
      }
    }
    }on PlatformException catch (err){
      if(err.message!=null){
        String message = err.message!;
        print(message);
      }
    }
  }
  @override
  void initState(){
    super.initState();
    resendEmailVerification();
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
          title: const Text('Home'),
          actions: <Widget>[
            //IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {})
          ],
        ),
        drawer: MenuDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                 child: Image.asset("assets/images/middleFinger.jpg",
                fit:BoxFit.contain),
                ),
                Container(
                  child:Text('Verify your email bitch',
                  style: TextStyle(
                    fontFamily: 'ChanceryCursive',
                    fontSize: 45,
                  ))
                ),
                ElevatedButton(
                  onPressed: (){
                    recheckEmailVerfication;
                    // if(_auth.currentUser!.emailVerified){
                    // Navigator.of(context).pushNamed(HomeScreen.routeName);
                    // }

                  },
                   child: Text('Email has been verified'))
            ]
          ),
        ),
      );
  }
}