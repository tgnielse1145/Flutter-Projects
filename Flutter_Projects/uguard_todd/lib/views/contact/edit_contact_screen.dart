import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uguard_app/models/contact.dart';
import 'package:uguard_app/controllers/contacts_controller.dart';
import 'package:uguard_app/views/drawer/footer_drawer.dart';
import 'package:uguard_app/views/drawer/menu_drawer.dart';

class EditContactScreen extends StatefulWidget {
  static const routeName = '/edit-contact';

  @override
  _EditContactScreenState createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  //create focus nodes so it's easier for the user to input their data
  final _nameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading =false;

  var _editedContact = Contact(
    id: null,
    name: '',
    phone: '',
    email: '',
    imageUrl: 'https://images.pexels.com/photos/1446948/pexels-photo-1446948.jpeg?cs=srgb&dl=pexels-engin-akyurt-1446948.jpg&fm=jpg',
  );
  var _initValues = {
    'name': '',
    'phone': '',
    'email': '',
    'imageUrl': 'https://images.pexels.com/photos/1446948/pexels-photo-1446948.jpeg?cs=srgb&dl=pexels-engin-akyurt-1446948.jpg&fm=jpg',
  };
  //dispose of the focus nodes
  @override
  void dispose() {
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  //update the imageUrl
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

  //add listener for the url
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  Future<void> _saveForm() async{
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading=true;
    });
    if (_editedContact.uguardUserId != null) {
      await Provider.of<ContactsController>(context, listen: false)
          .updateContacts(_editedContact.id!, _editedContact);
    } else {
      try{
      await Provider.of<ContactsController>(context, listen: false)
          .addContacts(_editedContact);
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
      final contactId = ModalRoute.of(context)?.settings.arguments as String?;
      if (contactId != null) {
        _editedContact = Provider.of<ContactsController>(context, listen: false)
            .findById(contactId);
        _initValues = {
          'name': _editedContact.name!,
          'phone': _editedContact.phone!,
          'email': _editedContact.email!,
          'imageUrl': _editedContact.imageUrl!,
        };
        _imageUrlController.text = _editedContact.imageUrl!;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add/Edit Contacts'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveForm,
            ),
          ],
        ),
        drawer: MenuDrawer(),
        body: _isLoading ? Center(
          child:CircularProgressIndicator(),
        ):
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _form,
                child: ListView(children: <Widget>[
                  TextFormField(
                    initialValue: _initValues['name'],
                    decoration: InputDecoration(labelText: 'Name'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_phoneFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedContact = Contact(
                          name: value,
                          phone: _editedContact.phone,
                          email: _editedContact.email,
                          imageUrl: _editedContact.imageUrl,
                          id: _editedContact.id);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['phone'],
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    focusNode: _phoneFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a phone number.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedContact = Contact(
                          name: _editedContact.name,
                          phone: value,
                          email: _editedContact.email,
                          imageUrl: _editedContact.imageUrl,
                          id: _editedContact.id);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['email'],
                    decoration: InputDecoration(labelText: 'Email'),
                    textInputAction: TextInputAction
                        .next, //makes it so pushing enter or arrow over deosnt submit the whole page
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedContact = Contact(
                          name: _editedContact.name,
                          phone: _editedContact.phone,
                          email: value,
                          imageUrl: _editedContact.imageUrl,
                          id: _editedContact.id);
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
                            _editedContact = Contact(
                                name: _editedContact.name,
                                phone: _editedContact.phone,
                                email: _editedContact.email,
                                imageUrl: value == null ? " ": _editedContact.imageUrl,
                                id: _editedContact.id);
                          },
                        ),
                      ),
                    ],
                  ),
                ]
              )
            )
          ),
          floatingActionButton: FooterDrawer(),
        );
  }
}
