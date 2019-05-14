import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/pages/details/details_top_area.dart';
import 'package:flutter_shop/pages/details/details_explain.dart';
import 'package:flutter_shop/pages/details/details_tabbar.dart';
import 'package:flutter_shop/pages/details/details_web.dart';
import 'package:flutter_shop/pages/details/details_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  const DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        //获取数据
        future: _getBackInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabbar(),
                      DetailsWeb(),
                    ],
                  ),
                  Positioned(
                    child: DetailsBottom(),
                    bottom: 0,
                    left: 0,
                  ),
                ],
              ),
            );
          } else {
            return Text('加载中......');
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return "完成加载";
  }
}
