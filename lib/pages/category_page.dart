import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Row(
        children: <Widget>[
          LeftCategoryNav(),
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
    // TODO: implement initState
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
    });
  }

//每一个分类
  Widget _leftInkWell(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
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
