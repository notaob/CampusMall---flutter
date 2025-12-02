import 'package:campusmall/api/user.dart';
import 'package:campusmall/pages/Cart/index.dart';
import 'package:campusmall/pages/Category/index.dart';
import 'package:campusmall/pages/Home/index.dart';
import 'package:campusmall/pages/Mine/index.dart';
import 'package:campusmall/stores/TokenManager.dart';
import 'package:campusmall/stores/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
          icon: Image.asset(
            "lib/assets/ic_public_home_normal.png",
            width: 30,
            height: 30,
          ),
          activeIcon: Image.asset(
            "lib/assets/ic_public_home_active.png",
            width: 30,
            height: 30,
          ),
          label: "首页",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "lib/assets/ic_public_pro_normal.png",
            width: 30,
            height: 30,
          ),
          activeIcon: Image.asset(
            "lib/assets/ic_public_pro_active.png",
            width: 30,
            height: 30,
          ),
          label: "分类",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "lib/assets/ic_public_cart_normal.png",
            width: 30,
            height: 30,
          ),
          activeIcon: Image.asset(
            "lib/assets/ic_public_cart_active.png",
            width: 30,
            height: 30,
          ),
          label: "购物车",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "lib/assets/ic_public_my_normal.png",
            width: 30,
            height: 30,
          ),
          activeIcon: Image.asset(
            "lib/assets/ic_public_my_active.png",
            width: 30,
            height: 30,
          ),
          label: "我的",
        ),
      ],
    );
  }

  List<Widget> _pages() {
    return [HomeView(), CategoryView(), CartView(), MyView()];
  }

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  final UserController _userController = Get.put(UserController());
  void _initUser() async {
    // 使用全局的 tokenManager 实例
    await tokenManager.init();
    // 等待异步操作完成并正确获取 token
    String token = tokenManager.getToken();
    print('Current token: $token');
    if (token.isNotEmpty) {
      try {
        _userController.updateUserInfo(await getUserProfileAPI());
      } catch (e) {
        print('获取用户信息失败: $e');
        // 如果获取用户信息失败，清除 token
        await tokenManager.removeToken();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _pages()),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
