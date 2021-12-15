import 'package:flutter/material.dart';
import 'package:uguard_app/models/validation.dart';
import 'package:uguard_app/views/drawer/footer_drawer.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';
 import 'package:uguard_app/controllers/user_controller.dart';
import 'package:uguard_app/models/uguarduser.dart';
 import 'package:provider/provider.dart';
import 'package:uguard_app/views/user/edit_user_screen.dart';
class UserOverviewScreen extends StatefulWidget {
  static const routeName = '/user-overview';
  @override
  _UserOverviewScreenState createState() => _UserOverviewScreenState();
}

class _UserOverviewScreenState extends State<UserOverviewScreen> {
  Validations validations = new Validations();
//   var _isInit = true;
//   var _isLoading =false;
// //var _showOnlyFavorites=false;
//   String? userName;
  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //        _isLoading=true;
  //     });
  //     //change the getAndSetContacts below back to fetchAndSetContacts
  //     Provider.of<UserController>(context).getAndSetUsers();//.then((_){
  //     //   setState(() {
  //     //     _isLoading=false;
  //     //   });
  //     // });

  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
   // Provider.of<UserController>(context).getAndSetUsers();
    final userId= Provider.of<UserController>(context,listen:false).currUserId;
    final loadedUser= Provider.of<UserController>(context,listen: false).findById(userId);
    final placeHolder =   'https://images.pexels.com/photos/1446948/pexels-photo-1446948.jpeg?cs=srgb&dl=pexels-engin-akyurt-1446948.jpg&fm=jpg';

    return Scaffold(
      appBar: AppBar(
        title:  Text(loadedUser.name!),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(EditUserScreen.routeName);
            },
          ),
        ],
      ),
      drawer: MenuDrawer(),
      body: 
        
        SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height:300,
              width:double.infinity,
              child: loadedUser.imageUrl!.isEmpty ? Image.network(
                placeHolder,
                fit:BoxFit.cover) 
                : Image.asset('assets/images/user_icon.png',
                fit:BoxFit.cover),
              // fit: BoxFit.cover,
              
             
            ),
            SizedBox(height: 10),
             Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedUser.name!,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 30)
                )
                ),
                SizedBox(
              height: 10,
            ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedUser.phone!,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 30)
                )
                ),
                 SizedBox(
              height: 10,
            ),
             Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedUser.email!,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 30)
                )
                ),
            // ignore: deprecated_member_use
            
          ],
        ),
      ),
      floatingActionButton: FooterDrawer(),
    );
  }

  
}
