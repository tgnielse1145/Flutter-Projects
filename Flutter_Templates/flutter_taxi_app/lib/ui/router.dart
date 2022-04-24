import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_qcabtaxi/core/constants/app_contstants.dart';
import 'package:flutter_qcabtaxi/ui/views/home/home_view.dart';
import 'package:flutter_qcabtaxi/ui/views/login/login.dart';
import 'package:flutter_qcabtaxi/ui/views/login/signup.dart';
import 'package:flutter_qcabtaxi/ui/views/login/verify.dart';
import 'package:flutter_qcabtaxi/ui/views/others/contact.dart';
import 'package:flutter_qcabtaxi/ui/views/others/intro.dart';
import 'package:flutter_qcabtaxi/ui/views/others/payment.dart';
import 'package:flutter_qcabtaxi/ui/views/others/promo.dart';
import 'package:flutter_qcabtaxi/ui/views/others/qas.dart';
import 'package:flutter_qcabtaxi/ui/views/place/favouriteplace.dart';
import 'package:flutter_qcabtaxi/ui/views/ride/myride.dart';
import 'package:flutter_qcabtaxi/ui/views/user/profile.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Intro:
        return MaterialPageRoute(builder: (_) => OnBoardingPage());
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.Signup:
        return MaterialPageRoute(builder: (_) => SignupView());
      case RoutePaths.Verify:
        return MaterialPageRoute(builder: (_) => VerifyView());
      case RoutePaths.Profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case RoutePaths.Myride:
        return MaterialPageRoute(builder: (_) => MyRideView());
      case RoutePaths.Promo:
        return MaterialPageRoute(builder: (_) => PromoView());
      case RoutePaths.Contact:
        return MaterialPageRoute(builder: (_) => ContactView());
      case RoutePaths.Qas:
        return MaterialPageRoute(builder: (_) => QasView());
      case RoutePaths.Place:
        return MaterialPageRoute(builder: (_) => FavoriteView());
      case RoutePaths.Payment:
        return MaterialPageRoute(builder: (_) => PaymentView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
