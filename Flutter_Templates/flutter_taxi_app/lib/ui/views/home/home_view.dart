import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/constants/enum.dart';
import 'package:flutter_qcabtaxi/core/utils/device_utils.dart';
import 'package:flutter_qcabtaxi/core/viewmodel/base_model.dart';
import 'package:flutter_qcabtaxi/core/viewmodel/map_model.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/views/home/state/onway.dart';
import 'package:flutter_qcabtaxi/ui/views/home/state/rating.dart';
import 'package:flutter_qcabtaxi/ui/views/home/state/waiting.dart';
import 'package:flutter_qcabtaxi/ui/widget/dymmy.dart';
import 'package:flutter_qcabtaxi/ui/widget/loading.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mydrawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mdi/mdi.dart';

import 'state/book.dart';
import 'state/none.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MapModel>(
        model: MapModel(),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => WillPopScope(
                //onWillPop: () => _onWillPop(model),
                child: Scaffold(
              key: _key,
              drawer: MyDrawer(),
              backgroundColor: SecondaryColor,
              body: Stack(
                children: <Widget>[
                  model.currentPosition == null
                      ? Loading()
                      : GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: model.currentPosition,
                              zoom: model.currentZoom),
                          onMapCreated: model.onMapCreated,
                          mapType: MapType.normal,
                          rotateGesturesEnabled: false,
                          tiltGesturesEnabled: false,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: false,
                          markers: model.markers,
                          onCameraMove: model.onCameraMove,
                          polylines: model.polyLines,
                        ),
                  model.customerstatus == CustomerStatus.none
                      ? None(
                          model: model,
                          globalKey: _key,
                        )
                      : Dummy(),
                  model.customerstatus == CustomerStatus.book
                      ? Book(
                          model: model,
                        )
                      : Dummy(),
                  model.customerstatus == CustomerStatus.onway
                      ? OnWay(
                          model: model,
                        )
                      : Dummy(),
                  model.customerstatus == CustomerStatus.rating
                      ? Rating(
                          model: model,
                        )
                      : Dummy(),
                  model.customerstatus == CustomerStatus.waiting
                      ? Waiting(
                    model: model,
                  )
                      : Dummy(),
                ],
              ),
            )));
  }
}
