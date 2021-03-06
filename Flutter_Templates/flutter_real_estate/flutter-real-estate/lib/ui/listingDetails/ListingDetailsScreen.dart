import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_listings/constants.dart';
import 'package:flutter_listings/main.dart';
import 'package:flutter_listings/model/ConversationModel.dart';
import 'package:flutter_listings/model/HomeConversationModel.dart';
import 'package:flutter_listings/model/ListingModel.dart';
import 'package:flutter_listings/model/ListingReviewModel.dart';
import 'package:flutter_listings/model/User.dart';
import 'package:flutter_listings/services/FirebaseHelper.dart';
import 'package:flutter_listings/services/helper.dart';
import 'package:flutter_listings/ui/addReview/AddReviewScreen.dart';
import 'package:flutter_listings/ui/chat/ChatScreen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ListingDetailsScreen extends StatefulWidget {
  final ListingModel listing;

  const ListingDetailsScreen({Key? key, required this.listing}) : super(key: key);

  @override
  _ListingDetailsScreenState createState() => _ListingDetailsScreenState();
}

class _ListingDetailsScreenState extends State<ListingDetailsScreen> {
  int _pageIndex = 0;
  PageController _pagerController = PageController(initialPage: 0);
  late Timer _autoScroll;
  late GoogleMapController _mapController;
  late LatLng _placeLocation;
  late Future<List<ListingReviewModel>> _reviewsFuture;
  FireStoreUtils _fireStoreUtils = FireStoreUtils();
  Future _mapFuture = Future.delayed(Duration(milliseconds: 500), () => true);

