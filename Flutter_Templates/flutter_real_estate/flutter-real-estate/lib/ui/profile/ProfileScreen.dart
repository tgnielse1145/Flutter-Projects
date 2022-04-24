import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_listings/constants.dart';
import 'package:flutter_listings/main.dart';
import 'package:flutter_listings/model/User.dart';
import 'package:flutter_listings/services/FirebaseHelper.dart';
import 'package:flutter_listings/services/helper.dart';
import 'package:flutter_listings/ui/accountDetails/AccountDetailsScreen.dart';
import 'package:flutter_listings/ui/adminDashboard/AdminDashboardScreen.dart';
import 'package:flutter_listings/ui/auth/AuthScreen.dart';
import 'package:flutter_listings/ui/contactUs/ContactUsScreen.dart';
import 'package:flutter_listings/ui/favoriteListings/FavoriteListingsScreen.dart';
import 'package:flutter_listings/ui/myListings/MyListingsScreen.dart';
import 'package:flutter_listings/ui/reauthScreen/reauth_user_screen.dart';
import 'package:flutter_listings/ui/settings/SettingsScreen.dart';
import 'package:flutter_listings/ui/upgradeAccount/UpgradeAccount.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  late User user;
  FireStoreUtils _fireStoreUtils = FireStoreUtils();

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isIOS
          ? AppBar(
              title: Text('Profile'.tr()),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 32, right: 32),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Center(
                    child:
                        displayCircleImage(user.profilePictureURL, 130, false)),
                Positioned(
                  left: 80,
                  right: 0,
                  child: FloatingActionButton(
                      backgroundColor: Color(COLOR_ACCENT),
                      child: Icon(
                        Icons.camera_alt,
                        color:
                            isDarkMode(context) ? Colors.black : Colors.white,
                      ),
                      mini: true,
                      onPressed: _onCameraClick),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 32, left: 32),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                user.fullName(),
                style: TextStyle(
                    color: isDarkMode(context) ? Colors.white : Colors.black,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  onTap: () {
                    push(context, MyListingsScreen());
                  },
                  title: Text(
                    'My Listings'.tr(),
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Image.asset(
                    'assets/images/listings_logo.png',
                    height: 24,
                    width: 24,
                    color: Color(COLOR_PRIMARY),
                  ),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    push(context, FavoriteListingScreen());
                  },
                  title: Text(
                    'My Favorites'.tr(),
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    push(context, AccountDetailsScreen(user: user));
                  },
                  title: Text(
                    'Account Details'.tr(),
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return UpgradeAccount();
                      },
                    );
                  },
                  title: Text(
                    user.isVip != null && user.isVip!
                        ? 'Cancel subscription'.tr()
                        : 'Upgrade Account'.tr(),
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Image.asset(
                    'assets/images/vip.png',
                    height: 24,
                    width: 24,
                  ),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    push(context, SettingsScreen(user: user));
                  },
                  title: Text(
                    'Settings'.tr(),
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(
                    Icons.settings,
                    color:
                        isDarkMode(context) ? Colors.white70 : Colors.black45,
                  ),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    push(context, ContactUsScreen());
                  },
                  title: Text(
                    'Contact Us'.tr(),
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                ),
                ListTile(
                  dense: true,
                  onTap: () async {
                    AuthProviders? authProvider;
                    List<auth.UserInfo> userInfoList =
                        auth.FirebaseAuth.instance.currentUser?.providerData ??
                            [];
                    await Future.forEach(userInfoList, (auth.UserInfo info) {
                      switch (info.providerId) {
                        case 'password':
                          authProvider = AuthProviders.PASSWORD;
                          break;
                        case 'phone':
                          authProvider = AuthProviders.PHONE;
                          break;
                        case 'facebook.com':
                          authProvider = AuthProviders.FACEBOOK;
                          break;
                        case 'apple.com':
                          authProvider = AuthProviders.APPLE;
                          break;
                      }
                    });
                    bool? result = await showDialog(
                      context: context,
                      builder: (context) => ReAuthUserScreen(
                        provider: authProvider!,
                        email: auth.FirebaseAuth.instance.currentUser!.email,
                        phoneNumber:
                            auth.FirebaseAuth.instance.currentUser!.phoneNumber,
                        deleteUser: true,
                      ),
                    );
                    if (result != null && result) {
                      await showProgress(
                          context, 'Deleting account...'.tr(), false);
                      await FireStoreUtils.deleteUser();
                      await hideProgress();
                      MyAppState.currentUser = null;
                      pushAndRemoveUntil(context, AuthScreen(), false);
                    }
                  },
                  title: Text(
                    'Delete Account'.tr(),
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(
                    CupertinoIcons.delete,
                    color: Colors.red,
                  ),
                ),
                if (user.isAdmin)
                  ListTile(
                    dense: true,
                    onTap: () {
                      push(context, AdminDashboardScreen());
                    },
                    title: Text(
                      'Admin Dashboard'.tr(),
                      style: TextStyle(fontSize: 16),
                    ),
                    leading: Icon(
                      Icons.dashboard,
                      color: Colors.blueGrey,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Text(
                  'Logout'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode(context) ? Colors.white : Colors.black,
                  ),
                ),
                onPressed: () async {
                  user.active = false;
                  user.lastOnlineTimestamp = Timestamp.now();
                  await FireStoreUtils.updateCurrentUser(user);
                  await auth.FirebaseAuth.instance.signOut();
                  MyAppState.currentUser = null;
                  pushAndRemoveUntil(context, AuthScreen(), false);
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _onCameraClick() {
    final action = CupertinoActionSheet(
      message: Text(
        'Add profile picture'.tr(),
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text('Remove Picture'.tr()),
          isDestructiveAction: true,
          onPressed: () async {
            Navigator.pop(context);
            showProgress(context, 'Removing picture...'.tr(), false);
            if (user.profilePictureURL.isNotEmpty)
              await _fireStoreUtils.deleteImage(user.profilePictureURL);
            user.profilePictureURL = '';
            await FireStoreUtils.updateCurrentUser(user);
            MyAppState.currentUser = user;
            hideProgress();
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Choose from gallery'.tr()),
          onPressed: () async {
            Navigator.pop(context);
            XFile? image =
                await _imagePicker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              await _imagePicked(File(image.path));
            }
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Take a picture'.tr()),
          onPressed: () async {
            Navigator.pop(context);
            XFile? image =
                await _imagePicker.pickImage(source: ImageSource.camera);
            if (image != null) {
              await _imagePicked(File(image.path));
            }
            setState(() {});
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'.tr()),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  Future<void> _imagePicked(File image) async {
    showProgress(context, 'Uploading image...'.tr(), false);
    user.profilePictureURL =
        await FireStoreUtils.uploadUserImageToFireStorage(image, user.userID);
    await FireStoreUtils.updateCurrentUser(user);
    MyAppState.currentUser = user;
    hideProgress();
  }
}
