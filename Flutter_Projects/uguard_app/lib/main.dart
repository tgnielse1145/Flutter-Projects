import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uguard_app/controllers/push_notification_controller.dart';
import 'package:uguard_app/models/address.dart';
import 'package:uguard_app/views/contact/contact_detail_screen.dart';
import 'package:uguard_app/views/contact/contact_overview_screen.dart';
import 'package:uguard_app/views/contact/edit_contact_screen.dart';
import 'package:uguard_app/views/contact/user_contacts_screen.dart';
import 'package:uguard_app/views/auth/auth_screen.dart';
import 'package:uguard_app/views/auth/splash_screen.dart';
import 'package:uguard_app/controllers/contacts_controller.dart';
import 'package:uguard_app/controllers/auth.dart';
import 'package:uguard_app/controllers/places_controller.dart';
import 'package:uguard_app/views/places/add_place_screen.dart';
import 'package:uguard_app/views/places/place_detail_screen.dart';
import 'package:uguard_app/views/places/get_current_location.dart';
import 'package:uguard_app/views/places/place_overview_screen.dart';
import 'package:uguard_app/views/places/user_place_overview_screen.dart';
import 'package:uguard_app/views/user/user_registration_screen.dart';
import 'package:uguard_app/views/user/user_overview_screen.dart';
import 'package:uguard_app/views/user/edit_user_screen.dart';
import 'package:uguard_app/controllers/user_controller.dart';
import 'package:uguard_app/message/message.dart';
import 'package:uguard_app/views/notification/notification_screen.dart';

//void main()=> runApp(MyApp());
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
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Address(),
        ),
        ChangeNotifierProvider.value(
          value: PushNotificationController(),
        ),
        ChangeNotifierProxyProvider<Auth, UserController>(
          create: (ctx) => UserController(
            '',
            '',
            [],
          ),
          update: (ctx, auth, currUser) => UserController(
            auth.token,
            auth.userId,
            currUser==null?[]:currUser.users
          ),
        ),
        ChangeNotifierProxyProvider<Auth, ContactsController>(
          create: (ctx) => ContactsController('', '', []),
          update: (ctx, auth, previousContacts) => ContactsController(
              auth.token,
              auth.userId,
              previousContacts == null ? [] : previousContacts.contacts
              //if previousContacts is null then initialize it with an empty list
              ),
        ),
        ChangeNotifierProxyProvider<Auth, PlacesController>(
          create: (ctx) => PlacesController(
            '',
            '',
          ),
          update: (ctx, auth, currUser) => PlacesController(
            auth.token,
            auth.userId,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder:(ctx, auth, user)=>MaterialApp(
          title: 'Flutter Login',
          theme: ThemeData(
            primarySwatch: Colors.red,
            // ignore: deprecated_member_use
            accentColor: Colors.black,
            fontFamily: 'Lato',
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity
          ),
        
      // child: Consumer2<Auth, UserController>(
      //   builder: (ctx, auth, user, child) => MaterialApp(
      //     title: 'Flutter Login',
      //     theme: ThemeData(
      //       primarySwatch: Colors.red,
      //       // ignore: deprecated_member_use
      //       accentColor: Colors.black,
      //       fontFamily: 'Lato',
      //       scaffoldBackgroundColor: Colors.white,
      //       visualDensity: VisualDensity.adaptivePlatformDensity,
      //     ),

          //is the current user authenticated? if so then try to autologin if that works then go to the ContactOveriewScreen, if it's taking a while then
          //display the splash screen, if the user isn't authenticated then go to the authscreen and either login or create a new user

          home: auth.isAuth
              ? ContactOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),

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
            NotificationScreen.routeName: (ctx) => NotificationScreen(),
          },
        ),
      ),
    );
  }
}
