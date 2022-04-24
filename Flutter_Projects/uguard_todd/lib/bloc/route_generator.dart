import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uguard_app/bloc/route_generator.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';
import 'package:uguard_app/views/camera/edit_photo_page.dart';
class RouteGenerator {
 static const String routeHome = 'menu-drawer';
 static const String routeEdit = 'menu-drawer';
 static File? file;
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => MenuDrawer());
        
      case routeEdit:
        return MaterialPageRoute(
            builder: (_) => EditPhotoPage(
                  image: file,
                ));
   
    }
    dynamic fart=file;
    return fart;
    
  }
}