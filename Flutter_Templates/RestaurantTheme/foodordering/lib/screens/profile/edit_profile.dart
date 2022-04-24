import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodordering/animations/bounce.dart';
import 'package:foodordering/common_widgets/circular_image_picker.dart';
import 'package:foodordering/common_widgets/text_input.dart';
import 'package:foodordering/utils/assets/images.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pPath;

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  void initState() {
    _image = null;
  }

  File _image;

  Future pickImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  // File _takenImage;
  // dynamic savedImagefile;
  // Future<void> _takePicture() async {
  //   final imageFile = await ImagePicker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (imageFile == null) {
  //     return;
  //   }
  //   setState(() {
  //     _takenImage = imageFile;
  //   });
  //   final appDir = await pPath.getApplicationDocumentsDirectory();
  //   final fileName = path.basename(imageFile.path);
  //   final savedImage = await imageFile.copy('${appDir.path}/$fileName');
  //   setState(() {
  //     savedImagefile = savedImage;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController firstName =
        TextEditingController(text: StringNames.FIRST_NAME);
    TextEditingController lastName =
        TextEditingController(text: StringNames.LAST_NAME);
    TextEditingController email =
        TextEditingController(text: StringNames.EMAIL_VALUE);
    TextEditingController phone =
        TextEditingController(text: StringNames.PHONE_NO);
    TextEditingController password =
        TextEditingController(text: StringNames.NAME);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: Duration(seconds: 10),
          child: Container(
            width: ScreenRatio.screenWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: StringNames.PROFILE_PIC,
                  child: Container(
                    height: 110,
                    width: 110,
                    margin: EdgeInsets.only(
                        top: ScreenRatio.heightRatio * 50,
                        bottom: ScreenRatio.heightRatio * 30,
                        left: ScreenRatio.heightRatio * 12,
                        right: ScreenRatio.heightRatio * 20),
                    child: Container(
                      child: Bounce(
                          CircularImagePicker(
                            assetImage: Images.PROFILE_PIC,
                            size: 120.0,
                            showIcon: true,
                            imagePy: 80.0,
                            file: _image,
                            onPressed: () {
                              pickImage();
                              // setState(() {
                              //   _image = null;
                              // });
                            },
                          ),
                          10.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InputField(
                        margin: true,
                        border: true,
                        // node: textThirdFocusNode,
                        // nextnode: textFourthFocusNode,
                        // hint: 'Permish',
                        protected: false,
                        type: TextInputType.emailAddress,
                        controller: firstName,
                        // validate: validations.validateMobile
                      ),
                      InputField(
                        margin: true,
                        border: true,
                        // node: textThirdFocusNode,
                        // nextnode: textFourthFocusNode,
                        // hint: 'Verma',
                        protected: false,
                        type: TextInputType.emailAddress,
                        controller: lastName,
                        // validate: validations.validateMobile
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Themes.greyColor,
          endIndent: 12,
          indent: 12,
        ),
        // Container(
        //   width: ScreenRatio.screenWidth,
        //   margin: EdgeInsets.only(
        //       left: ScreenRatio.screenWidth * 12,
        //       right: ScreenRatio.screenWidth * 12),
        //   child:
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: ScreenRatio.heightRatio * 15,
                ),
                Stack(
                  children: [
                    InputField(
                      margin: true,
                      border: true,
                      // node: textThirdFocusNode,
                      // nextnode: textFourthFocusNode,
                      hint: StringNames.EMAIL_VALUE,
                      protected: false,
                      type: TextInputType.emailAddress,
                      controller: email,
                      // validate: validations.validateMobile
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, right: 12),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          StringNames.CHANGE,
                          style:
                              TextStyle(color: Themes.greenColor, fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenRatio.heightRatio * 20,
                ),
                Stack(
                  children: [
                    InputField(
                      margin: true,
                      border: true,
                      // node: textThirdFocusNode,
                      // nextnode: textFourthFocusNode,
                      hint: StringNames.PHONE_NO,
                      protected: false,
                      type: TextInputType.emailAddress,
                      controller: phone,
                      // validate: validations.validateMobile
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, right: 12),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          StringNames.CHANGE,
                          style:
                              TextStyle(color: Themes.greenColor, fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenRatio.heightRatio * 20,
                ),
                Stack(
                  children: [
                    InputField(
                      margin: true,
                      border: true,
                      // node: textThirdFocusNode,
                      // nextnode: textFourthFocusNode,
                      hint: StringNames.PHONE_NO,
                      protected: true,
                      type: TextInputType.emailAddress,
                      controller: password,
                      // validate: validations.validateMobile
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, right: 12),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          StringNames.CHANGE,
                          style:
                              TextStyle(color: Themes.greenColor, fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        // )
      ],
    );
  }
}
