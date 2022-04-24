import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/constants/app_contstants.dart';
import 'package:flutter_qcabtaxi/ui/router.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_qcabtaxi/provider_setup.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taxi Dark mode',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: PrimaryColor,
          fontFamily: 'Avenir',
        ),
        initialRoute: RoutePaths.Intro,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}