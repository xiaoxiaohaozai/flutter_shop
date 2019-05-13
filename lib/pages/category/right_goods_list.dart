import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_list_model.dart';

import 'package:flutter_shop/providers/category_goods_list_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/providers/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'dart:convert';

/// 右侧商品列表
class RightGoodsList extends StatefulWidget {
  @override
  _RightGoodsListState createState() => _RightGoodsListState();
}

class _RightGoodsListState extends State<RightGoodsList> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if (Provide.value<ChildCategory>(context).page == 1) {
            scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化:+${e}');
        }
        if (data.goodsList.length > 0) {
          return EasyRefresh(
            key: _easyRefreshKey,
            loadMore: () async {
              _getMoreList();
            },
            child: GridView.count(
              controller: scrollController,
              childAspectRatio: 3 / 4, //GridView 需要指定宽高比,直接设置item 无效,避免角标越界
              crossAxisCount: 2,
              children: _wrapGoodsList(data.goodsList),
            ),
          );
        } else {
          return Text('暂无商品数据');
        }
      },
    );
  }

  List<Widget> _wrapGoodsList(List<CategoryListData> goodsList) {
    return goodsList.map((CategoryListData categoryListData) {
      return new InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: new Column(
            children: <Widget>[
              Image.network(categoryListData.image),
              Text(
                categoryListData.goodsName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: ScreenUtil().setSp(26),
                ),
              ),
              new Row(
                children: <Widget>[
                  Text('￥${categoryListData.presentPrice}'),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '￥${categoryListData.oriPrice}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black12,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  void _getMoreList() {
    Provide.value<ChildCategory>(context).addPage();
    //构建入参
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': Provide.value<ChildCategory>(context).page
    };
    request('getMallGoods', formData: data).then((value) {
      var categoryListModel = CategoryListModel.fromJson(json.decode(value));
      if (categoryListModel.data == null) {
        Provide.value<ChildCategory>(context).changeNoMore("没有更多了");
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .addGoodsList(categoryListModel.data);
      }
    });
  }
}
