import 'package:flutter/material.dart';

//广告
class AdBanner extends StatelessWidget {
  final String advertesPicture;

  const AdBanner({Key key, this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(advertesPicture),
    );
  }
}
