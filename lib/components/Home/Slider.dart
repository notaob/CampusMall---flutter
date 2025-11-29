import 'package:campusmall/viewmodels/BannerItem.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Sliders extends StatefulWidget {
  final List<BannerItem> bannerList;
  Sliders({Key? key,required this.bannerList}) : super(key: key);

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Sliders> {
  int _currentIndex = 0;
  CarouselSliderController _pageController = CarouselSliderController();
  //获取搜索框
  Widget _getSearch(){
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4), // 深色半透明背景
          borderRadius: BorderRadius.circular(30), // 圆形边角
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // 更明显的阴影
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 20),
            Icon(Icons.search, color: Colors.white70, size: 20), // 稍大一点的搜索图标
            SizedBox(width: 15),
            Expanded(
              child: Text(
                "搜索商品", 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
  //获取轮播图
  Widget _getSlider() {
    //获取屏幕宽度
    double screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      carouselController: _pageController, // 使用CarouselController控制轮播图
      items: List.generate(
        widget.bannerList.length,
        (index) => Image.network(widget.bannerList[index].imgUrl,
        fit: BoxFit.cover,
        width: screenWidth,
        ),
      ),
      options: CarouselOptions(
        height: 300,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5), // 自动播放间隔
        autoPlayAnimationDuration: Duration(milliseconds: 800), // 缩短动画时间使切换更流畅
        viewportFraction: 1, // 稍微缩小视口，显示前后图片的一小部分
        scrollDirection: Axis.horizontal, // 水平滚动
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
        pauseAutoPlayOnTouch: true, // 触摸时暂停自动播放
        pauseAutoPlayOnManualNavigate: true, // 手动导航时暂停自动播放
        pauseAutoPlayInFiniteScroll: false, // 无限滚动时不暂停
      ),
    );
  }

  //获取导航栏
  Widget _getNav() {
    return Positioned(
      bottom: 20, // 稍微上调位置，增加底部空间
      right: 0,
      left: 0,
      child: Container(
        padding: EdgeInsets.all(4), // 添加外边距
        child: SizedBox(
          height: 16, // 增加高度以容纳更大的指示器
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.bannerList.length,
              (index) => GestureDetector(
                onTap: () {
                  _pageController.animateToPage(index);
                  setState(() {
                    _currentIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300), // 添加动画效果
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 16,
                  width: _currentIndex == index ? 30 : 16, // 调整大小比例
                  decoration: BoxDecoration(
                    color: _currentIndex == index 
                      ? Colors.white // 选中时为纯白色
                      : Colors.white.withOpacity(0.7), // 未选中时为较高透明度的白色
                    borderRadius: BorderRadius.circular(8), // 更圆润的设计
                    boxShadow: [ // 始终添加阴影以增强可见性
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _getSlider(),
      _getSearch(),
      _getNav(),
    ],);
  }
}
