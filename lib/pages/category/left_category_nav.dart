import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_list_model.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:flutter_shop/providers/category_goods_list_provide.dart';
import 'package:flutter_shop/providers/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

/// 左侧导航菜单
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<Data> list = [];
  var listIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemExtent: ScreenUtil().setHeight(100),
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
        itemCount: list.length,
      ),
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

//每一个分类
  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        //刷新二级菜单和商品列表
        Provide.value<ChildCategory>(context).setChildCategoryList(list[index].bxMallSubDto);
        _getCategoryGoodsList(list[index].mallCategoryId);
      },
      child: Container(
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isClick ? Colors.black12 : Colors.white, //点击背景颜色
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black12,
              ),
            )),
      ),
    );
  }

  // 获取一级分类
  void _getCategory() {
    request('getCategory').then((value) {
      var data = json.decode(value);
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      setState(() {
        list = categoryModel.data;
      });
      //右侧默认加载菜单和商品列表
      Provide.value<ChildCategory>(context).setChildCategoryList(list[listIndex].bxMallSubDto);
      _getCategoryGoodsList(list[listIndex].mallCategoryId);
    });
  }

// 获得商品列表
  void _getCategoryGoodsList(String categoryId) {
    var parameters = {'categoryId': categoryId, 'categorySubId': '', 'page': 1};
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
