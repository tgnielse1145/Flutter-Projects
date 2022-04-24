import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyAvatar2 extends StatelessWidget {
  final String imgurl;
  final double size=50;
  const MyAvatar2({Key key, this.imgurl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: SizedBox(
          height: size,
          width: size,
          child: CachedNetworkImage(
            imageUrl: imgurl,
            placeholder: (context, url) =>
            new CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
            new Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
