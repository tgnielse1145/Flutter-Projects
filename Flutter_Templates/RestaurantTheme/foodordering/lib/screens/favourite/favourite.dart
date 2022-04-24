import 'package:flutter/material.dart';
import 'package:foodordering/common_widgets/primary_button.dart';
import 'package:foodordering/scoped_model/delivery_location_scopedmodel.dart';
import 'package:foodordering/screens/coupons_offers/coupons_offers.dart';
import 'package:foodordering/screens/favourite/widgets/address_bottomsheet.dart';
import 'package:foodordering/screens/favourite/widgets/confirmation_popup.dart';
import 'package:foodordering/screens/favourite/widgets/data.dart';
import 'package:foodordering/screens/favourite/widgets/order_menu.dart';
import 'package:foodordering/screens/favourite/widgets/restaurant_bill.dart';
import 'package:foodordering/utils/constants/route_names.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';
import 'package:scoped_model/scoped_model.dart';

class Favourite extends StatefulWidget {
  Favourite({Key key}) : super(key: key);
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  TextEditingController searchText;
  final DataListBuilder orderList = DataListBuilder();
  bool coupon = true;
  void _showPop() {
    showDialog<Null>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return ItemAvaibilityPopUp();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScopedModel<DeliveryLocation>(
            model: deliveryLocation,
            child: ScopedModelDescendant<DeliveryLocation>(
              builder: (context, child, model) {
                return SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      OrderMenu(),
                      deliveryLocation.coupon
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: ScreenRatio.heightRatio * 12,
                                  bottom: ScreenRatio.heightRatio * 12),
                              child: Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: Icon(Icons.card_giftcard_outlined),
                                  title: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CouponsOffers()),
                                        );
                                      },
                                      child: Text(StringNames.APPLY_CUPPON)),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        _showPop();
                                      },
                                      child: Icon(Icons.cancel_rounded)),
                                ),
                              ),
                            )
                          : SizedBox(),
                      RestaurantBill(),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenRatio.heightRatio * 12,
                            bottom: ScreenRatio.heightRatio * 12),
                        child: Card(
                          elevation: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              deliveryLocation.address
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0,
                                          top: 10,
                                          bottom: 10,
                                          right: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.home_work_outlined,
                                              color: Themes.greenColor,
                                              size: 50,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0,
                                                                top: 10),
                                                        child: Text(
                                                          StringNames
                                                              .DELIVERY_HOME,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Themes
                                                                  .blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          _settingModalBottomSheet(
                                                              context);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  top: 10,
                                                                  bottom: 10),
                                                          child: Text(
                                                            StringNames.CHANGE,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Themes
                                                                    .blueColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            top: 10,
                                                            bottom: 10),
                                                    child: Text(
                                                      StringNames.HOME_ADDRESS,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Themes.greyColor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 10),
                                          child: Text(
                                            StringNames.ALMOST_THERE,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Themes.blackColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 10, bottom: 10),
                                          child: Text(
                                            StringNames.LOGIN_CREATE_ACCOUNT,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Themes.greyColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 20),
                                child: PrimaryButton(
                                    () => {
                                          deliveryLocation.confirmAddress(),
                                          if (deliveryLocation.clicks > 2)
                                            {
                                              Navigator.pushNamed(
                                                  context, Routes.MAKEPAYMENT)
                                            }
                                        },
                                    deliveryLocation.address
                                        ? StringNames.MAKE_PAYMENT
                                        : StringNames.PROCEED_WITH_NUMBER,
                                    Themes.greenColor,
                                    ScreenRatio.screenWidth),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ));
              },
            )));
  }
}

void _settingModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddressBottomSheet();
      });
}
