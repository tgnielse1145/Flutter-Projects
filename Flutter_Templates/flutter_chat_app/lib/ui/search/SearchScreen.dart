import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instachatty/constants.dart';
import 'package:instachatty/model/ContactModel.dart';
import 'package:instachatty/model/ConversationModel.dart';
import 'package:instachatty/model/HomeConversationModel.dart';
import 'package:instachatty/model/User.dart';
import 'package:instachatty/services/FirebaseHelper.dart';
import 'package:instachatty/services/helper.dart';
import 'package:instachatty/ui/chat/ChatScreen.dart';

List<ContactModel> _searchResult = [];

List<ContactModel> _contacts = [];

class SearchScreen extends StatefulWidget {
  final User user;

  const SearchScreen({Key? key, required this.user}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late User user;
  TextEditingController controller = TextEditingController();
  final fireStoreUtils = FireStoreUtils();

  late Future<List<ContactModel>> _future;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    _future = fireStoreUtils.getContacts(user.userID, true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
          child: TextField(
            controller: controller,
            onChanged: _onSearchTextChanged,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                fillColor: isDarkMode(context) ? Colors.grey[700] : Colors.grey[200],
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(360),
                    ),
                    borderSide: BorderSide(style: BorderStyle.none)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(360),
                    ),
                    borderSide: BorderSide(style: BorderStyle.none)),
                hintText: tr('searchForFriends'),
                suffixIcon: IconButton(
                  iconSize: 20,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    controller.clear();
                    _onSearchTextChanged('');
                  },
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                )),
          ),
        ),
        FutureBuilder<List<ContactModel>>(
          future: _future,
          initialData: [],
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Expanded(
                child: Container(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
                    ),
                  ),
                ),
              );
            } else if (!snap.hasData || (snap.data?.isEmpty ?? true)) {
              return Expanded(
                child: Center(
                  child: Text(
                    'noUsersFound',
                    style: TextStyle(fontSize: 18),
                  ).tr(),
                ),
              );
            } else {
              return Expanded(
                  child: _searchResult.length != 0 || controller.text.isNotEmpty
                      ? buildList(_searchResult, true)
                      : buildList(snap.data!, false));
            }
          },
        )
      ],
    );
  }

  _onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _contacts.forEach((contact) {
      if (contact.user.fullName().toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(contact);
      }
    });
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    _searchResult.clear();
    super.dispose();
  }

  String getStatusByType(ContactType type) {
    switch (type) {
      case ContactType.ACCEPT:
        return 'accept';
      case ContactType.PENDING:
        return 'cancel';
      case ContactType.FRIEND:
        return 'unfriend';
      case ContactType.UNKNOWN:
        return 'addFriend';
      case ContactType.BLOCKED:
        return 'unblock';
      default:
        return 'addFriend';
    }
  }

  _onContactButtonClicked(ContactModel contact, int index, bool fromSearch) async {
    switch (contact.type) {
      case ContactType.ACCEPT:
        showProgress(context, 'acceptingFriendship'.tr(), false);
        await fireStoreUtils.onFriendAccept(contact.user);

        if (fromSearch) {
          _searchResult[index].type = ContactType.FRIEND;
          _contacts
              .where((user) => user.user.userID == contact.user.userID)
              .first
              .type = ContactType.FRIEND;
        } else {
          _contacts[index].type = ContactType.FRIEND;
        }

        break;
      case ContactType.FRIEND:
        showProgress(context, 'removingFriendship'.tr(), false);
        await fireStoreUtils.onUnFriend(contact.user);
        if (fromSearch) {
          _searchResult[index].type = ContactType.UNKNOWN;
          _contacts
              .where((user) => user.user.userID == contact.user.userID)
              .first
              .type = ContactType.UNKNOWN;
        } else {
          _contacts[index].type = ContactType.UNKNOWN;
        }
        break;
      case ContactType.PENDING:
        showProgress(context, 'removingFriendshipRequest'.tr(), false);
        await fireStoreUtils.onCancelRequest(contact.user);
        if (fromSearch) {
          _searchResult[index].type = ContactType.UNKNOWN;
          _contacts
              .where((user) => user.user.userID == contact.user.userID)
              .first
              .type = ContactType.UNKNOWN;
        } else {
          _contacts[index].type = ContactType.UNKNOWN;
        }

        break;
      case ContactType.BLOCKED:
        break;
      case ContactType.UNKNOWN:
        showProgress(context, 'sendingFriendshipRequest'.tr(), false);
        await fireStoreUtils.sendFriendRequest(contact.user);
        if (fromSearch) {
          _searchResult[index].type = ContactType.PENDING;
          _contacts
              .where((user) => user.user.userID == contact.user.userID)
              .first
              .type = ContactType.PENDING;
        }
        break;
    }
  }

  buildList(List<ContactModel> list, bool fromSearch) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          ContactModel contact = list[index];
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: ListTile(
                  onTap: () async {
                    String channelID;
                    if (contact.user.userID.compareTo(user.userID) < 0) {
                      channelID = contact.user.userID + user.userID;
                    } else {
                      channelID = user.userID + contact.user.userID;
                    }
                    ConversationModel? conversationModel =
                        await fireStoreUtils.getChannelByIdOrNull(channelID);
                    push(
                        context,
                        ChatScreen(
                            homeConversationModel: HomeConversationModel(
                                isGroupChat: false,
                                members: [contact.user],
                                conversationModel: conversationModel)));
                  },
                  leading:
                      displayCircleImage(contact.user.profilePictureURL, 55, false),
                  title: Text(
                    '${contact.user.fullName()}',
                    style: TextStyle(
                        color: isDarkMode(context) ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  trailing: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: isDarkMode(context)
                          ? Colors.grey.shade700
                          : Colors.grey.shade200,
                    ),
                    onPressed: () async {
                      await _onContactButtonClicked(contact, index, fromSearch);
                      hideProgress();
                      setState(() {});
                    },
                    child: Text(
                      getStatusByType(contact.type),
                      style: TextStyle(
                          color: isDarkMode(context) ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ).tr(),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
