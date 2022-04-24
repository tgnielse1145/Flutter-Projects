import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listings/constants.dart';
import 'package:flutter_listings/main.dart';
import 'package:flutter_listings/model/ListingModel.dart';
import 'package:flutter_listings/services/FirebaseHelper.dart';
import 'package:flutter_listings/services/helper.dart';
import 'package:flutter_listings/ui/listingDetails/ListingDetailsScreen.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  FireStoreUtils _fireStoreUtils = FireStoreUtils();
  late Future<List<ListingModel>> _listingsFuture;
  List<ListingModel> _listings = [];

  @override
  void initState() {
    _listingsFuture = _fireStoreUtils.getPendingListings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'.tr()),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Awaiting Approval'.tr(),
              style: TextStyle(
                fontSize: 25,
                color: isDarkMode(context) ? Colors.grey[400] : Colors.grey[900],
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child: FutureBuilder<List<ListingModel>>(
                future: _listingsFuture,
                initialData: [],
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator.adaptive());
                  if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: _emptyState(),
                    ));
                  } else {
                    _listings = snapshot.data!;

                    return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 16),
                        itemCount: _listings.length,
                        itemBuilder: (context, index) {
                          return _buildListingCard(_listings[index]);
                        });
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget _buildListingCard(ListingModel listing) {
    return GestureDetector(
      onTap: () async {
        bool? isListingDeleted = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ListingDetailsScreen(listing: listing)));
        if (isListingDeleted != null && isListingDeleted) {
          _listings.remove(listing);
        }
        setState(() {});
      },
      onLongPress: () {
        _showAdminOptions(listing);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                displayImage(listing.photo, 150),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                      tooltip: listing.isFav
                          ? 'Remove From Favorites'.tr()
                          : 'Add To Favorites'.tr(),
                      icon: Icon(
                        Icons.favorite,
                        color: listing.isFav ? Color(COLOR_PRIMARY) : Colors.white,
                      ),
                      onPressed: () {
                        listing.isFav = !listing.isFav;
                        setState(() {});
                        if (listing.isFav) {
                          MyAppState.currentUser!.likedListingsIDs.add(listing.id);
                        } else {
                          MyAppState.currentUser!.likedListingsIDs
                              .remove(listing.id);
                        }
                        FireStoreUtils.updateCurrentUser(MyAppState.currentUser!);
                      }),
                )
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(
            listing.title,
            maxLines: 1,
            style: TextStyle(
                fontSize: 16,
                color: isDarkMode(context)
                    ? Colors.grey.shade400
                    : Colors.grey.shade800,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(listing.place, maxLines: 1),
          ),
        ],
      ),
    );
  }

  _showAdminOptions(ListingModel listing) {
    final action = CupertinoActionSheet(
      message: Text(
        listing.title,
        style: TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text('Approve'.tr()),
          isDestructiveAction: false,
          isDefaultAction: true,
          onPressed: () async {
            showProgress(context, 'Approving...'.tr(), false);
            await _fireStoreUtils.approveListing(listing);
            _listings.remove(listing);
            hideProgress();
            Navigator.pop(context);
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Delete'.tr()),
          isDestructiveAction: true,
          onPressed: () async {
            showProgress(context, 'Deleting...'.tr(), false);
            await _fireStoreUtils.deleteListing(listing);
            _listings.remove(listing);
            hideProgress();
            Navigator.pop(context);
            setState(() {});
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'.tr()),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 15),
        Text('No Pending Listings'.tr(),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        Text(
          'New listings will show up before being published.'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(height: 15)
      ],
    );
  }
}
