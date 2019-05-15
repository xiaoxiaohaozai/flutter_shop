import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:provide/provide.dart';

class CardBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: <Widget>[
          selectAllBtn(context),
          allPriceArea(context),
          goButton(context),
        ],
      ),
    );
  }

  //多选按钮
  Widget selectAllBtn(BuildContext context) {
    bool isAllCheck = Provide.value<CartProvide>(context).isAllCheck;
    print("全部选中" + isAllCheck.toString());
    return Container(
        child: Row(
      children: <Widget>[
        Checkbox(
          value: isAllCheck,
          onChanged: (value) {
            Provide.value<CartProvide>(context).changeAllCheckState(value);
          },
          activeColor: Colors.pink,
        ),
        Text('全选')
      ],
    ));
  }

  Widget allPriceArea(BuildContext context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;

    return Container(
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计:',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: Text('￥$allPrice',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(36),
                      color: Colors.red,
                    )),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                  color: Colors.black38, fontSize: ScreenUtil().setSp(22)),
            ),
          )
        ],
      ),
    );
  }

  //结算按钮
  Widget goButton(BuildContext context) {
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;

    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3)),
          child: Text(
            '结算($allGoodsCount)',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
