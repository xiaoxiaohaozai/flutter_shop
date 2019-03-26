import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/home_model.dart' show Category;

/// 首页导航区域
class TopNavigator extends StatelessWidget {
  final List<Category> category;

  const TopNavigator({Key key,@required this.category}) : super(key: key); //分类

  Widget _gridViewItemUI(BuildContext context, Category item) {
    return InkWell(
      onTap: () {
        print("点击了导航");
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item.image,
            width: ScreenUtil().setWidth(95),
          ),
          Text(item.mallCategoryName),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.category.length > 10) {
      this.category.removeRange(10, this.category.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(), //解决GridView 和listview 冲突
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: category.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}
