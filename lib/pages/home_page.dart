import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎你来到美好人间';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('美好人间'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  labelText: '美女类型',
                  helperText: '请输入你喜欢的类型',
                ),
                autofocus: false, //静止聚焦
              ),
              RaisedButton(
                onPressed: _choiceAction,
                child: Text('选择完毕'),
              ),
              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _choiceAction() {
    print('开始选择你喜欢的类型......');
    if (typeController.text.toString().isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('输入内容为空'),
              ));
    } else {
      //从网络获取内容并展示
      getHttp(typeController.text.toString()).then((value) {
        setState(() {
          showText = value['data']['name'].toString();
        });
      });
    }
  }

//模拟网络请求
  Future getHttp(String typeText) async {
    try {
      Response response;
      //构建参数
      var data = {'name': typeText};

      response = await Dio().get(
          "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
          queryParameters: data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
