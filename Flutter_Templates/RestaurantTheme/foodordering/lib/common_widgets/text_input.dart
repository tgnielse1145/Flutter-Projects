import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';

class InputField extends StatelessWidget {
  final dynamic controller;
  final dynamic icon;
  final String hint;
  final bool protected;
  final dynamic validate;
  final bool enable;
  final TextInputType type;
  final FocusNode node;
  final FocusNode nextnode;
  final bool border;
  final bool margin;

  InputField(
      {this.icon,
      this.controller,
      this.hint,
      this.protected,
      this.validate,
      this.enable,
      this.type,
      this.node,
      this.nextnode,
      this.border,
      this.margin});

  @override
  Widget build(BuildContext context) {
    ScreenRatio.setScreenRatio(context);
    return new Container(
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              margin: margin
                  ? const EdgeInsets.only(left: 12, right: 12)
                  : const EdgeInsets.all(0),
              decoration: new BoxDecoration(
                border: border
                    ? Border(
                        bottom:
                            new BorderSide(color: Colors.black54, width: .5))
                    : Border(),
              ),
              child: new TextFormField(
                initialValue: controller == null ? controller : null,
                focusNode: node,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(nextnode);
                },
                obscureText: protected,
                keyboardType: type,
                enabled: enable == false ? enable : true,
                controller: controller,
                validator: validate,
                style: new TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                ),
                decoration: new InputDecoration(
                  suffixText:
                      icon == StringNames.PASSWORD ? StringNames.FORGET : "",
                  suffixStyle: TextStyle(color: Colors.black),
                  hintText: hint,
                  enabled: true,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintStyle: new TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w300,
                      fontSize: 15.0),
                  fillColor: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
