import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qcabtaxi/core/models/place.dart';
import 'package:flutter_qcabtaxi/core/models/placeobj.dart';
import 'package:flutter_qcabtaxi/core/services/api.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/itemplace.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybutton.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybutton4.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybuttonfull.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mdi/mdi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickAdressView extends StatefulWidget {
  @override
  _PickAdressViewState createState() {
    return _PickAdressViewState();
  }
}

class _PickAdressViewState extends State<PickAdressView> {
  Api _api = Api();
  FarPlaceObj _farPlaceObj = FarPlaceObj();
  List<Results> places = [];
  List<FarPlaceObj> _listplaces = [];
  final _controller_address = TextEditingController();
  bool loading = false;
  bool show = false;

  GoogleMapController mapController;
  LatLng _center = const LatLng(10.020909, 105.786489);
  Position _position;
  final Set<Marker> _markers = {};
  String _addressname = "";
  String _mapStyle = "";

  Future<void> _onMapCreated(GoogleMapController controller) async {
    await rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
    updateLocation();
  }

  void initState() {
    super.initState();
  }

  void updateLocation() async {
    try {
      Position newPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .timeout(new Duration(seconds: 20));
      _center = LatLng(newPosition.latitude, newPosition.longitude);
      //click_onmap(_center);
      String place = await _api.gg_find_nameplace(_center);
      setState(() {
        _position = newPosition;
        _addressname = place;
        _farPlaceObj.address = place;
        _farPlaceObj.lat = newPosition.latitude;
        _farPlaceObj.lng = newPosition.longitude;
      });
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _center, zoom: 18.0),
        ),
      );
      _markers.add(Marker(
        markerId: MarkerId("1"),
        position: _center,
        icon: BitmapDescriptor.defaultMarker,
        /*icon: BitmapDescriptor.fromBytes(
          await Utils.getBytesFromAsset("assets/icons/location.png", 280),
        ),*/
      ));
    } catch (e) {
      print('Error here ....: ${e.toString()}');
    }
  }

  Future<void> click_onmap(LatLng latLng) async {
    print('click' + latLng.longitude.toString());
    _center = LatLng(latLng.latitude, latLng.longitude);
    String address = await _api.gg_find_nameplace(_center);
    print('next');
    setState(() {
      _addressname = address;
      _markers.clear();

      _farPlaceObj.address = address;
      _farPlaceObj.lat = latLng.latitude;
      _farPlaceObj.lng = latLng.longitude;
    });
    _markers.add(Marker(
      markerId: MarkerId("1"),
      position: _center,
      icon: BitmapDescriptor.defaultMarker,
      /* icon: BitmapDescriptor.fromBytes(
        await Utils.getBytesFromAsset("assets/icons/location.png", 280),
      ),*/
      infoWindow: InfoWindow(
        title: "$address",
      ),
    ));
    //mapController.showMarkerInfoWindow(MarkerId("1"));
  }

  Future<void> finish(FarPlaceObj obj) {
    setState(() {
      _farPlaceObj = obj;
      _controller_address.text = _farPlaceObj.address;
    });
    Navigator.pop(context, _farPlaceObj);
  }

  Future searchPlace() async {
    print("searchPlace....");
    List<Results> list = await _api.gg_search_place(_controller_address.text);
    setState(() {
      places = list;
      loading = false;
    });
    print("size:" + places.length.toString());
  }

  Widget _buildListSearch(context) {
    return Container(
      color: SecondaryColor,
      child: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () => {doselect_search(places[index])},
              child: ItemPlace(places[index]));
        },
      ),
    );
  }

  ListView _buildListFarplace(context) {
    return ListView.builder(
      itemCount: _listplaces.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () => {doselect_farplace(_listplaces[index])},
            child: _buildItem(_listplaces[index]));
      },
    );
  }

  Widget _buildItem(FarPlaceObj obj) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          padding: EdgeInsets.all(8),
          color: LightGrey,
          child: obj.type == 3
              ? Icon(
                  Mdi.history,
                  color: Colors.white,
                )
              : Icon(
                  Mdi.mapMarker,
                  color: Colors.white,
                ),
        ),
      ),
      title: Text(obj.name),
      subtitle: Text(obj.address),
    );
  }

  doselect_search(Results place) async {
    setState(() {
      places = [];
    });
    FarPlaceObj obj = FarPlaceObj(
        address: place.formattedAddress.toString(),
        lat: place.geometry.location.lat,
        lng: place.geometry.location.lng,
        name: place.name,
        type: 3,
        customerid: 0);
    finish(obj);
  }

  doselect_farplace(FarPlaceObj obj) {
    finish(obj);
  }

  goAddplacemapView(BuildContext context) async {
    /* var result = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new AddPlacemapView(),
        )) as FarPlaceObj;*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: show
            ? Stack(
                children: <Widget>[
                  GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 18.0,
                    ),
                    onTap: (LatLng latLng) {
                      click_onmap(latLng);
                    },
                    markers: _markers,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: SecondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: PrimaryColor,
                                ),
                              ),
                              title: Text(
                                "$_addressname",
                                style: normalStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                              child: Container(
                                color: Colors.white10,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.near_me,
                                      color: PrimaryColor,
                                    ),
                                    onPressed: () => {updateLocation()}),
                              ),
                            ),
                          ),
                        ],
                      ),
                      MyButton4(
                        caption: 'Set location',
                        onPressed: () => {Navigator.pop(context, _farPlaceObj)},
                      )
                    ],
                  )
                ],
              )
            : Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              padding: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Icon(
                                Icons.clear,
                                size: 40,
                              ),
                              //color: Colors.white,
                              textColor: PrimaryColor,
                              minWidth: 0,
                              height: 40,
                              onPressed: () => Navigator.pop(context),
                            ),
                          ]),
                      TextField(
                        controller: _controller_address,
                        onChanged: (str) {
                          searchPlace();
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: PrimaryColor,
                            ),
                            border: InputBorder.none,
                            hintText: "Enter place name",
                            hintStyle: TextStyle(color: Dark),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  print("clear");
                                  _controller_address.clear();
                                  setState(() {
                                    places.clear();
                                  });
                                },
                                child: Icon(Icons.clear, color: Colors.white)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      UIHelper.verticalSpaceSmall,
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            show = true;
                          })
                        },
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: SecondaryColor,
                              child: Icon(
                                Mdi.mapMarker,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            "Set location on map",
                            style: normalStyle,
                          ),
                        ),
                      ),
                      loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(child: _buildListFarplace(context)),
                    ],
                  ),
                  places.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : Column(
                          children: <Widget>[
                            SizedBox(
                              height: 100,
                            ),
                            Expanded(child: _buildListSearch(context))
                          ],
                        )
                ],
              ),
      ),
    );
  }
}
