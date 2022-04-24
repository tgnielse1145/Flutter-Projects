import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uguard_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:uguard_app/constants.dart';
import 'package:uguard_app/services/helper.dart';
import 'package:uguard_app/services/authenticate.dart' as auth;

class SearchScreen extends StatefulWidget {
  final User user;
  const SearchScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _SearchState();
}

class _SearchState extends State<SearchScreen> {
  late User user;
  String? searchQuery;
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
        actions: [
          IconButton(
              onPressed: () => setState(() {}), icon: const Icon(Icons.refresh))
        ],
        title: const Text(
          'Request a Responder',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(COLOR_PRIMARY),
        centerTitle: true,
      ),
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          buildFloatingSearchBar(),
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    return StreamBuilder(
        stream: users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(COLOR_PRIMARY),
              ),
            );
          }
          return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                Icon icon; // the icon to be assigned
                Color color;
                if (!user.contacts
                    .containsKey(documentSnapshot['id'].toString())) {
                  icon = const Icon(Icons.add);
                  color = Colors.greenAccent;
                } else if (user.contacts[documentSnapshot['id']].toString() ==
                    "true") {
                  icon = const Icon(Icons.check);
                  color = Colors.greenAccent;
                } else {
                  icon = const Icon(Icons.check);
                  color = Colors.yellow;
                }
                return user.userID == documentSnapshot['id']
                    ? const Card()
                    : Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(documentSnapshot['firstName'] +
                              ' ' +
                              documentSnapshot['lastName']),
                          subtitle: Text(
                              '@' + documentSnapshot['userName'].toString()),
                          trailing: SizedBox(
                            width: 50,
                            child: Row(
                              children: [
                                // Press this button to edit a single product
                                IconButton(
                                    icon: icon,
                                    color: color,
                                    onPressed: () {
                                      sendRequest(
                                          documentSnapshot['id'].toString());
                                      sendNotification([
                                        documentSnapshot['tokenId']
                                      ], 'Would you be my emergency responder?',
                                          'Friend Request from ${user.userName}');
                                    }),
                              ],
                            ),
                          ),
                        ),
                      );
              });
        });
  }

  void sendRequest(String id) async {
    if (user.contacts.containsKey(id)) {
      return;
    } else {
      user.contacts.addAll({id: false});
      DocumentSnapshot<Map<String, dynamic>> userDocument =
          await users.doc(id).get();

      User addUser = User.fromJson(userDocument.data()!);
      addUser.dependents.addAll({user.userID: false});
      auth.FireStoreUtils.updateCurrentUser(user);
      auth.FireStoreUtils.updateCurrentUser(addUser);
      setState(() {});
    }
  }
}
