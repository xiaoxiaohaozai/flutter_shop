import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart_info.dart';

import 'package:provide/provide.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/pages/cart/cart_bottom.dart';
import 'package:flutter_shop/pages/cart/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          List<CartInfoMode> cartList =
              Provide.value<CartProvide>(context).cartList;
          if (snapshot.hasData && cartList != null) {
            return Provide<CartProvide>(builder: (context, child, cartProvide) {
              cartList = Provide.value<CartProvide>(context).cartList;
              return Stack(
                children: <Widget>[
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return CartItem(cartList[index]);
                    },
                    itemCount: cartList.length,
                  ),
                  Positioned(
                    child: CardBottom(),
                    bottom: 0,
                    left: 0,
                  ),
                ],
              );
            });
          } else {
            return Text('正在加载');
          }
        },
        future: _getCartInfo(context),
      ),
    );
  }

  Future _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
