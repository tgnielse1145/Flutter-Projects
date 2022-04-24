import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:uguard_app/models/contact.dart';
import 'package:uguard_app/models/uguarduser.dart';

String mapKey = "AIzaSyD3ix5v_gZCqlz674CcshqlDirm6UUOoh0";
//String mapKey = "AIzaSyC4757uOGySvpbD_eix3tkmh6lqLsl4Q6o";
String SERVER_KEY = "AAAA7q0NDxE:APA91bFgbAueT6epCI7PYJmYbGaxwO-YGwFhy1m5Ea_dWHpiRaDB4T_1iV9fBZR2w8aptyVofQ9aQ5k7cXaEvnOAxElUAadsntQwikC1Q5Ucz2H4jQp0yYKMXbkM4RkGmYylVSNIcJ3R";

Position? currentPosition;
String? currentfirebaseUser;
String? currentfirebaseUserId;
//String? _userId;
StreamSubscription<Position>? userOverviewScreenStreamSubscription;
StreamSubscription<Position>? userStreamSubscription;

Contact? contactInformation;
UguardUser? userInformation;

