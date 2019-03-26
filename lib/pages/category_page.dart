import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_list_model.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/providers/child_category.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../providers/category_goods_list_provide.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("商品分类"),
      ),
      body: Row(
        children: <Widget>[
          new LeftCategoryNav(),
          new Expanded(
            child: Column(
              children: <Widget>[
                RightCategoryNav(),
                Expanded(
                  child: RightGoodsList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// 左侧导航菜单
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<Data> list = [];
  var listIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemExtent: ScreenUtil().setHeight(100),
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
        itemCount: list.length,
      ),
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

// 获取大分类
  void _getCategory() async {
    await request('getCategory').then((value) {
      var data = json.decode(value);
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      setState(() {
        list = categoryModel.data;
      });
      //右侧菜单第一次自动加载
      Provide.value<ChildCategory>(context)
          .setChildCategoryList(list[0].bxMallSubDto);
      //第一次加载列表
      getCategoryGoodsList(context, categoryId: list[0].mallCategoryId);
    });
  }

//每一个分类
  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        //通知更新
        var bxMallSubDto = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context)
            .setChildCategoryList(bxMallSubDto);
        getCategoryGoodsList(context, categoryId: list[index].mallCategoryId);
      },
      child: Container(
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isClick ? Colors.black12 : Colors.white, //点击背景颜色
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black12,
              ),
            )),
      ),
    );
  }
}

/// 右侧分类菜单
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(builder: (context, child, childCategory) {
      return Container(
        height: ScreenUtil().setHeight(80),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black12,
              ),
            )),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _rightInkWell(childCategory.childCategoryList[index]);
          },
          itemCount: childCategory.childCategoryList.length,
          scrollDirection: Axis.horizontal,
        ),
      );
    });
  }

  Widget _rightInkWell(BxMallSubDto item) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(80),
        padding: EdgeInsets.only(left: 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}

/// 右侧商品列表
class RightGoodsList extends StatefulWidget {
  @override
  _RightGoodsListState createState() => _RightGoodsListState();
}

class _RightGoodsListState extends State<RightGoodsList> {
  int page = 1;
  List<CategoryListData> goodsList = [];
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  String mallCategoryId;

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodListProvide>(
      builder: (context, child, data) {
        goodsList = data.goodsList;
        print("种类相同? ${mallCategoryId == data.mallCategoryId}");
        if (mallCategoryId != data.mallCategoryId) {
          page = 1;
        }
        this.mallCategoryId = data.mallCategoryId;
        return new EasyRefresh(
          key: _easyRefreshKey,
          loadMore: () async {
            //加载更多
            page++;
            var parameters = {
              'categoryId': mallCategoryId,
              'categorySubId': '',
              'page': page
            };
            request('getMallGoods', formData: parameters).then((value) {
              var categoryListModel =
                  CategoryListModel.fromJson(json.decode(value));

              if (categoryListModel.data != null &&
                  categoryListModel.data.length > 0) {
                setState(() {
                  goodsList.addAll(categoryListModel.data);
                });
              }
            });
          },
          child: GridView.count(
            childAspectRatio: 3 / 4, //GridView 需要指定宽高比,直接设置item 无效,避免角标越界
            crossAxisCount: 2,
            children: _wrapGoodsList(),
          ),
        );
      },
    );
  }

  List<Widget> _wrapGoodsList() {
    if (goodsList != null && goodsList.length != 0) {
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
    } else {
      return [Text("暂无数据")];
    }
  }
}

//获取分类商品列表并通知更新
getCategoryGoodsList(BuildContext context,
    {String categoryId, String categorySubId}) async {
  var parameters = {'categoryId': categoryId, 'categorySubId': '', 'page': 1};
  await request('getMallGoods', formData: parameters).then((value) {
    var categoryListModel = CategoryListModel.fromJson(json.decode(value));
    Provide.value<CategoryGoodListProvide>(context)
        .updateGoodsList(categoryId, categoryListModel.data);
  });
}
