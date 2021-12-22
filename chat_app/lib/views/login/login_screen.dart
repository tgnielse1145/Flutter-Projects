import 'package:chat_app/provider/firebase_util.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/views/drawer/menu_drawer.dart';
import 'package:chat_app/models/validate.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  AutovalidateMode _validate=AutovalidateMode.disabled;
   final _emailFocusNode = FocusNode();
    final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  String? _email, _password;

 @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }
_login () async{
  final isValid=_form.currentState!.validate();
  if(!isValid){
    return;
  }
  _form.currentState!.save();
  print('here is _email '+ _email! + ' _password '+ _password!);
  FirebaseUtil.loginWithEmailAndPassword(_email!, _password!);
  Navigator.of(context).pop();

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login ',
        style: TextStyle(
         // backgroundColor: Color.fromRGBO(215, 117, 231, 1),
        ),), actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.login_rounded),
            onPressed: () {},
          )
        ]),
        drawer: MenuDrawer(),
        body: Form(
          key: _form,
          autovalidateMode: _validate,
            child: Container(
                margin: EdgeInsets.all(12.0),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:Text('Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.black,
                        fontSize: 50, 
                        fontFamily: 'ChanceryCursive'                       

                        )
                      )
                    ),
                      TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      validator: validateEmail,
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                     TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_confirmPasswordFocusNode);
                      },
                      validator: validatePassword,
                      onSaved:(value){
                        _password=value;
                      }
                      
                    ),
                                    
                    
                    ElevatedButton(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          shape: const BeveledRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ))),
                      onPressed: _login// (){},//getUserAddress,
                    ),
                  ],
                ),
              )
            )
          );
  }
}
