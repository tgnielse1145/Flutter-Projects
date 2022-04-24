import 'package:flutter/material.dart';


class AnimationScreen extends StatefulWidget {
  static const routeName = '/animation-screen';

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>{
    
      bool isOpen=false;
  
  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Animation test'),),
        body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            ],
          )
        ),
        // floatingActionButton: FloatingActionButton(
        // //  onPressed: () => _clickFab(key),
        //   child: Icon(Icons.add)
        // ),
      //  body: InkWell(
      //    onTap:(){
      //      setState((){
      //        isOpen=!isOpen;
      //        print('ont tap pressed');
      //      });
      //    },
      //    child: Center(
      //      child:FlareActor('assets/animations/teddy.flr',
      //      animation: "circle",
           
      //     // isOpen==true ? "actvate": "deactivate"),
           
      //      )
      //  ),
      //  )
       );
  }
}
