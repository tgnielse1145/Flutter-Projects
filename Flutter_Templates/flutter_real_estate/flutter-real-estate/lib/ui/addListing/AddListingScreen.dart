import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_listings/constants.dart';
import 'package:flutter_listings/main.dart';
import 'package:flutter_listings/model/CategoriesModel.dart';
import 'package:flutter_listings/model/ListingModel.dart';
import 'package:flutter_listings/services/FirebaseHelper.dart';
import 'package:flutter_listings/services/helper.dart';
import 'package:flutter_listings/ui/filtersScreen/FiltersScreen.dart';
import 'package:flutter_listings/ui/fullScreenImageViewer/FullScreenImageViewer.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: GOOGLE_API_KEY);

class AddListingScreen extends StatefulWidget {
  @override
  _AddListingScreenState createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  CategoriesModel? _categoryValue;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  FireStoreUtils _fireStoreUtils = FireStoreUtils();
  late Future<List<CategoriesModel>> _categoriesFuture;
  Map<String, String>? _filters = Map();
  PlacesDetailsResponse? _placeDetail;
  List<File?> _images = [null];
  List<CategoriesModel> _categories = [];

  @override
  void initState() {
    _categoriesFuture = _fireStoreUtils.getCategories();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Listing'.tr()),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: <Widget>[
                  Material(
                    color: isDarkMode(context) ? Colors.black12 : Colors.white,
                    type: MaterialType.canvas,
                    elevation: 2,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 16.0, right: 16.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Title'.tr(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _titleController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Start typing'.tr(),
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: isDarkMode(context) ? Colors.black12 : Colors.white,
                      elevation: 2,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, top: 16),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Description'.tr(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              controller: _descController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Start typing'.tr(),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    color: isDarkMode(context) ? Colors.black12 : Colors.white,
                    elevation: 2,
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        ListTile(
                          dense: true,
                          title: Text(
                            'Price'.tr(),
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: TextField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: '1000\$'.tr(),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                            dense: true,
                            title: Text(
                              'Category'.tr(),
                              style: TextStyle(fontSize: 20),
                            ),
                            trailing: FutureBuilder<List<CategoriesModel>>(
                                initialData: [],
                                future: _categoriesFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting)
                                    return CircularProgressIndicator.adaptive();
                                  if (!snapshot.hasData ||
                                      (snapshot.data?.isEmpty ?? true)) {
                                    return Text('No Categories Found'.tr());
                                  } else {
                                    _categories = snapshot.data!;
                                    return DropdownButton<CategoriesModel>(
                                        selectedItemBuilder: (BuildContext context) {
                                          return _categories
                                              .map<Widget>((CategoriesModel item) {
                                            return SizedBox(
                                              width:
                                                  MediaQuery.of(context).size.width /
                                                      2,
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  item.name,
                                                ),
                                              ),
                                            );
                                          }).toList();
                                        },
                                        hint: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width / 2,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'Choose Category'.tr(),
                                            ),
                                          ),
                                        ),
                                        value: _categoryValue,
                                        underline: Container(),
                                        items: _categories
                                            .map<DropdownMenuItem<CategoriesModel>>(
                                              (category) =>
                                                  DropdownMenuItem<CategoriesModel>(
                                                value: category,
                                                child: Text(
                                                  category.name,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        icon: Container(),
                                        onChanged: (CategoriesModel? model) {
                                          setState(() {
                                            _categoryValue = model;
                                          });
                                        });
                                  }
                                })),
                        ListTile(
                          dense: true,
                          title: Text(
                            'Filters'.tr(),
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: Text(_filters?.isEmpty ?? true
                              ? 'Set Filters'.tr()
                              : 'Edit Filters'.tr()),
                          onTap: () async {
                            _filters = await showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) {
                                return FiltersScreen(filtersValue: _filters ?? {});
                              },
                            );
                            if (_filters == null) _filters = Map();
                            setState(() {});
                            print('${_filters.toString()}'.tr());
                          },
                        ),
                        ListTile(
                          title: Text(
                            'Location'.tr(),
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              _placeDetail != null
                                  ? '${_placeDetail!.result.formattedAddress}'.tr()
                                  : 'Select Place'.tr(),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          onTap: () async {
                            Prediction? p = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: GOOGLE_API_KEY,
                              mode: Mode.fullscreen,
                              language: 'en',
                            );
                            if (p != null)
                              _placeDetail =
                                  await _places.getDetailsByPlaceId(p.placeId ?? '');
                            setState(() {});
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Add Photos'.tr(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SizedBox(
                            height: 100,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _images.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  File? image = _images[index];
                                  return _imageBuilder(image);
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        primary: Color(COLOR_PRIMARY),
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        'Post Listing'.tr(),
                        style: TextStyle(
                            color: isDarkMode(context) ? Colors.black : Colors.white,
                            fontSize: 20),
                      ),
                      onPressed: () => _postListing()),
                  constraints: BoxConstraints(minWidth: double.infinity)),
            ),
          )
        ],
      ),
    );
  }

  Widget _imageBuilder(File? imageFile) {
    bool isLastItem = imageFile == null;

    return GestureDetector(
      onTap: () {
        isLastItem ? _pickImage() : _viewOrDeleteImage(imageFile);
      },
      child: Container(
        width: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          color: Color(COLOR_PRIMARY),
          child: isLastItem
              ? Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: isDarkMode(context) ? Colors.black : Colors.white,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }

  _viewOrDeleteImage(File imageFile) {
    final action = CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.pop(context);
            _images.removeLast();
            _images.remove(imageFile);
            _images.add(null);
            setState(() {});
          },
          child: Text('Remove Picture'.tr()),
          isDestructiveAction: true,
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            push(context,
                FullScreenImageViewer(imageUrl: 'preview', imageFile: imageFile));
          },
          isDefaultAction: true,
          child: Text('View Picture'.tr()),
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

  _pickImage() {
    final action = CupertinoActionSheet(
      message: Text(
        'Add picture'.tr(),
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text('Choose from gallery'.tr()),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
            XFile? image =
                await _imagePicker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              _images.removeLast();
              _images.add(File(image.path));
              _images.add(null);
              setState(() {});
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Take a picture'.tr()),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            XFile? image =
                await _imagePicker.pickImage(source: ImageSource.camera);
            if (image != null) {
              _images.removeLast();
              _images.add(File(image.path));
              _images.add(null);
              setState(() {});
            }
          },
        )
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

  _postListing() async {
    if (_titleController.text.trim().isEmpty) {
      showAlertDialog(
          context, 'Missing Title'.tr(), 'You need a title for the listing.'.tr());
    } else if (_descController.text.trim().isEmpty) {
      showAlertDialog(context, 'Missing Description'.tr(),
          'You need a short description for the listing.'.tr());
    } else if (_priceController.text.trim().isEmpty) {
      showAlertDialog(context, 'Missing Price'.tr(),
          'You need to set a price for the listing.'.tr());
    } else if (_categoryValue == null) {
      showAlertDialog(context, 'Missing Category'.tr(),
          'You need to choose a category for the listing.'.tr());
    } else if (_filters?.isEmpty ?? true) {
      showAlertDialog(context, 'Missing Filters'.tr(),
          'You need to set filters for the listing.'.tr());
    } else if (_placeDetail == null) {
      showAlertDialog(context, 'Missing Location'.tr(),
          'You need a valid location for the listing.'.tr());
    } else if (_images.length == 1) {
      showAlertDialog(context, 'Missing Photos'.tr(),
          'You need at least one photo for the listing.'.tr());
    } else {
      showProgress(context, 'Uploading images...'.tr(), false);
      List<String> _imagesUrls = await _fireStoreUtils.uploadListingImages(_images);
      updateProgress('Posting listing, almost done'.tr());
      ListingModel newListing = ListingModel(
          title: _titleController.text.trim(),
          createdAt: Timestamp.now(),
          authorID: MyAppState.currentUser!.userID,
          authorName: MyAppState.currentUser!.fullName(),
          authorProfilePic: MyAppState.currentUser!.profilePictureURL,
          categoryID: _categoryValue!.id,
          categoryPhoto: _categoryValue!.photo,
          categoryTitle: _categoryValue!.title,
          description: _descController.text.trim(),
          price: _priceController.text.trim() + '\$',
          latitude: _placeDetail!.result.geometry!.location.lat,
          longitude: _placeDetail!.result.geometry!.location.lng,
          filters: _filters ?? {},
          photo: _imagesUrls.first,
          place: _placeDetail!.result.formattedAddress ?? '',
          reviewsCount: 0,
          reviewsSum: 0,
          isApproved: false,
          photos: _imagesUrls);
      await _fireStoreUtils.postListing(newListing);
      hideProgress();
      _titleController.clear();
      _descController.clear();
      _priceController.clear();
      _categoryValue = null;
      _filters?.clear();
      _placeDetail = null;
      _images.clear();
      _imagesUrls.clear();
      setState(() {});
      showAlertDialog(context, 'Listing Added'.tr(),
          'Your listing has been added successfully'.tr());
    }
  }
}
