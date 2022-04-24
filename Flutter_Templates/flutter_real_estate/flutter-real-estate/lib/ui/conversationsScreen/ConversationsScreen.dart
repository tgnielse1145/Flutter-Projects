import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_listings/model/HomeConversationModel.dart';
import 'package:flutter_listings/model/User.dart';
import 'package:flutter_listings/services/FirebaseHelper.dart';
import 'package:flutter_listings/services/helper.dart';
import 'package:flutter_listings/ui/chat/ChatScreen.dart';

class ConversationsScreen extends StatefulWidget {
  final User user;

  const ConversationsScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() {
    return _ConversationsState();
  }
}

class _ConversationsState extends State<ConversationsScreen> {
  late User user;
  final fireStoreUtils = FireStoreUtils();
  late Stream<List<HomeConversationModel>> _conversationsStream;

  @override
  void initState() {
    user = widget.user;
    super.initState();
    fireStoreUtils.getBlocks().listen((shouldRefresh) {
      if (shouldRefresh) {
        setState(() {});
      }
    });
    _conversationsStream = fireStoreUtils.getConversations(user.userID);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HomeConversationModel>>(
      stream: _conversationsStream,
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: _emptyState(),
          ));
        } else {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final homeConversationModel = snapshot.data![index];
                if (homeConversationModel.isGroupChat) {
                  return Container();
                } else {
                  return fireStoreUtils.validateIfUserBlocked(
                          homeConversationModel.members.first.userID)
                      ? Container(
                          width: 0,
                          height: 0,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, top: 8, bottom: 8),
                          child: _buildConversationRow(homeConversationModel),
                        );
                }
              });
        }
      },
    );
  }

  Widget _buildConversationRow(HomeConversationModel homeConversationModel) {
    return InkWell(
      onTap: () {
        push(context, ChatScreen(homeConversationModel: homeConversationModel));
      },
      child: Row(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              displayCircleImage(
                  homeConversationModel.members.first.profilePictureURL, 60, false),
              Positioned(
                  right: 2.4,
                  bottom: 2.4,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        color: homeConversationModel.members.first.active
                            ? Colors.green
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: isDarkMode(context)
                                ? Color(0xFF303030)
                                : Colors.white,
                            width: 1.6)),
                  ))
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, right: 8, left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${homeConversationModel.members.first.fullName()}',
                    style: TextStyle(
                        fontSize: 17,
                        color: isDarkMode(context) ? Colors.white : Colors.black,
                        fontFamily: Platform.isIOS ? 'sanFran' : 'Roboto'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '${homeConversationModel.conversationModel?.lastMessage} • ${formatTimestamp(homeConversationModel.conversationModel?.lastMessageDate.seconds ?? 0)}',
                      maxLines: 1,
                      style: TextStyle(fontSize: 14, color: Color(0xffACACAC)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 30),
        Text('No Conversations'.tr(),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        Text(
          'All your conversations will show up here.'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}
