import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/member_page.dart';
import 'package:flutter_shop/providers/current_index.dart';
import 'package:provide/provide.dart';

///// 页面容器
//class IndexPage extends StatefulWidget {
//  @override
//  _IndexState createState() => _IndexState();
//}
//
//class _IndexState extends State<IndexPage> {
//  int currentIndex = 0;
//  var currentPage;
//  final List<BottomNavigationBarItem> bottomTabs = [
//    BottomNavigationBarItem(
//      icon: Icon(CupertinoIcons.home),
//      title: Text('首页'),
//    ),
//    BottomNavigationBarItem(
//      icon: Icon(CupertinoIcons.search),
//      title: Text('分类'),
//    ),
//    BottomNavigationBarItem(
//      icon: Icon(CupertinoIcons.shopping_cart),
//      title: Text('购物车'),
//    ),
//    BottomNavigationBarItem(
//      icon: Icon(CupertinoIcons.profile_circled),
//      title: Text('会员中心'),
//    ),
//  ];
//
//  final List<Widget> tabBodies = [
//    HomePage(),
//    CategoryPage(),
//   // CartPage(),
//CartPage(),
//    MemberPage(),
//  ];
//
//  @override
//  void initState() {
//    super.initState();
//    //默认显示的界面
//    currentPage = tabBodies[currentIndex];
//  }
//
//  @override
//  Widget build(BuildContext context) {
//      ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
//      ..init(context); //不太理解ScreenUtil.instance没有声明类型
//    return Scaffold(
//      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//      bottomNavigationBar: BottomNavigationBar(
//        items: bottomTabs,
//        currentIndex: currentIndex,
//        type: BottomNavigationBarType.fixed,
//        onTap: (index) {
//          setState(() {
//            currentIndex = index;
//            currentPage = tabBodies[currentIndex];
//          });
//        },
//      ),
//      body: IndexedStack(
//        children: tabBodies,
//        index: currentIndex,
//      ),
//    );
//  }
//}

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心'),
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
      ..init(context); //不太理解ScreenUtil.instance没有声明类型
    return Provide<CurrentIndexProvide>(
      builder: (context, child, currentIndexProvide) {
        int currentIndex =
            Provide.value<CurrentIndexProvide>(context).currentIndex;

        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomTabs,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
            },
          ),
          body: IndexedStack(
            children: tabBodies,
            index: currentIndex,
          ),
        );
      },
    );
  }
}
