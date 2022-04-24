import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:uguard_app/models/contact.dart';
import 'package:uguard_app/models/uguarduser.dart';
import 'package:firebase_auth/firebase_auth.dart';

String mapKey = "AIzaSyC4757uOGySvpbD_eix3tkmh6lqLsl4Q6o";

Position? currentPosition;
String? currentfirebaseUser;
String? currentfirebaseUserId;
String? _userId;
StreamSubscription<Position>? userOverviewScreenStreamSubscription;
StreamSubscription<Position>? userStreamSubscription;


Contact? contactInformation;
UguardUser? userInformation;

