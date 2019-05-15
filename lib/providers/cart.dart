import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_shop/model/cart_info.dart';

// 购物车
class CartProvide with ChangeNotifier {
  String cartString = "[]";

  List<CartInfoMode> cartList = [];

  double allPrice = 0; //总价格

  int allGoodsCount = 0; //商品总数量

  bool isAllCheck = true; //是否全选

//保存购物车数据
  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.get('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
//声明变量.用于判断购物车中是否存在此商品
    var isHave = false;
    int ival = 0; //循环索引引用
    allPrice = 0;
    allGoodsCount = 0; //把商品总数量设置为0

    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }

      if (item['isCheck']) {
        allPrice += (cartList[ival].price * cartList[ival].count);
        allGoodsCount += cartList[ival].count;
      }
      ival++;
    });

//如果没有
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true //是否已经选择
      };
      tempList.add(newGoods);
      cartList.add(new CartInfoMode.fromJson(newGoods));
      allPrice += (count * price);
      allGoodsCount += count;
    }
    cartString = json.encode(tempList).toString();
    print(cartString);
    print(cartList.toString());
//持久化保存
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    print('清空完成');
    notifyListeners();
  }

//获取购物车数据
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.get('cartInfo');
//把cartList进行初始化，防止数据混乱
    cartList = [];
    if (cartString != null) {
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true; //是否全选

      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
//计算价格
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartList.add(new CartInfoMode.fromJson(item));
      });
    }
    notifyListeners();
  }

//删除单个商品
//dart语言不支持迭代时进行修改
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.get('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

//单选
  changeCheckState(CartInfoMode cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.get('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
//修改并保存
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

//全选
  changeAllCheckState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.get('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];

    for (var item in tempList) {
      var newItem = item; //复制新的变量，因为Dart不让循环时修改原值
      newItem['isCheck'] = isCheck; //改变选中状态
      newList.add(newItem);
    }
//修改并保存
    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  addOrReduceAction(CartInfoMode cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.get('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }
}
