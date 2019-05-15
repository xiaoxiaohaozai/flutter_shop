import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/providers/current_index.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/providers/details_info.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  //跳出详情页
                  Navigator.pop(context);
                  //切换到购物车
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                },
                child: Container(
                  width: ScreenUtil().setWidth(100),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
              Provide<CartProvide>(
                builder: (context, child, cartProvider) {
                  int goodsCount =
                      Provide.value<CartProvide>(context).allGoodsCount;
                  return Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$goodsCount',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(22)),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context)
                  .save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              color: Colors.green,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(100),
              alignment: Alignment.center,
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                _showToast("点击了购买");
              },
              child: Container(
                color: Colors.red,
                height: ScreenUtil().setHeight(120),
                alignment: Alignment.center,
                child: Text(
                  '立即购买',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.pink,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
