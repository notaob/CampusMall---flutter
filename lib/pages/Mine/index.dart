import 'package:campusmall/stores/TokenManager.dart';
import 'package:campusmall/stores/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyView extends StatefulWidget {
  MyView({Key? key}) : super(key: key);

  @override
  _MyViewState createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  final UserController _userController = Get.find();
  var _userName = "";
  var _userPhone = "";
  bool isLoggedIn = false;

  // 订单状态
  final List<Map<String, dynamic>> _orderStatusList = [
    {'icon': Icons.payment, 'title': '待付款', 'count': 0},
    {'icon': Icons.local_shipping, 'title': '待发货', 'count': 0},
    {'icon': Icons.inventory_2, 'title': '待收货', 'count': 0},
    {'icon': Icons.rate_review, 'title': '待评价', 'count': 0},
    {'icon': Icons.repeat, 'title': '退款/售后', 'count': 0},
  ];

  // 功能列表
  final List<Map<String, dynamic>> _functionList = [
    {'icon': Icons.favorite_border, 'title': '我的收藏'},
    {'icon': Icons.location_on_outlined, 'title': '地址管理'},
    {'icon': Icons.card_giftcard, 'title': '优惠券'},
    {'icon': Icons.account_balance_wallet, 'title': '钱包'},
    {'icon': Icons.history, 'title': '浏览历史'},
    {'icon': Icons.feedback_outlined, 'title': '意见反馈'},
    {'icon': Icons.settings, 'title': '设置'},
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _userName = _userController.user.value.account;
      _userPhone = _userController.user.value.nickname;
      isLoggedIn = _userName.isNotEmpty;
      return CustomScrollView(
        slivers: [
          // 用户信息头部
          SliverToBoxAdapter(child: _buildHeader()),

          // 订单状态
          SliverToBoxAdapter(child: _buildOrderStatus()),

          // 功能列表
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return _buildFunctionItem(_functionList[index]);
            }, childCount: _functionList.length),
          ),

          if (isLoggedIn)
            // 退出登录按钮
            SliverToBoxAdapter(child: _buildLogoutButton()),

          // 底部间距
          SliverToBoxAdapter(child: SizedBox(height: 20)),

          //粘性吸顶
        ],
      );
    });
  }

  //退出登录按钮
  Widget _buildLogoutButton(){
    return Container(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            // 处理退出登录逻辑
            _showLogoutDialog();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: Colors.red, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            '退出登录',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  //退出登录弹窗
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('您确认退出登录吗？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 关闭弹窗
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () {
                // 处理退出登录逻辑
                setState(() {
                    _userController.logout();
                    tokenManager.removeToken();
                });
                Navigator.of(context).pop(); // 关闭弹窗
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('已退出登录')),
                );
              },
              child: Text('确认'),
            ),
          ],
        );
      },
    );
  }
  // 构建用户信息头部
  Widget _buildHeader() {
    return GestureDetector(
      onTap: () {
        if (!isLoggedIn) {
          // 跳转到登录页面
          Navigator.pushNamed(context, '/login');
        } else {
          // 已登录用户可以进入个人资料页面
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('进入个人资料页面')),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            // 用户头像
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Icon(
                isLoggedIn ? Icons.person : Icons.account_circle_outlined,
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 20),
            // 用户信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLoggedIn ? _userName : "立即登录",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    isLoggedIn ? _userPhone : "登录后查看更多信息",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // 右侧箭头
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // 构建订单状态
  Widget _buildOrderStatus() {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '我的订单',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    '全部订单',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          // 订单状态列表
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _orderStatusList.map((item) {
              return _buildOrderStatusItem(item);
            }).toList(),
          ),
        ],
      ),
    );
  }

  // 构建订单状态项
  Widget _buildOrderStatusItem(Map<String, dynamic> item) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              item['icon'],
              size: 30,
              color: Colors.blue,
            ),
            if (item['count'] > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    item['count'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          item['title'],
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // 构建功能项
  Widget _buildFunctionItem(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          item['icon'],
          color: Colors.blue,
          size: 24,
        ),
        title: Text(
          item['title'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: () {
          // 处理功能项点击事件
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('点击了${item['title']}')),
          );
        },
      ),
    );
  }
}