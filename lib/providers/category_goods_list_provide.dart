import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_list_model.dart';

/// 商品列表页面
class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];

//更新分类列表
  updateGoodsList(List<CategoryListData> goodsList) {
    this.goodsList = goodsList;
    notifyListeners();
  }

  addGoodsList(List<CategoryListData> goodsList) {
    this.goodsList.addAll(goodsList);
    notifyListeners();
  }
}
