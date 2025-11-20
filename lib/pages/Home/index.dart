import 'package:campusmall/components/Home/Category.dart';
import 'package:campusmall/components/Home/Hot.dart';
import 'package:campusmall/components/Home/MoreList.dart';
import 'package:campusmall/components/Home/Slider.dart';
import 'package:campusmall/components/Home/Suggestion.dart';
import 'package:campusmall/viewmodels/BannerItem.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<BannerItem> _bannerList = [
    BannerItem(
      id: "1",
      imageUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/banner/nuandong_sj.png",
    ),
    BannerItem(
      id: "2",
      imageUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/banner/nvshen_sj.png",
    ),
    BannerItem(
      id: "3",
      imageUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/banner/xinnian_sj.png",
    ),
  ];
  List<Widget> _getSlivers() {
    return [

      SliverToBoxAdapter(child: Sliders(bannerList: _bannerList)),

      SliverToBoxAdapter(child: SizedBox(height: 20)),

      SliverToBoxAdapter(child: Category()),

      SliverToBoxAdapter(child: SizedBox(height: 20)),

      SliverToBoxAdapter(child: Suggestion()),

      SliverToBoxAdapter(child: SizedBox(height: 20)),

      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: Hot()),
              SizedBox(width: 20),
              Expanded(child: Hot()),
            ],
          ),
        ),
      ),

      SliverToBoxAdapter(child: SizedBox(height: 20)),

      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        sliver: Morelist(),
      ),


    ];
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _getSlivers(),
    );
  }
}