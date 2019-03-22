import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_list_model.dart';

//分类列表通知
class CategoryGoodListProvide with ChangeNotifier {
  List<CategoryListData> goodsList;
 String mallCategoryId;
//更新分类列表
  updateGoodsList(String mallCategoryId,List<CategoryListData> goodsList) {
    this.mallCategoryId =mallCategoryId;
    this.goodsList = goodsList;
    notifyListeners();
  }

}
