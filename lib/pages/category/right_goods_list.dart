import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_list_model.dart'
    show CategoryListData;
import 'package:flutter_shop/providers/category_goods_list_provide.dart';
import 'package:provide/provide.dart';

/// 右侧商品列表
class RightGoodsList extends StatefulWidget {
  @override
  _RightGoodsListState createState() => _RightGoodsListState();
}

class _RightGoodsListState extends State<RightGoodsList> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        if (data.goodsList.length > 0) {
          return EasyRefresh(
            key: _easyRefreshKey,
            loadMore: () async {
//            //加载更多
//            page++;
//            var parameters = {
//              'categoryId': mallCategoryId,
//              'categorySubId': '',
//              'page': page
//            };
//            request('getMallGoods', formData: parameters).then((value) {
//              var categoryListModel =
//              CategoryListModel.fromJson(json.decode(value));
//
//              if (categoryListModel.data != null &&
//                  categoryListModel.data.length > 0) {
//                setState(() {
//                  goodsList.addAll(categoryListModel.data);
//                });
//              }
//            });
            },
            child: GridView.count(
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
}
