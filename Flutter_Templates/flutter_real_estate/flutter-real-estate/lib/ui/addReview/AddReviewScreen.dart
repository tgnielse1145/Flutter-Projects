import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listings/constants.dart';
import 'package:flutter_listings/main.dart';
import 'package:flutter_listings/model/ListingModel.dart';
import 'package:flutter_listings/model/ListingReviewModel.dart';
import 'package:flutter_listings/services/FirebaseHelper.dart';
import 'package:flutter_listings/services/helper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddReviewScreen extends StatefulWidget {
  final ListingModel listing;

  const AddReviewScreen({Key? key, required this.listing}) : super(key: key);

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  double _rating = 0.0;
  TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          MediaQuery.of(context).orientation == Orientation.landscape ? false : true,
      appBar: AppBar(
        title: Text(
          'Review ${widget.listing.title}'.tr(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RatingBar.builder(
                  itemCount: 5,
                  glow: false,
                  allowHalfRating: true,
                  initialRating: 4.5,
                  maxRating: 5,
                  itemSize: 30,
                  itemPadding: EdgeInsets.all(4),
                  itemBuilder: (context, index) =>
                      Icon(Icons.star, color: Color(COLOR_PRIMARY)),
                  unratedColor: Color(COLOR_PRIMARY).withOpacity(.5),
                  onRatingUpdate: (newValue) {
                    _rating = newValue;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                maxLines: 7,
                autofocus: true,
                keyboardType: TextInputType.multiline,
                controller: _reviewController,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: 'Write your review for ${widget.listing.title}'.tr(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Color(COLOR_PRIMARY),
                ),
                onPressed: () async {
                  showProgress(context, 'Posting review...'.tr(), false);
                  ListingReviewModel review = ListingReviewModel(
                      authorID: MyAppState.currentUser!.userID,
                      firstName: MyAppState.currentUser!.firstName,
                      lastName: MyAppState.currentUser!.lastName,
                      listingID: widget.listing.id,
                      profilePictureURL: MyAppState.currentUser!.profilePictureURL,
                      starCount: _rating,
                      createdAt: Timestamp.now(),
                      content: _reviewController.text.trim());
                  await FireStoreUtils().postReview(review);
                  hideProgress();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Add Review'.tr(),
                  style: TextStyle(
                    color: isDarkMode(context) ? Colors.black : Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
