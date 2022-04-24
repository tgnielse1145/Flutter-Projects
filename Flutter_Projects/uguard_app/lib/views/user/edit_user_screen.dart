import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:uguard_app/controllers/auth.dart';
import 'package:uguard_app/controllers/user_controller.dart';

import 'package:uguard_app/models/validation.dart';
import 'package:uguard_app/models/uguarduser.dart';
import 'package:uguard_app/views/drawer/footer_drawer.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';

class EditUserScreen extends StatefulWidget {
  static const routeName = '/edit-user';
  
  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
   // final GlobalKey<FormState> _form = GlobalKey();
    final _nameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();
  var _isInit = true;
  //var _isInit = true;
  var _isLoading = false;
  Validations validations = new Validations();
   
  var _editedUser = UguardUser(
    id: null, 
    name: '', 
    phone: '', 
    email: '',
    );
  var _initValues = {
    'name': '',
    'phone': '',
    'email': '',
    'role':'',
  };
  @override
  void dispose() {
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }


  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }


 

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
   if(_editedUser.id!=null){
     await Provider.of<UserController>(context, listen:false).updateUser(_editedUser.id!, _editedUser);
   }
   else{
      try{
        await Provider.of<UserController>(context,listen:false).addUser(_editedUser);
      }catch(error){
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occurred!'),
                content: Text('Something went wrong.'),
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
   }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
      
    
  }
   @override
  void didChangeDependencies() {
    if (_isInit) {
      final userId= Provider.of<UserController>(context,listen:false).currUserId;
      if (userId != null) {
        _editedUser = Provider.of<UserController>(context, listen: false).findById(userId);
        _initValues = {
          'name': _editedUser.name!,
          'phone': _editedUser.phone!,
          'email': _editedUser.email!,
          //'imageUrl': _editedUser.imageUrl!,
        };
       // _imageUrlController.text = _editedUser.imageUrl!;
      }
     
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit/Setup User Profile '),
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
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_){
                        FocusScope.of(context).requestFocus(_nameFocusNode);
                      },
                      validator: (value) {
                        validations.validateName(value!);
                      },
                      onSaved: (value) {
                        _editedUser = UguardUser(
                            id: _editedUser.id,
                            name: value,
                            phone: _editedUser.phone,
                            email: _editedUser.email,
                           
                            );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['phone'],
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      focusNode: _phoneFocusNode,
                      onFieldSubmitted: (_){
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                      validator: (value) {
                        validations.validatePhone(value!);
                      },
                      onSaved: (value) {
                         _editedUser = UguardUser(
                            id: _editedUser.id,
                            name: _editedUser.name,
                            phone: value,
                            email: _editedUser.email,
                            
                            );
                      },
                    ),   
                    TextFormField(
                      initialValue: _initValues['email'],
                      decoration: InputDecoration(labelText: 'Email'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: (_){
                        FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                      },
                      validator: (value) {
                        validations.validatePhone(value!);
                      },
                      onSaved: (value) {
                         _editedUser = UguardUser(
                            id: _editedUser.id,
                            name: _editedUser.name,
                            phone: value,
                            email: _editedUser.email,
                            
                            );
                      },
                    ), 
                             Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(
                          top: 8,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Enter a URL')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _imageUrlFocusNode,
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              //value = "https://images.pexels.com/photos/1446948/pexels-photo-1446948.jpeg?cs=srgb&dl=pexels-engin-akyurt-1446948.jpg&fm=jpg";
                              //return 'Please enter an image URL.';
                             return null;
                            }
                            else{
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL.';
                            }
                            // if (!value.endsWith('.png') &&
                            //     !value.endsWith('.jpg') &&
                            //     !value.endsWith('.jpeg')) {
                            //   return 'Please enter a valid image URL.';
                            // }
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedUser = UguardUser(
                                name: _editedUser.name,
                                phone: _editedUser.phone,
                                email: _editedUser.email,
                                imageUrl: value == null ? " ": _editedUser.imageUrl,
                                id: _editedUser.id);
                          },
                        ),
                      ),
                    ],
                  ),                                       
                  ],
                ),
              )),
      floatingActionButton: FooterDrawer(),
    );
  }

  
}
