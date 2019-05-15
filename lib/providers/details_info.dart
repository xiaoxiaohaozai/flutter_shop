import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'dart:convert';

//商品详情
class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  getGoodsInfo(String id) async {
    var formData = {'goodId': id};
    await request('getGoodDetailById', formData: formData).then((value) {
      var responseData = json.decode(value.toString());
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }

  bool isLeft = true;
  bool isRight = false;
//改变tabbar
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}
