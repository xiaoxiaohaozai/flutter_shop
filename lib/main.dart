import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:provide/provide.dart';
import 'providers/test_counter.dart';
import 'providers/child_category.dart';


void main() {
  var testCounter = TestCounter();
  var childCategory = ChildCategory();
  var providers = Providers();
  //绑定provider
  providers
    ..provide(Provider<TestCounter>.value(testCounter))
    ..provide(Provider<ChildCategory>.value(childCategory));
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
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false, //隐藏右上角debug
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