  @override
  void initState() {
    _reviewsFuture = _fireStoreUtils.getReviews(widget.listing.id);
    if (!(widget.listing.photos.length < 2)) {
      _autoScroll = Timer.periodic(Duration(seconds: 5), (Timer timer) {
        if (_pageIndex < widget.listing.photos.length - 1) {
          _pageIndex++;
        } else {
          _pageIndex = 0;
        }
        _pagerController.animateToPage(
          _pageIndex,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (!(widget.listing.photos.length < 2)) _autoScroll.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _placeLocation = LatLng(widget.listing.latitude, widget.listing.longitude);
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    child: ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  leading: Icon(
                    Icons.favorite,
                    color: widget.listing.isFav
                        ? Color(COLOR_PRIMARY)
                        : isDarkMode(context)
                            ? Colors.white
                            : null,
                  ),
                  title: Text(
                    widget.listing.isFav
                        ? 'Remove From Favorites'.tr()
                        : 'Add To Favorites'.tr(),
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    widget.listing.isFav = !widget.listing.isFav;
                    if (widget.listing.isFav) {
                      MyAppState.currentUser!.likedListingsIDs
                          .add(widget.listing.id);
                    } else {
                      MyAppState.currentUser!.likedListingsIDs
                          .remove(widget.listing.id);
                    }
                    FireStoreUtils.updateCurrentUser(MyAppState.currentUser!);
                  },
                )),
                if (MyAppState.currentUser!.userID != widget.listing.authorID)
                  PopupMenuItem(
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.all(0),
                      leading: Icon(
                        Icons.stars,
                        color: isDarkMode(context) ? Colors.white : null,
                      ),
                      title: Text(
                        'Add Review'.tr(),
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AddReviewScreen(listing: widget.listing)));
                        print('_ListingDetailsScreenState.build');
                        _reviewsFuture =
                            _fireStoreUtils.getReviews(widget.listing.id);
                      },
                    ),
                  ),
                if (MyAppState.currentUser!.userID != widget.listing.authorID)
                  PopupMenuItem(
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.all(0),
                      leading: Icon(
                        Icons.chat,
                        color: isDarkMode(context) ? Colors.white : null,
                      ),
                      title: Text(
                        'Send Message'.tr(),
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        User? seller = await FireStoreUtils.getCurrentUser(
                            widget.listing.authorID);
                        String channelID;
                        if (seller != null) {
                          if (seller.userID
                                  .compareTo(MyAppState.currentUser!.userID) <
                              0) {
                            channelID =
                                seller.userID + MyAppState.currentUser!.userID;
                          } else {
                            channelID =
                                MyAppState.currentUser!.userID + seller.userID;
                          }

                          ConversationModel? conversationModel =
                              await _fireStoreUtils.getChannelByIdOrNull(channelID);
                          push(
                              context,
                              ChatScreen(
                                  homeConversationModel: HomeConversationModel(
                                      isGroupChat: false,
                                      members: [seller],
                                      conversationModel: conversationModel)));
                        }
                      },
                    ),
                  ),
                if (MyAppState.currentUser!.userID == widget.listing.authorID ||
                    MyAppState.currentUser!.isAdmin)
                  PopupMenuItem(
                    child: ListTile(
                      dense: true,
                      onTap: () async {
                        Navigator.pop(context);
                        Widget yesButton = TextButton(
                          child: Text(
                            'Yes'.tr(),
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                            showProgress(context, 'Deleting...'.tr(), false);
                            await _fireStoreUtils.deleteListing(widget.listing);
                            hideProgress();
                            Navigator.pop(context, true);
                          },
                        );
                        Widget okButton = TextButton(
                          child: Text('No'.tr()),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text('Delete Listing?'.tr()),
                          content: Text('Are you sure you want to remove this '
                                  'listing?'
                              .tr()),
                          actions: [okButton, yesButton],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                      contentPadding: const EdgeInsets.all(0),
                      leading: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      title: Text(
                        'Delete Listing'.tr(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
              ];
            },
          ),
        ],
        title: Text(
          widget.listing.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.listing.photos.isNotEmpty)
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Stack(
                  children: [
                    PageView.builder(
                        controller: _pagerController,
                        itemCount: widget.listing.photos.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return displayImage(widget.listing.photos[index], 400);
                        }),
                    if (widget.listing.photos.length > 2)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SmoothPageIndicator(
                                effect: ColorTransitionEffect(
                                    activeDotColor: Color(COLOR_PRIMARY),
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    dotColor: Colors.grey.shade300),
                                controller: _pagerController,
                                count: widget.listing.photos.length)),
                      )
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.listing.title,
                    style: TextStyle(
                        fontSize: 19,
                        color: isDarkMode(context)
                            ? Colors.grey[200]
                            : Colors.grey[900]),
                  ),
                  Text(
                    widget.listing.price,
                    style: TextStyle(
                        fontSize: 19,
                        color: isDarkMode(context)
                            ? Colors.grey[200]
                            : Colors.grey[900]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.listing.description,
                style: TextStyle(
                    fontSize: 15,
                    color:
                        isDarkMode(context) ? Colors.grey[400] : Colors.grey[500]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
              child: Text(
                'Location'.tr(),
                style: TextStyle(
                    fontSize: 19,
                    color:
                        isDarkMode(context) ? Colors.grey[200] : Colors.grey[900]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Text(
                widget.listing.place,
                style: TextStyle(
                    fontSize: 15,
                    color:
                        isDarkMode(context) ? Colors.grey[400] : Colors.grey[500]),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: FutureBuilder(
                  future: _mapFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator.adaptive());
                    }
                    return GoogleMap(
                      gestureRecognizers: Set()
                        ..add(Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer())),
                      markers: <Marker>[
                        Marker(
                            markerId: MarkerId('marker_1'),
                            position: _placeLocation,
                            infoWindow: InfoWindow(title: widget.listing.title)),
                      ].toSet(),
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: _placeLocation,
                        zoom: 14.4746,
                      ),
                      onMapCreated: _onMapCreated,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 16),
              child: Text(
                'Extra info'.tr(),
                style: TextStyle(
                    fontSize: 19,
                    color:
                        isDarkMode(context) ? Colors.grey[200] : Colors.grey[900]),
              ),
            ),
            ListView.builder(
                itemCount: widget.listing.filters.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8, left: 24, right: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.listing.filters.keys.elementAt(index),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(widget.listing.filters.values.elementAt(index),
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
              child: Text(
                'Reviews'.tr(),
                style: TextStyle(
                    fontSize: 19,
                    color:
                        isDarkMode(context) ? Colors.grey[200] : Colors.grey[900]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<List<ListingReviewModel>>(
                future: _reviewsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator.adaptive());
                  if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
                    return Center(child: Text('No Reviews found.'.tr()));
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _reviewWidget(snapshot.data![index]);
                        });
                  }
                },
                initialData: [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reviewWidget(ListingReviewModel review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          dense: true,
          leading: displayCircleImage(review.profilePictureURL, 40, false),
          title: Text(
            review.fullName(),
            style: TextStyle(
              fontSize: 17,
              color: isDarkMode(context) ? Colors.grey[200] : Colors.grey[900],
            ),
          ),
          subtitle: Text(
            formatReviewTimestamp(review.createdAt.seconds),
            style: TextStyle(
                fontSize: 13,
                color: isDarkMode(context) ? Colors.grey[400] : Colors.grey[500]),
          ),
          trailing: RatingBar.builder(
              onRatingUpdate: (double) => null,
              ignoreGestures: true,
              glow: false,
              itemCount: 5,
              allowHalfRating: true,
              itemSize: 20,
              unratedColor: Color(COLOR_PRIMARY).withOpacity(.5),
              initialRating: review.starCount,
              itemBuilder: (context, index) =>
                  Icon(Icons.star, color: Color(COLOR_PRIMARY))),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 8),
          child: Text(review.content),
        )
      ],
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (isDarkMode(context))
      _mapController.setMapStyle('[{"featureType": "all","'
          'elementType": "'
          'geo'
          'met'
          'ry","stylers": [{"color": "#242f3e"}]},{"featureType": "all","elementType": "labels.text.stroke","stylers": [{"lightness": -80}]},{"featureType": "administrative","elementType": "labels.text.fill","stylers": [{"color": "#746855"}]},{"featureType": "administrative.locality","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "poi","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "poi.park","elementType": "geometry","stylers": [{"color": "#263c3f"}]},{"featureType": "poi.park","elementType": "labels.text.fill","stylers": [{"color": "#6b9a76"}]},{"featureType": "road","elementType": "geometry.fill","stylers": [{"color": "#2b3544"}]},{"featureType": "road","elementType": "labels.text.fill","stylers": [{"color": "#9ca5b3"}]},{"featureType": "road.arterial","elementType": "geometry.fill","stylers": [{"color": "#38414e"}]},{"featureType": "road.arterial","elementType": "geometry.stroke","stylers": [{"color": "#212a37"}]},{"featureType": "road.highway","elementType": "geometry.fill","stylers": [{"color": "#746855"}]},{"featureType": "road.highway","elementType": "geometry.stroke","stylers": [{"color": "#1f2835"}]},{"featureType": "road.highway","elementType": "labels.text.fill","stylers": [{"color": "#f3d19c"}]},{"featureType": "road.local","elementType": "geometry.fill","stylers": [{"color": "#38414e"}]},{"featureType": "road.local","elementType": "geometry.stroke","stylers": [{"color": "#212a37"}]},{"featureType": "transit","elementType": "geometry","stylers": [{"color": "#2f3948"}]},{"featureType": "transit.station","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "water","elementType": "geometry","stylers": [{"color": "#17263c"}]},{"featureType": "water","elementType": "labels.text.fill","stylers": [{"color": "#515c6d"}]},{"featureType": "water","elementType": "labels.text.stroke","stylers": [{"lightness": -20}]}]');
  }
}
