import 'package:flutter/material.dart';
import 'package:foodordering/scoped_model/payment_scopedmodal.dart';
import 'package:foodordering/screens/make_payment/widgets/banking_popup.dart';
import 'package:foodordering/screens/set_delivery_location/set_delivery_location.dart';
import 'package:foodordering/utils/assets/images.dart';
import 'package:foodordering/utils/constants/route_names.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/themes/theme.dart';
import 'package:scoped_model/scoped_model.dart';

class MakePayment extends StatefulWidget {
  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  int selectedRadioTile;
  int selectedRadio;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PaymentScopedModel>(
        model: paymentScopedModel,
        child: ScopedModelDescendant<PaymentScopedModel>(
            builder: (context, child, disheScopedModel) {
          return Stack(
            children: [
              Opacity(
                opacity: paymentScopedModel.opacity,
                child: Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                    elevation: 0,
                    automaticallyImplyLeading: true,
                    backgroundColor: Themes.canvasColor,
                    title: Text(
                      StringNames.PAYMENT_OPTIONS,
                      style: TextStyle(color: Themes.blackColor),
                    ),
                  ),
                  body: Column(
                    children: [
                      RadioListTile(
                          value: 1,
                          groupValue: selectedRadioTile,
                          title: Text(StringNames.BANKING),
                          subtitle: Text(StringNames.TRANSACTION_FREE),
                          onChanged: (val) {
                            print("Radio Tile pressed $val");
                            setSelectedRadioTile(val);
                            paymentScopedModel.changedValue();
                            paymentScopedModel.changeOpacity();
                            // paymentScopedModel.value = false;
                            // paymentScopedModel.opacity = 0.3;
                            // setState(() {});
                          },
                          activeColor: Themes.greenColor,
                          secondary: SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 20.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(Images.VISA),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                                Container(
                                  height: 20.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(Images.MASTERO),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                                Container(
                                  height: 20.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(Images.MASTERODARK),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.rectangle,
                                  ),
                                )
                              ],
                            ),
                          )
                          // selected: true,
                          ),
                      RadioListTile(
                        value: 2,
                        groupValue: selectedRadioTile,
                        title: Text(StringNames.CASH_ON_DELIVERY),
                        onChanged: (val) {
                          print("Radio Tile pressed $val");
                          setSelectedRadioTile(val);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetDeliveryLocation(
                                      button: true,
                                    )),
                          );
                          // Navigator.pushNamed(
                          //     context, Routes.SETDELIVERYLOCATION);
                        },
                        activeColor: Themes.greenColor,
                        selected: false,
                      )
                    ],
                  ),
                ),
              ),
              PaymentPopUp()
            ],
          );
        }));
  }
}
