import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chat_app/views/drawer/menu_drawer.dart';

class AnimationScreen extends StatefulWidget {
  static const routeName = '/animation-screen';

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<Size> _heightAnimation;


  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(microseconds: 300));
    _heightAnimation = Tween<Size>(
            begin: Size(double.infinity, 260), end: Size(double.infinity, 320))
        .animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.fastOutSlowIn,
    ));
    _heightAnimation.addListener(()=>setState(() {
      
    }) );
  }
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Animation'),
        ),
        drawer: MenuDrawer(),
        body: SingleChildScrollView(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: Container(
              height: _heightAnimation.value.height,
              constraints: BoxConstraints(minHeight: _heightAnimation.value.height),
              child:Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'i farted'),
                )
              ],
            ),
            )
          ),
        ));
  }
}
