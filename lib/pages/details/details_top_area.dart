import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/providers/details_info.dart';
import 'package:provide/provide.dart';

//商品详情顶部区域
class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, detailsInfoProvide) {
        DetailsModel goodsInfo =
            Provide.value<DetailsInfoProvide>(context).goodsInfo;
//
        if (goodsInfo != null && goodsInfo.data.goodInfo != null) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(2),
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.data.goodInfo.image1),
                _goodsName(goodsInfo.data.goodInfo.goodsName),
                _goodsNum(goodsInfo.data.goodInfo.goodsSerialNumber),
                _goodsPrice(
                  goodsInfo.data.goodInfo.presentPrice,
                  goodsInfo.data.goodInfo.oriPrice,
                )
              ],
            ),
          );
        } else {
          return Text('正在加载中...');
        }
      },
    );
  }

//商品图片
  Widget _goodsImage(url) {
    return Image.network(url, width: ScreenUtil().setWidth(740));
  }

  //商品名称
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(730),

      padding: EdgeInsets.only(left: 15),
      child: Text(
        name,
        maxLines: 1,
        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  //商品编号
  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号:$num',
        maxLines: 1,
        style: TextStyle(color: Colors.black26),
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(presentPrice, oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(730),
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 15),
      child: Row(
        children: <Widget>[
          Text(
            '￥$presentPrice',
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
          Text(
            '市场价:￥$oriPrice',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
