import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uguard_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:uguard_app/constants.dart';
import 'package:uguard_app/services/helper.dart';

import 'package:uguard_app/services/authenticate.dart' as auth;

class DependentScreen extends StatefulWidget {
  final User user;
  const DependentScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _DependentState();
}

class _DependentState extends State<DependentScreen> {
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
              onPressed: () => setState(() {
                    users.snapshots();
                  }),
              icon: const Icon(Icons.refresh))
        ],
        title: const Text(
          'Dependents',
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
          buildDependentsList(),
        ],
      ),
    );
  }

  Widget buildDependentsList() {
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

                if (user.dependents.containsKey(documentSnapshot['id'])) {
                  // If the user exist in the dependent list
                  if (user.dependents[documentSnapshot['id']] == true) {
                    // And are approved friends
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['firstName'] +
                            ' ' +
                            documentSnapshot['lastName']),
                        subtitle:
                            Text('@' + documentSnapshot['userName'].toString()),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              // Press this button to edit a single product
                              IconButton(
                                  icon: const Icon(
                                      Icons.supervised_user_circle_outlined),
                                  color: Colors.greenAccent,
                                  onPressed: () {}),
                              IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    removeDependents(documentSnapshot.id);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['firstName'] +
                            ' ' +
                            documentSnapshot['lastName']),
                        subtitle:
                            Text('@' + documentSnapshot['userName'].toString()),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              // Press this button to edit a single product
                              IconButton(
                                  icon: const Icon(Icons.add),
                                  color: Colors.greenAccent,
                                  onPressed: () {
                                    acceptRequest(documentSnapshot.id);
                                    sendNotification([
                                      documentSnapshot['tokenId']
                                    ], '${user.userName} is now your responder!',
                                        'Friend Request Accepted');
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    removeDependents(documentSnapshot.id);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  return const Card();
                }
              });
        });
  }

  void acceptRequest(String id) async {
    user.dependents
        .addAll({id: true}); // Accept adding the user as your dependent

    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await users.doc(id).get();

    User addUser = User.fromJson(userDocument.data()!);
    addUser.contacts.addAll({user.userID: true}); // Accept on the contact side
    auth.FireStoreUtils.updateCurrentUser(user);
    auth.FireStoreUtils.updateCurrentUser(addUser);
    setState(() {});
  }

  void removeDependents(String contactId) async {
    user.dependents.remove(contactId);

    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await users.doc(contactId).get();

    User removeUser = User.fromJson(userDocument.data()!);
    removeUser.contacts.remove(user.userID);
    auth.FireStoreUtils.updateCurrentUser(user);
    auth.FireStoreUtils.updateCurrentUser(removeUser);
    setState(() {});
  }
}
