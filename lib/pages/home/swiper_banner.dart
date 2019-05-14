import 'package:flutter/material.dart';
import 'package:flutter_shop/model/home_model.dart' show Slides;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routers/application.dart';

/// 首页轮播图
class SwiperBanner extends StatelessWidget {
  final List<Slides> slides;

  const SwiperBanner({Key key, @required this.slides}) : super(key: key); //轮播图;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      child: Swiper(
        pagination: SwiperPagination(),
        autoplay: true,
        itemCount: slides.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Image.network(
              slides[index].image,
              fit: BoxFit.fill,
            ),
            onTap: () {
              Application.router
                  .navigateTo(context, "/detail?id=${slides[index].goodsId}");
            },
          );
        },
      ),
    );
  }
}
