import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/home_model.dart' as HomeModel
    show Recommend; //as 用于解决包名冲突  show 用于只引入Recommend类
import 'package:flutter_shop/routers/application.dart';

/// 商品推荐
class Recommend extends StatelessWidget {
  final List<HomeModel.Recommend> recommend;

  const Recommend({Key key, @required this.recommend}) : super(key: key); //商品推荐

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommedList(context)],
      ),
    );
  }

  /// 推荐商品标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(8.0, 5, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: Text('商品推荐', style: TextStyle(color: Colors.pink)),
    );
  }

  Widget _recommedList(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommend.length,
        itemBuilder: (context, index) {
          return _item(context, index);
        },
      ),
    );
  }

  Widget _item(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Application.router
            .navigateTo(context, "/detail?id=${recommend[index].goodsId}");
      },
      child: Container(
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommend[index].image),
            Text('￥${recommend[index].mallPrice}'),
            Text(
              '￥${recommend[index].price}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
