import 'package:flutter/material.dart';
import 'package:foodordering/common_widgets/primary_button.dart';
import 'package:foodordering/common_widgets/text_input.dart';
import 'package:foodordering/services/validation.dart';
import 'package:foodordering/utils/constants/route_names.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';

class AddressBottomSheet extends StatefulWidget {
  final bool button;

  const AddressBottomSheet({Key key, this.button}) : super(key: key);
  @override
  _AddressBottomSheetState createState() => _AddressBottomSheetState();
}

enum SingingCharacter { lafayette, jefferson, renon }

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  SingingCharacter _character = SingingCharacter.lafayette;
  Validations validations = new Validations();

  TextEditingController _email;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(100.0),
              topLeft: Radius.circular(100.0)),
          color: Colors.white,
        ),
        height: ScreenRatio.heightRatio * 480,
        child: new Wrap(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              height: ScreenRatio.heightRatio * 60,
              padding: EdgeInsets.only(left: ScreenRatio.widthRatio * 12),
              color: Colors.blue[50],
              child: Text(
                StringNames.SET_DELIVERY_LOCATION,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 10, bottom: 10, right: 10),
              child: InputField(
                  margin: true,
                  border: true,
                  hint: StringNames.LOCATION,
                  protected: false,
                  type: TextInputType.emailAddress,
                  controller: _email,
                  validate: validations.validateEmail),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 10, bottom: 10, right: 10),
              child: InputField(
                  margin: true,
                  border: true,
                  hint: StringNames.HOUSE_NO,
                  protected: false,
                  type: TextInputType.emailAddress,
                  controller: _email,
                  validate: validations.validateEmail),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 10, bottom: 10, right: 10),
              child: InputField(
                  margin: true,
                  border: true,
                  hint: StringNames.LANDMARK,
                  protected: false,
                  type: TextInputType.emailAddress,
                  controller: _email,
                  validate: validations.validateEmail),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 10.0, top: 10, bottom: 10, right: 10),
              child: Text(StringNames.TAG_AS),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 10.0, top: 10, bottom: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Radio(
                      value: SingingCharacter.lafayette,
                      groupValue: _character,
                      onChanged: (value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  Text(
                    StringNames.HOME,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Themes.greyColor),
                  ),
                  Radio(
                    value: SingingCharacter.jefferson,
                    groupValue: _character,
                    onChanged: (value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      StringNames.WORK,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Themes.greyColor),
                    ),
                  ),
                  Radio(
                    value: SingingCharacter.renon,
                    groupValue: _character,
                    onChanged: (value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      StringNames.OTHER,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Themes.greyColor),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Themes.greyColor,
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 10, bottom: 10, right: 10),
                child: PrimaryButton(
                    () => {
                          widget.button
                              ? Navigator.pushNamed(context, Routes.BOTTOMTAB)
                              : Navigator.pop(context)
                        },
                    StringNames.SAVE_PROCEED,
                    Themes.greenColor,
                    ScreenRatio.screenWidth)),
            Divider(
              color: Themes.greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
