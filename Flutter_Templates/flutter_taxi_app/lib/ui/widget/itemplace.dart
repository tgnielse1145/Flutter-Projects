import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/models/place.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';
import 'package:mdi/mdi.dart';

class ItemPlace extends StatefulWidget {
  final Results placeItemRes;

  ItemPlace(this.placeItemRes);

  @override
  _RowItemBarcodeState createState() => _RowItemBarcodeState();
}

class _RowItemBarcodeState extends State<ItemPlace> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: SecondaryColor,
      child: ListTile(
        // leading: Icon(Mdi.mapMarkerOutline,color: UIData.PrimaryColor),
        title: Text(
          widget.placeItemRes.name,
          style: normalStyle,
        ),
        subtitle: Text(widget.placeItemRes.formattedAddress, style: H3style),
        trailing: Icon(Mdi.bookmarkOutline, color: Colors.grey),
      ),
    );
  }

  gobooking() {}
}
