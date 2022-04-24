import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uguard_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:uguard_app/constants.dart';
import 'package:uguard_app/services/authenticate.dart' as auth;
import 'package:uguard_app/services/helper.dart';
import 'package:uguard_app/ui/home/home_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  late User user;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController userNameController;
  String? searchQuery;
  CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    user = widget.user;
    nameController =
        TextEditingController(text: '${user.firstName} ${user.lastName}');
    phoneController = TextEditingController(text: user.phone);
    userNameController = TextEditingController(text: user.userName);
    emailController = TextEditingController(text: user.email);
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
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
              child: Stack(
            children: [
              buildImage(),
              Positioned(
                child: buildEditIcon(
                  const Color(COLOR_PRIMARY),
                ),
                bottom: 0,
                right: 3,
              ),
            ],
          )),
          const SizedBox(
            height: 15,
          ),
          buildTextBox('Full Name', nameController),
          const SizedBox(
            height: 15,
          ),
          buildTextBox('Email', emailController),
          const SizedBox(
            height: 15,
          ),
          buildTextBox('Username', userNameController),
          const SizedBox(
            height: 15,
          ),
          buildTextBox('Phone', phoneController),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(COLOR_PRIMARY),
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: const BorderSide(
                      color: Color(COLOR_PRIMARY),
                    ),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => {saveUserData()}),
          ),
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

  Widget buildImage() {
    final image = NetworkImage(user.profilePictureURL);

    return ClipOval(
        child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: image,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
              //child: InkWell(onTap: onClicked),
            )));
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 15,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  void saveUserData() async {
    //Setting up the new values
    user.firstName = nameController.text.split(' ')[0];
    user.lastName = nameController.text.split(' ')[1];
    user.phone = phoneController.text;
    user.userName = userNameController.text;

    auth.FireStoreUtils.updateCurrentUser(user);
    pushAndRemoveUntil(context, HomeScreen(user: user), true);
  }
}

Widget buildTextBox(String text, TextEditingController? controller) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: 1,
        ),
      ],
    );
