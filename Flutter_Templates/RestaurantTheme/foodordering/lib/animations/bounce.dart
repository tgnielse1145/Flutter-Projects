import 'package:flutter/material.dart';

class Bounce extends StatefulWidget {
  final Widget child;
  final Duration;

  const Bounce(this.child, this.Duration);

  @override
  _BounceState createState() => _BounceState();
}

class _BounceState extends State<Bounce> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
      lowerBound: 0,
      upperBound: widget.Duration,
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller?.dispose();
    controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: controller.value),
      child: widget.child,
    );
  }
}
