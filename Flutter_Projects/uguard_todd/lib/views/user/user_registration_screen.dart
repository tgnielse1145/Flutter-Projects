import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uguard_app/controllers/auth.dart';
import 'package:uguard_app/controllers/user_controller.dart';
import 'package:uguard_app/models/validation.dart';
import 'package:uguard_app/models/uguarduser.dart';
import 'package:uguard_app/models/address.dart';
import 'package:uguard_app/views/drawer/footer_drawer.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';
import 'package:uguard_app/models/http_exception.dart';

class UserRegistrationScreen extends StatefulWidget {
  static const routeName = '/user-registration';
  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  Validations validations = new Validations();
  
  var _editedUser = UguardUser(
    id: '',
    name: '',
    phone: '',
    email: '',
   // userContacts: []
   
  );
  var _initValues = {
    'name': '',
    'phone': '',
    'email': '',
    'role': '',
  };
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      String? tempToken =
          Provider.of<Auth>(context, listen: false).token;
     
      if (_editedUser.name != '' && _editedUser.phone != '') {    
          
        _editedUser = UguardUser(
            id: Provider.of<Auth>(context, listen: false).userId!,
            phone: _editedUser.phone,
            name: _editedUser.name,
            email: Provider.of<Auth>(context, listen: false).userEmail!,          
            latitude: Provider.of<Address>(context,listen: false).userLat,
            longitude: Provider.of<Address>(context,listen: false).userLgt,
           );
      }
      await Provider.of<UserController>(context, listen: false)
          .addUser(_editedUser, tempToken!);
          
         
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    if (this.mounted) {
      setState(() {
        _isLoading = false;
      });
    }
    Navigator.of(context).pop();
  }
void locatePosition()async{
 await Provider.of<Address>(context,listen: false).getUserAddress();
}
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup User Profile '),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      drawer: MenuDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(11.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        validations.validateName(value!);
                      },
                      onSaved: (value) {
                        _editedUser = UguardUser(
                            id: _editedUser.id,
                            name: value,
                            phone: _editedUser.phone,
                            email: _editedUser.email,
                        //    userContacts: _editedUser.userContacts
                            );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['phone'],
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        String? validStr = validations.validatePhone(value!);
                        if (validStr != null) {
                          return validStr;
                        }
                      },
                      onSaved: (value) {
                        _editedUser = UguardUser(
                            id: _editedUser.id,
                            name: _editedUser.name,
                            phone: value,
                            email: _editedUser.email,
                         //   userContacts: _editedUser.userContacts
                          
                            );
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                   
                    ElevatedButton(
                      
                  child: Text( 'Provide Location',
                  style:TextStyle(
                    color: Colors.white,
                  ),),
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    
                    shape:const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )
                    )
                  ),
                  onPressed:  locatePosition,
                  ),      
                  
                  ],
                ),
              )),
      floatingActionButton: FooterDrawer(),
    );
  }
  


}
