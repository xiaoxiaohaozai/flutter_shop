import 'package:flutter/material.dart';
import '../model/category_model.dart';

/// 二级分类菜单数据
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //二级分类默认角标

//用于设置数据
  setChildCategoryList(List<BxMallSubDto> childCategoryList) {
    childIndex = 0;
//在右侧分类前加上全部
    BxMallSubDto all = BxMallSubDto();
    all.mallSubName = '全部';
    this.childCategoryList = [all];
    this.childCategoryList.addAll(childCategoryList);
    notifyListeners();
  }

// 更新角标
  changeChildIndex(int index) {
    childIndex = index;
    notifyListeners();
  }
}
