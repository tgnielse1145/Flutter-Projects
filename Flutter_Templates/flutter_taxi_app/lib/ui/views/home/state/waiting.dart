import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/utils/device_utils.dart';
import 'package:flutter_qcabtaxi/core/viewmodel/map_model.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:slider_button/slider_button.dart';

class Waiting extends StatefulWidget {
  final MapModel model;

  const Waiting({Key key, this.model}) : super(key: key);

  @override
  _WaitingState createState() => _WaitingState(model);
}

class _WaitingState extends State<Waiting> {
  final MapModel model;
  Timer _timer;
  int _start = 10;

  _WaitingState(this.model);

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            model.go_onway();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: double.infinity,
        color: Colors.black.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              UIHelper.verticalSpaceLarge,
              SizedBox(
                height: DeviceUtils.getScaledWidth(context, 1 / 2),
                child: FlareActor(
                  'assets/flare/wait.flr',
                  alignment: Alignment.topCenter,
                  fit: BoxFit.contain,
                  animation: 'play',
                ),
              ),
              //Spacer(),
              UIHelper.verticalSpaceLarge,
              Text(
                "Go to onway autocratically $_start s",
                style: normalStyle,
              ),
              UIHelper.verticalSpaceLarge,
              Center(
                  child: SliderButton(
                vibrationFlag: false,
                action: () {
                  print('action');
                  widget.model.reset();
                },
                label: Text(
                  "Slide to cancel",
                  style: TextStyle(
                      color: Color(0xff4a4a4a),
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                icon: Text(
                  "x",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 32,
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
