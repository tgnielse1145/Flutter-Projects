import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyAvatar extends StatelessWidget {
  final String imgurl;

  const MyAvatar({Key key, this.imgurl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: SizedBox(
          height: 80,
          width: 80,
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
