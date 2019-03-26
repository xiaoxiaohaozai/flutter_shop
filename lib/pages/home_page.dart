import 'package:flutter/material.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/model/hot_goods_model.dart';
import 'package:flutter_shop/pages/home/ad_banner.dart';
import 'package:flutter_shop/pages/home/floor_content.dart';
import 'package:flutter_shop/pages/home/floor_title.dart';
import 'package:flutter_shop/pages/home/leader_phone.dart';
import 'package:flutter_shop/pages/home/swiper_banner.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop/pages/home/top_navigator.dart';
import 'package:flutter_shop/pages/home/recommend.dart' as HomeRecommend;
import 'package:flutter_shop/pages/home/hot_goods.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<HotGoodsModelData> hotGoodsList = [];

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  //保持状态
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('百姓生活+'),
      ),
      body: new FutureBuilder(
        //异步渲染
        future: request(
          'homePageContent',
          formData: {'lon': '115.02932', 'lat': '35.76189'},
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            HomeModel homeModel = HomeModel.fromJson(
              json.decode(snapshot.data),
            );
            HomeModelData homeModelData = homeModel.data;
            return new EasyRefresh(
              refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: '',
                  moreInfo: '加载中',
                  loadReadyText: '上拉加载....'),
              child: ListView(
                children: <Widget>[
                  SwiperBanner(slides: homeModelData.slides),
                  TopNavigator(category: homeModelData.category),
                  AdBanner(advertesPicture: homeModelData.advertesPicture),
                  LeaderPhone(shopInfo: homeModelData.shopInfo),
                  HomeRecommend.Recommend(recommend: homeModelData.recommend),
                  FloorTitle(floorPic: homeModelData.floor1Pic),
                  FloorContent(floor: homeModelData.floor1),
                  FloorTitle(floorPic: homeModelData.floor2Pic),
                  FloorContent(floor: homeModelData.floor2),
                  FloorTitle(floorPic: homeModelData.floor3Pic),
                  FloorContent(floor: homeModelData.floor3),
                  HotGoods(data: hotGoodsList),
                ],
              ),
              loadMore: () async {
                _getHotGoods();
              },
            );
          } else {
            return Center(
              child: Text("首页数据加载中..."),
            );
          }
        },
      ),
    );
  }

  //获得火爆专区数据
  void _getHotGoods() async {
    var formPage = {'page': page};
    request('homePageBelowConten', formData: formPage).then((value) {
      var hotGoodsModel = HotGoodsModel.fromJson(json.decode(value));
      if (hotGoodsModel != null &&
          hotGoodsModel.data != null &&
          hotGoodsModel.data.length > 0) {
        setState(() {
          hotGoodsList.addAll(hotGoodsModel.data);
        });
      }
    }).catchError((e) {
      print(e);
    });
  }
}
