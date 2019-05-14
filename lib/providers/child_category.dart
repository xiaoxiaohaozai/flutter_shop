import 'package:flutter/material.dart';
import '../model/category_model.dart';

/// 二级分类菜单数据
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //二级分类默认角标
  String categoryId = '4'; //大类id
  String subId = ''; //小类ID
  int page = 1; //列表页数，当改变大类或者小类时进行改变
  String noMoreText = ''; //显示更多的标识

//用于设置数据
  setChildCategoryList(List<BxMallSubDto> childCategoryList, String id) {
    categoryId = id;
    subId = ''; //点击大类时，把子类ID清空
    childIndex = 0;

//改变大类时,重置
    page = 1;
    noMoreText = '';

//在右侧分类前加上全部
    BxMallSubDto all = BxMallSubDto();
    all.mallSubName = '全部';
    all.mallSubId = '';
    this.childCategoryList = [all];
    this.childCategoryList.addAll(childCategoryList);
    notifyListeners();
  }

// 更新角标
  changeChildIndex(int index, String id) {
    childIndex = index;
    subId = id;

//改变小类时,重置
    page = 1;
    noMoreText = '';

    notifyListeners();
  }

//更新页数
  addPage() {
    page++;
  }

//更新提示文本
  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
