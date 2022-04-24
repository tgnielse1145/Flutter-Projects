import 'dart:io';
import 'package:flutter/foundation.dart';
class Picture{
   final String? id;
   final String? title;
   final String? image;
   bool? uploadedPic;
  Picture({
    @required this.id,
    @required this.title,
    @required this.image,
    this.uploadedPic,
  });
}