import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listings/constants.dart';
import 'package:flutter_listings/main.dart';
import 'package:flutter_listings/model/CategoriesModel.dart';
import 'package:flutter_listings/model/ListingModel.dart';
import 'package:flutter_listings/services/AdsUtils.dart';
import 'package:flutter_listings/services/FirebaseHelper.dart';
import 'package:flutter_listings/services/helper.dart';
import 'package:flutter_listings/ui/addListing/AddListingScreen.dart';
import 'package:flutter_listings/ui/categoryListings/CategoryListingsScreen.dart';
import 'package:flutter_listings/ui/listingDetails/ListingDetailsScreen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  FireStoreUtils _fireStoreUtils = FireStoreUtils();
  late Future<List<CategoriesModel>> _categoriesFuture;
  late Future<List<ListingModel>> _listingsFuture;
  static List<ListingModel> listings = [];
  List<CategoriesModel> _categories = [];
  bool _showAll = false;
  List<ListingModel?> solution = [];
  bool refresh = true;

  @override
  void initState() {
    _categoriesFuture = _fireStoreUtils.getCategories();
    _listingsFuture = _fireStoreUtils.getListings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              FutureBuilder<List<CategoriesModel>>(
                  future: _categoriesFuture,
                  initialData: [],
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator.adaptive());
                    if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
                      return Center(child: _emptyStateCategories());
                    } else {
                      _categories = snapshot.data!;
                      return Container(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _categories.length,
                            itemBuilder: (context, index) {
                              return _buildCategoryCard(_categories[index]);
                            }),
                      );
                    }
                  }),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Houses',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              FutureBuilder<List<ListingModel>>(
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
                      listings = snapshot.data!;
                      calculateAdLocation();
                      if (refresh) {
                        Future.delayed(
                            Duration(seconds: 2),
                            () => mounted
                                ? setState(() {
                                    refresh = false;
                                  })
                                : null);
                      }
                      return StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          mainAxisSpacing: 24,
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          staggeredTileBuilder: (int index) => StaggeredTile.count(
                                (solution[index] == null) ? 2 : 1,
                                1,
                              ),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listings.length > 4
                              ? _showAll
                                  ? solution.length
                                  : 4
                              : solution.length,
                          itemBuilder: (context, index) {
                            if (solution[index] == null) {
                              return AdsUtils.adsContainer();
                            } else {
                              return _buildListingCard(solution[index]!);
                            }
                          });
                    }
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32),
                child: Visibility(
                  visible: !_showAll && listings.length > 4,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: double.infinity),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: BorderSide(
                            color: Color(COLOR_PRIMARY),
                          ),
                        ),
                      ),
                      child: Text(
                        'Show All (${listings.length - 4})',
                        style: TextStyle(color: Color(COLOR_PRIMARY)),
                      ),
                      onPressed: () {
                        setState(() {
                          _showAll = true;
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(CategoriesModel category) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2),
      child: GestureDetector(
        onTap: () {
          push(
              context,
              CategoryListingsScreen(
                categoryID: category.id,
                categoryName: category.title,
              ));
        },
        child: Container(
          width: 120,
          height: 120,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), side: BorderSide.none),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 120),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: displayImage(category.photo, 120),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: Center(
                    child: Text(
                      category.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListingCard(ListingModel listing) {
    return GestureDetector(
      onLongPress: MyAppState.currentUser!.isAdmin
          ? () => _showAdminOptions(listing)
          : () => null,
      onTap: () async {
        bool? isListingDeleted = await Navigator.of(context).push(
            new MaterialPageRoute(
                builder: (context) => ListingDetailsScreen(listing: listing)));
        if (isListingDeleted != null && isListingDeleted) {
          listings.remove(listing);
        }
        setState(() {});
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
                      icon: Icon(
                        Icons.favorite,
                        color: listing.isFav ? Color(COLOR_PRIMARY) : Colors.white,
                      ),
                      tooltip: listing.isFav
                          ? 'Remove From Favorites'
                          : 'Add To Favorites',
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
                color: isDarkMode(context) ? Colors.grey[400] : Colors.grey[800],
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(listing.place, maxLines: 1),
          ),
          RatingBar.builder(
            ignoreGestures: true,
            minRating: .5,
            initialRating: listing.reviewsSum != 0
                ? listing.reviewsSum / listing.reviewsCount
                : 0,
            allowHalfRating: true,
            itemSize: 22,
            glow: false,
            unratedColor: Color(COLOR_PRIMARY).withOpacity(0.5),
            itemBuilder: (context, index) =>
                Icon(Icons.star, color: Color(COLOR_PRIMARY)),
            itemCount: 5,
            onRatingUpdate: (newValue) {},
          )
        ],
      ),
    );
  }

  _showAdminOptions(ListingModel listing) {
    final action = CupertinoActionSheet(
      message: Text(
        "${listing.title}",
        style: TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Edit Listing"),
          isDestructiveAction: false,
          isDefaultAction: true,
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Delete Listing"),
          isDestructiveAction: true,
          onPressed: () async {
            showProgress(context, 'Deleting...', false);
            await _fireStoreUtils.deleteListing(listing);
            listings.remove(listing);
            hideProgress();
            Navigator.pop(context);
            setState(() {});
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  Widget _emptyStateCategories() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 15),
        Text('No Categories',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        Text(
          'All Categories will be shown here once added by the admin.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(height: 15)
      ],
    );
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 30),
        Text('No Listings',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        Text(
          'Add a new listing to show up here once the admin approves it.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 12),
                primary: Color(COLOR_PRIMARY),
              ),
              child: Text(
                'Add Listing',
                style: TextStyle(
                    color: isDarkMode(context) ? Colors.black : Colors.white,
                    fontSize: 18),
              ),
              onPressed: () => push(
                context,
                AddListingScreen(),
              ),
            ),
          ),
        )
      ],
    );
  }

  calculateAdLocation() {
    solution = [];
    for (int i = 0; i < listings.length; i++) {
      if ((solution.length + 1) % 5 == 0) {
        solution.add(null);
        solution.add(listings[i]);
      } else {
        solution.add(listings[i]);
      }
    }
  }
}
