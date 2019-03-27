import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/category/left_category_nav.dart';
import 'package:flutter_shop/pages/category/right_category_nav.dart';
import 'package:flutter_shop/pages/category/right_goods_list.dart';


/// 分类页
class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("商品分类"),
      ),
      body: Row(
        children: <Widget>[
          LeftCategoryNav(),
          Expanded(
            child: Column(
              children: <Widget>[
                RightCategoryNav(),
                Expanded(
                  child: RightGoodsList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
