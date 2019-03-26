import 'package:flutter/material.dart';
import 'package:flutter_shop/model/home_model.dart' show FloorPic;

/// 楼层标题组件
class FloorTitle extends StatelessWidget {
  final FloorPic floorPic;

  const FloorTitle({Key key,@required this.floorPic}) : super(key: key); //楼层

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(floorPic.pICTUREADDRESS),
      padding: EdgeInsets.all(8.0),
    );
  }
}
