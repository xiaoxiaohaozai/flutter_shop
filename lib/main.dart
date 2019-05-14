import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:provide/provide.dart';
import 'providers/test_counter.dart';
import 'providers/child_category.dart';
import 'providers/category_goods_list_provide.dart';
import 'package:fluro/fluro.dart';
import 'routers/routes.dart';
import 'routers/application.dart';
import 'providers/details_info.dart';

void main() {
  var testCounter = TestCounter();
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = new DetailsInfoProvide();
  var providers = Providers();

  //绑定provider
  providers
    ..provide(Provider<TestCounter>.value(testCounter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide));

  runApp(
    ProviderNode(
      child: MyApp(),
      providers: providers,
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //注册绑定router
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        // 生成路由的回调函数，当导航的命名路由的时候，会使用这个来生成界面
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        //隐藏右上角debug图标
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
