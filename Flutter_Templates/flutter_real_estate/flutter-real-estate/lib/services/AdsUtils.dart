import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:uuid/uuid.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AdsUtils {
  static Widget adsContainer() {
    return Container(
      //You Can Set Container Height
      width: double.infinity,
      height: 200,
      child: NativeAdWidget(),
    );
  }
}

class NativeAdWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NativeAdState();
}

class NativeAdState extends State<NativeAdWidget> {
  late NativeAd _nativeAd;
  final Completer<NativeAd> nativeAdCompleter = Completer<NativeAd>();

  late final Key key;
  bool visible = false;

  @override
  void initState() {
    super.initState();
    key = Key(Uuid().v4());
    _nativeAd = NativeAd(
      adUnitId: NativeAd.testAdUnitId,
      request: AdRequest(),
      factoryId: 'adFactoryExample',
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          nativeAdCompleter.complete(ad as NativeAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('$NativeAd failedToLoad: $error');
          nativeAdCompleter.completeError(error);
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
    );
    Future<void>.delayed(Duration(seconds: 1), () => _nativeAd.load());
  }

  @override
  void dispose() {
    super.dispose();
    _nativeAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: key,
      onVisibilityChanged: (info) {
        if (info.visibleFraction >= 1.0) {
          if (!visible) {
            setState(() {
              visible = true;
            });
          }
        }
      },
      child: Visibility(
        visible: visible,
        child: FutureBuilder<NativeAd>(
          future: nativeAdCompleter.future,
          builder: (BuildContext context, AsyncSnapshot<NativeAd> snapshot) {
            Widget child;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                child = Container();
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  child = AdWidget(ad: _nativeAd);
                } else {
                  child = Center(child: Text('Error loading $NativeAd'.tr()));
                }
            }
            return Container(
              width: double.infinity,
              height: 200,
              color: Colors.transparent,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
