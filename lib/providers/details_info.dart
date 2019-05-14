import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'dart:convert';

//商品
class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  getGoodsInfo(String id) {
    var formData = {'goodId': id};
    request('getGoodDetailById', formData: formData).then((value) {
      var responseData = json.decode(value.toString());
      print(responseData);
      notifyListeners();
    });
  }
}
