import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/home_model.dart' show Floor;

/// 楼层商品组件
class FloorContent extends StatelessWidget {
  final List<Floor> floor;

  const FloorContent({Key key,@required this.floor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods(),
        ],
      ),
    );
  }

//中部
  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floor[0]),
        Column(
          children: <Widget>[
            _goodsItem(floor[1]),
            _goodsItem(floor[2]),
          ],
        ),
      ],
    );
  }

  //底部
  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floor[3]),
        _goodsItem(floor[4]),
      ],
    );
  }

//单个商品图片
  Widget _goodsItem(Floor goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {},
        child: Image.network(goods.image),
      ),
    );
  }
}
