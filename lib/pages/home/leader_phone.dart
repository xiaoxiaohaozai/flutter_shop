import 'package:flutter/material.dart';
import 'package:flutter_shop/model/home_model.dart' show ShopInfo;
import 'package:url_launcher/url_launcher.dart';

///电话组件
class LeaderPhone extends StatelessWidget {
  final ShopInfo shopInfo;

  const LeaderPhone({Key key,@required this.shopInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(shopInfo.leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:${shopInfo.leaderPhone}';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
