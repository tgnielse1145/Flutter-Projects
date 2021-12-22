import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/provider/address.dart';
import 'package:chat_app/views/animation/animation_screen.dart';
import 'package:chat_app/views/home/home_screen.dart';
import 'package:chat_app/views/profile/user_profile_screen.dart';
import 'package:chat_app/views/splash/splash_screen.dart';
import 'package:chat_app/views/signup/signup_screen.dart';
import 'package:chat_app/views/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Address(),
        ),
      ],
      child: Consumer<Address>(
        builder: (ctx, auth, user) => MaterialApp(
          title: 'FlutterChat',
          theme: ThemeData(
            backgroundColor: Colors.red,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.yellow,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
                .copyWith(secondary: Colors.deepPurple),
          ),
          home: SplashScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
            AnimationScreen.routeName: (ctx) => AnimationScreen(),
            SignUpScreen.routeName:(ctx)=>SignUpScreen(),
            LoginScreen.routeName:(ctx)=>LoginScreen(),
          },
        ),
      ),
    );
  }
}
