import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';

class H1 extends StatelessWidget {
  final String text;

  const H1({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: headerStyle,);
  }
}


class H2 extends StatelessWidget {
  final String text;

  const H2({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: H2style,);
  }
}


class H3 extends StatelessWidget {
  final String text;

  const H3({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: H3style,);
  }
}
