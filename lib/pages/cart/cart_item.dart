import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/cart/cart_count.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/providers/cart.dart';

class CartItem extends StatelessWidget {
  CartInfoMode item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _cartCheckBt(context, item),
          _cartImage(item),
          _cartGoodsName(item),
          _cartPrice(context, item),
        ],
      ),
    );
  }

  //多选按钮
  Widget _cartCheckBt(context, CartInfoMode item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        onChanged: (value) {
          item.isCheck = value;
          Provide.value<CartProvide>(context).changeCheckState(item);
        },
        activeColor: Colors.pink,
      ),
    );
  }

//商品图片
  Widget _cartImage(CartInfoMode item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      child: Image.network(item.images),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
    );
  }

  //商品名称
  Widget _cartGoodsName(CartInfoMode item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item),
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(context, CartInfoMode item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<CartProvide>(context)
                    .deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
