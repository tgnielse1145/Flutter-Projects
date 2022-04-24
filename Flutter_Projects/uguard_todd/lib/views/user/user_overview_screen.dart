import 'package:flutter/material.dart';
import 'package:uguard_app/models/validation.dart';
import 'package:uguard_app/views/drawer/footer_drawer.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';
import 'package:uguard_app/controllers/user_controller.dart';
import 'package:uguard_app/models/uguarduser.dart';
import 'package:provider/provider.dart';

class UserOverviewScreen extends StatefulWidget {
  static const routeName = '/user-overview';
  @override
  _UserOverviewScreenState createState() => _UserOverviewScreenState();
}

class _UserOverviewScreenState extends State<UserOverviewScreen> {
  Validations validations = new Validations();
  var _isInit = true;
//var _isLoading =false;
//var _showOnlyFavorites=false;
  String? userName;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        // _isLoading=true;
      });
      //change the getAndSetContacts below back to fetchAndSetContacts

    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //userName = Provider.of<UserController>(context, listen: false).getUserName!;
   // final currUser=Provider.of<UserController>(context,listen:false).findById(_id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Overview Screen '),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              getUserId(context);
            },
          ),
        ],
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height:300,
              width:double.infinity,
              // child:Image.network(
              // //  currUser.
              // )
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text(' INSTEAD'),
              onPressed: () {
                getRoleScreen(context);
              },
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
      floatingActionButton: FooterDrawer(),
    );
  }

  void getUserId(BuildContext context) async {
    // Provider.of<UserController>(context).decidedRole();
  }
  void getRoleScreen(BuildContext context) async {}
}
