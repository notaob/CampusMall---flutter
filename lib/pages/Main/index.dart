import 'package:campusmall/pages/Cart/index.dart';
import 'package:campusmall/pages/Category/index.dart';
import 'package:campusmall/pages/Home/index.dart';
import 'package:campusmall/pages/Mine/index.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  //渲染四个导航
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset("lib/assets/ic_public_home_normal.png", width: 30, height: 30),
          activeIcon: Image.asset("lib/assets/ic_public_home_active.png", width: 30, height: 30),
          label: "首页",
        ),
        BottomNavigationBarItem(
          icon: Image.asset("lib/assets/ic_public_pro_normal.png", width: 30, height: 30),
          activeIcon: Image.asset("lib/assets/ic_public_pro_active.png", width: 30, height: 30),
          label: "分类",
        ),
        BottomNavigationBarItem(
          icon: Image.asset("lib/assets/ic_public_cart_normal.png", width: 30, height: 30),
          activeIcon: Image.asset("lib/assets/ic_public_cart_active.png", width: 30, height: 30),
          label: "购物车",
        ),
        BottomNavigationBarItem(
          icon: Image.asset("lib/assets/ic_public_my_normal.png", width: 30, height: 30),
          activeIcon: Image.asset("lib/assets/ic_public_my_active.png", width: 30, height: 30),
          label: "我的",
        ),
      ],
    );
  }

  List<Widget> _pages() {
    return [
      HomeView(),
      CategoryView(),
      CartView(),
      MyView(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages(),
        )
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}