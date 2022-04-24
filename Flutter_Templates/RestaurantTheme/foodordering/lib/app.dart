import 'package:flutter/material.dart';
import 'package:foodordering/routes/routes.dart';

import 'screens/splash_screen/splash_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: "FoodOrdering",
      home: SplashScreen(),
      routes: SetUpRoutes.routes,
    );
  }
}
