import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/hot_goods_model.dart' show HotGoodsModelData;
import 'package:flutter_shop/routers/application.dart';


/// 热门商品
class HotGoods extends StatelessWidget {
  final List<HotGoodsModelData> data;

  const HotGoods({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle(),
          _wrapList(context),
        ],
      ),
    );
  }

  //火爆专区标题
  Widget _hotTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.black12,
            ),
          )),
      child: Text('火爆专区'),
    );
  }

  //火爆专区子项
  Widget _wrapList(context) {
    if (data != null && data.length != 0) {
      List<Widget> listWidget = data.map((value) {
        return InkWell(
          onTap: () {
            Application.router
                .navigateTo(context, "/detail?id=${value.goodsId}");
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(value.image),
                Text(
                  value.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: ScreenUtil().setSp(26),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${value.mallPrice}'),
                    Expanded(
                      child: Text(
                        '￥${value.price}',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          '上拉加载更多',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(26),
            color: Colors.pink,
          ),
        ),
      );
    }
  }
}
