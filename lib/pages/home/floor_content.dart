import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/home_model.dart' show Floor;
import 'package:flutter_shop/routers/application.dart';

/// 楼层商品组件
class FloorContent extends StatelessWidget {
  final List<Floor> floor;

  const FloorContent({Key key, @required this.floor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context),
        ],
      ),
    );
  }

//中部
  Widget _firstRow(BuildContext context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floor[0]),
        Column(
          children: <Widget>[
            _goodsItem(context, floor[1]),
            _goodsItem(context, floor[2]),
          ],
        ),
      ],
    );
  }

  //底部
  Widget _otherGoods(BuildContext context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floor[3]),
        _goodsItem(context, floor[4]),
      ],
    );
  }

//单个商品图片
  Widget _goodsItem(BuildContext context, Floor goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          Application.router.navigateTo(context, "/detail?id=${goods.goodsId}");
        },
        child: Image.network(goods.image),
      ),
    );
  }
}
