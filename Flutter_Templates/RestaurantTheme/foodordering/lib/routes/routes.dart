import 'package:flutter/material.dart';
import 'package:foodordering/screens/bottom_tab/bottom_tab.dart';
import 'package:foodordering/screens/dishes/dishes.dart';
import 'package:foodordering/screens/favourite/favourite.dart';
import 'package:foodordering/screens/login_screen/login_screen.dart';
import 'package:foodordering/screens/make_payment/make_payment.dart';
import 'package:foodordering/screens/set_delivery_location/set_delivery_location.dart';
import 'package:foodordering/screens/signup_screen/signup.dart';
import 'package:foodordering/screens/splash_screen/splash_screen.dart';
import 'package:foodordering/utils/constants/route_names.dart';
import 'package:path/path.dart';

class SetUpRoutes {
  static String initialRoute = Routes.LOGIN;
  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.LOGIN: (context) => LoginScreen(),
      Routes.SPLASH: (context) => SplashScreen(),
      Routes.BOTTOMTAB: (context) => BottomTab(),
      Routes.SIGNUP: (context) => SignUp(),
      Routes.DISHES: (context) => DISHES(),
      Routes.SETDELIVERYLOCATION: (context) => SetDeliveryLocation(),
      Routes.MAKEPAYMENT: (context) => MakePayment(),
      Routes.FAVOURITE: (context) => Favourite()
    };
  }
}
