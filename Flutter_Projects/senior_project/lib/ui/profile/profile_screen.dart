import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uguard_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:uguard_app/constants.dart';
import 'package:uguard_app/services/helper.dart';
import 'package:uguard_app/ui/editProfile/edit_screen.dart';
import 'package:uguard_app/ui/profile/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  late User user;
  VoidCallback? onClick;
  CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(COLOR_PRIMARY),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 15),
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.profilePictureURL,
            onClicked: () {
              push(context, EditProfileScreen(user: user));
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildButton(
                  context, user.contacts.length.toString(), 'Respondents'),
              buildDivider(),
              buildButton(
                  context, user.dependents.length.toString(), 'Dependents'),
            ],
          ),
          const SizedBox(height: 48),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.firstName + ' ' + user.lastName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            '@' + user.userName,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Email: ',
                  style: TextStyle(
                      fontSize: 16, height: 1.4, fontWeight: FontWeight.bold),
                ),
                Text(
                  user.email,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Phone: ',
                  style: TextStyle(
                      fontSize: 16, height: 1.4, fontWeight: FontWeight.bold),
                ),
                Text(
                  user.phone,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
