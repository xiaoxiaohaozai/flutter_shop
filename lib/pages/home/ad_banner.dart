import 'package:flutter/material.dart';
import 'package:flutter_shop/model/home_model.dart' show AdvertesPicture;

/// 广告
class AdBanner extends StatelessWidget {
 final AdvertesPicture advertesPicture;

  const AdBanner({Key key, @required this.advertesPicture}) : super(key: key);//广告



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(advertesPicture.pICTUREADDRESS),
    );
  }
}
