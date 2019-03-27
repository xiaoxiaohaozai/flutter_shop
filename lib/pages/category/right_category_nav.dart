import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_list_model.dart'
    show CategoryListModel;
import 'package:flutter_shop/model/category_model.dart';
import 'package:flutter_shop/providers/category_goods_list_provide.dart';
import 'package:flutter_shop/providers/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

/// 右侧分类菜单
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(builder: (context, child, childCategory) {
      return Container(
        height: ScreenUtil().setHeight(80),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black12,
              ),
            )),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _rightInkWell(index, childCategory.childCategoryList[index]);
          },
          itemCount: childCategory.childCategoryList.length,
          scrollDirection: Axis.horizontal,
        ),
      );
    });
  }

  Widget _rightInkWell(int index, BxMallSubDto item) {
    bool isChecked = false;
    isChecked = index == Provide.value<ChildCategory>(context).childIndex;
    return InkWell(
      onTap: () {
        _getCategoryGoodsList(item.mallCategoryId, item.mallSubId);
        Provide.value<ChildCategory>(context).changeChildIndex(index);
      },
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(80),
        padding: EdgeInsets.only(left: 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isChecked ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  // 获得商品列表
  void _getCategoryGoodsList(String categoryId, String categorySubId) {
    var parameters = {
      'categoryId': categoryId,
      'categorySubId': categorySubId,
      'page': 1
    };
    request('getMallGoods', formData: parameters).then((value) {
      var categoryListModel = CategoryListModel.fromJson(json.decode(value));
      if (categoryListModel.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).updateGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .updateGoodsList(categoryListModel.data);
      }
    });
  }
}
