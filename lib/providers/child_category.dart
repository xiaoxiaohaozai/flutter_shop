import 'package:flutter/material.dart';
import '../model/category_model.dart';

/// 分类菜单数据
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  //用于设置数据
  setChildCategoryList(List<BxMallSubDto> childCategoryList) {
    //在右侧分类前加上全部
    BxMallSubDto all = BxMallSubDto();
    all.mallSubName = '全部';
    this.childCategoryList = [all];
    this.childCategoryList.addAll(childCategoryList);
    notifyListeners();
  }
}
