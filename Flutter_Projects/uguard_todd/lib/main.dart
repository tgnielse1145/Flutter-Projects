import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uguard_app/controllers/picture_provider.dart';
import 'package:uguard_app/controllers/push_notifications_provider.dart';
import 'package:uguard_app/models/address.dart';
import 'package:uguard_app/views/camera/take_profile_pic.dart';
import 'package:uguard_app/views/contact/contact_detail_screen.dart';
import 'package:uguard_app/views/contact/contact_overview_screen.dart';
import 'package:uguard_app/views/contact/edit_contact_screen.dart';
import 'package:uguard_app/views/contact/user_contacts_screen.dart';
import 'package:uguard_app/views/auth/auth_screen.dart';
import 'package:uguard_app/views/auth/splash_screen.dart';
import 'package:uguard_app/controllers/contacts_controller.dart';
import 'package:uguard_app/controllers/auth.dart';
import 'package:uguard_app/controllers/places_controller.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';
import 'package:uguard_app/views/places/add_place_screen.dart';
import 'package:uguard_app/views/places/place_detail_screen.dart';
import 'package:uguard_app/views/places/get_current_location.dart';
import 'package:uguard_app/views/places/place_overview_screen.dart';
import 'package:uguard_app/views/places/user_place_overview_screen.dart';
import 'package:uguard_app/views/user/user_registration_screen.dart';
import 'package:uguard_app/views/user/user_overview_screen.dart';
import 'package:uguard_app/views/user/edit_user_screen.dart';
import 'package:uguard_app/controllers/user_controller.dart';
import 'package:uguard_app/views/contact/contact_item.dart';
import 'package:uguard_app/message/message.dart';
import 'package:uguard_app/views/camera/edit_photo_page.dart';
import 'package:uguard_app/views/search/search.dart';
import 'package:uguard_app/bloc/photo_bloc.dart';
import 'package:uguard_app/controllers/push_notifications_provider.dart';
import 'package:uguard_app/views/auth/splash_screen.dart';
import 'package:uguard_app/models/configMaps.dart';
//void main()=> runApp(MyApp());
late final  cameras;
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  //User? userEmail = firebaseAuth.currentUser;//!.emailVerified;
  // cameras = await availableCameras();

//   // Get a specific camera from the list of available cameras.
  //final firstCamera = cameras.first;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  void functionCamera(){
    return;
  }

  @override
  Widget build(BuildContext context) {

  File? file;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
       ChangeNotifierProvider.value(
          value: Address(),
        ),
        ChangeNotifierProvider.value(
          value: PictureProvider(),
          ),

        BlocProvider( create: (_) => PhotoBloc(),),
        ChangeNotifierProxyProvider<Auth, UserController>(
          create: (ctx)=>UserController('','',), 
          update: (ctx,auth,currUser)=>UserController(
            auth.token,
            auth.userId,
            
          ),
        ),
         ChangeNotifierProxyProvider<Auth, ContactsController>(
          create: (ctx) => ContactsController('', '', []),
          update: (ctx, auth, previousContacts) => ContactsController(
            auth.token,
            auth.userId,
            previousContacts ==null? [] : previousContacts.contacts
            //if previousContacts is null then initialize it with an empty list
          ),
          
        ), 
        ChangeNotifierProxyProvider<Auth, PlacesController>(
          create: (ctx)=>PlacesController('','',), 
          update: (ctx,auth,currUser)=>PlacesController(
            auth.token,
            auth.userId,
            
          ),
        ), 
        // Provider<PushNotificationsProvider>(
        //   create: (_)=>PushNotificationsProvider(
        //     firebaseFirestore: this.firebaseFirestore)) 
      ],
      ///will automatically rebuild with AuthController changes because of the 
      ///the notifiyListeners within the AuthController
      child: Consumer2<Auth, UserController>(
        builder: (ctx, auth, user, child) => MaterialApp(
          title: 'Flutter Login',
          theme: ThemeData(
            primarySwatch: Colors.red,
            // ignore: deprecated_member_use
            accentColor: Colors.black,
            fontFamily: 'Lato',
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),

          //is the current user authenticated? if so then try to autologin if that works then go to the ContactOveriewScreen, if it's taking a while then
          //display the splash screen, if the user isn't authenticated then go to the authscreen and either login or create a new user
         
         ///this is where we auto login, 
         home: auth.isAuth? ContactOverviewScreen() :FutureBuilder(
                  ///this is will return the future from the tryAuthLogin function
                  ///with the authController
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),),    
          //  home: auth.isAuth? ContactOverviewScreen() :FutureBuilder(
          //         ///this is will return the future from the tryAuthLogin function
          //         ///with the authController
          //         future: auth.tryAutoLogin(),
          //         builder: (ctx, authResultSnapshot) =>
          //             authResultSnapshot.connectionState ==
          //                     ConnectionState.waiting
          //                 ? SplashScreen()
          //                 : AuthScreen(),),    
         ///see below for how to add another condition to determine if you should 
         ///login in or not
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            ContactDetailScreen.routeName: (ctx) => ContactDetailScreen(),
            EditContactScreen.routeName: (ctx) => EditContactScreen(),
            UserContactsScreen.routeName: (ctx) => UserContactsScreen(),
            AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
            PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
            UserRegistrationScreen.routeName: (ctx) => UserRegistrationScreen(),
            UserOverviewScreen.routeName: (ctx) => UserOverviewScreen(),
            GetCurrentLocation.routeName: (ctx) => GetCurrentLocation(),
            PlaceOverviewScreen.routeName: (ctx) => PlaceOverviewScreen(),
            UserPlaceOverviewScreen.routeName: (ctx) => UserPlaceOverviewScreen(),
            EditUserScreen.routeName: (ctx) => EditUserScreen(),
            Message.routeName: (ctx) => Message(),
            ContactItem.routeName: (ctx) => ContactItem(),
           // ImageInput.routeName: (ctx) => ImageInput(functionCamera),
           // TakePictureScreen.routeName: (ctx) => TakePictureScreen(camera:firstCamera),
            TakeProfilePic.routeName: (ctx) => TakeProfilePic(),
            EditPhotoPage.routeName: (ctx)=>EditPhotoPage(image: file),
            MenuDrawer.routeName:(ctx)=>MenuDrawer(),
            SearchScreen.routeName:(ctx)=>SearchScreen(),
            SplashScreen.routeName:(ctx)=>SplashScreen(),


          },
        ),
      ),
    );
  }
}

///home: auth.isAuth? ContactOverviewScreen() :FutureBuilder(
    ///             future: auth.tryAutoLogin(),
            ///      builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? authResultSnapshot.data == false ? AuthScreen()
              ///            ? SplashScreen()
                 ///         : AuthScreen(),), 