import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';

class MyContainer2 extends StatelessWidget {
  final Widget child;

  const MyContainer2({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: SecondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: child);
  }
}
