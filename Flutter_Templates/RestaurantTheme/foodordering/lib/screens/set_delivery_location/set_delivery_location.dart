import 'package:flutter/material.dart';
import 'package:foodordering/screens/set_delivery_location/widgets/set_delivery_location_bottomsheet.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SetDeliveryLocation extends StatefulWidget {
  final bool button;
  const SetDeliveryLocation({Key key, this.button}) : super(key: key);
  @override
  _SetDeliveryLocationState createState() => _SetDeliveryLocationState();
}

class _SetDeliveryLocationState extends State<SetDeliveryLocation> {
  List<num> coordinates = [12.910991, 77.601836];
  Uri staticMapUri;
  GoogleMapController mapController;
  List<Marker> allmarkers = [];
  @override
  void initState() {
    super.initState();
    allmarkers.add(Marker(
        markerId: MarkerId("value"),
        draggable: true,
        onTap: () {
          print("marker tapped");
        },
        position: LatLng(coordinates[0], coordinates[1])));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: new Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                bearing: 0,
                tilt: 0,
                target: LatLng(coordinates[0], coordinates[1]),
                zoom: 11.0,
              ),
              markers: Set.from(allmarkers),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(
                    left: ScreenRatio.widthRatio * 12,
                    top: ScreenRatio.heightRatio * 12),
                child: GestureDetector(
                  child: Icon(Icons.arrow_back_ios,
                      color: Themes.blackColor, size: 24),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            // new Container(
            //   width: screenSize.width,
            //   height: screenSize.height,
            //   child: new Align(
            //     alignment: Alignment.bottomCenter,
            //     child: new GestureDetector(
            //       onTap: () {
            //         Navigator.of(context).pushNamed("/HomeWithTab");
            //       },
            //       child: new Container(
            //         margin: const EdgeInsets.only(bottom: 20.0),
            //         child: new Text(
            //           // defaultTargetPlatform == TargetPlatform.android
            //           // ? "PICK THIS LOCATION"
            //           // :
            //           "Pick This Location",
            //           style:
            //               const TextStyle(color: Colors.white, fontSize: 14.0),
            //         ),
            //         width: screenSize.width - 20,
            //         height: 45.0,
            //         alignment: FractionalOffset.center,
            //         decoration: new BoxDecoration(
            //           color: new Color.fromRGBO(33, 127, 255, 20.0),
            //           borderRadius:
            //               const BorderRadius.all(const Radius.circular(5.0)),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomSheet: AddressBottomSheet(
        button: widget.button,
      ),
    );
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    controller.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(coordinates[0], coordinates[1]),
        zoom: 16.0,
      ),
    ));
    setState(() {
      mapController = controller;
    });
  }
}
