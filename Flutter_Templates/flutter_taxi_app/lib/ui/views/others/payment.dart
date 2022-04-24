import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/constants/mockdata.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybutton4.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';

class PaymentView extends KFDrawerContent {
  @override
  _SelectDesPageState createState() {
    return _SelectDesPageState();
  }
}

class _SelectDesPageState extends State<PaymentView> {
  int _select = 0;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: PrimaryColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
            //onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.add,
              color: PrimaryColor,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: H1(
              text: "My Payment",
            ),
          ),
          UIHelper.verticalSpaceMedium,
          Expanded(
            child: ListView.builder(
              itemCount: payments.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    select(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Container(
                      color: SecondaryColor,
                      child: ListTile(
                          leading: Image.asset(payments[index]['icon']),
                          title: Text(
                            payments[index]['title'],
                            style: normalStyle,
                          ),
                          subtitle: Text(
                            payments[index]['subtitle'],
                            style: H3style,
                          ),
                          trailing: Icon(
                            index == _select
                                ? Mdi.checkboxMarkedCircle
                                : Mdi.checkboxBlankCircleOutline,
                            color: PrimaryColor,
                          )),
                    ),
                  ),
                );
              },
            ),
          ),
          MyButton4(
            caption: "Done",
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  select(int n) {
    setState(() {
      _select = n;
    });
  }
}
