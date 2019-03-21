import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../providers/test_counter.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Number(),
          MyButton(),
        ],
      ),
    ));
  }
}

//测试文本,用于监听数据变化
class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<TestCounter>(
        builder: (context, child, counter) {
          return Text(
            '${counter.value}',
            style: Theme.of(context).textTheme.display1, //系统大字体
          );
        },
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Provide.value<TestCounter>(context).increment();
        },
        child: Text("递增"),
      ),
    );
  }
}
