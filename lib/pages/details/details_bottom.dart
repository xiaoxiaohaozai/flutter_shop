import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
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
          InkWell(
            onTap: () {},
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
              onTap: () {},
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
}
