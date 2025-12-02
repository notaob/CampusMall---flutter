import 'package:campusmall/api/user.dart';
import 'package:campusmall/stores/TokenManager.dart';
import 'package:campusmall/stores/UserController.dart';
import 'package:campusmall/utils/ToastUtils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 控制器用于获取输入框的值
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserController _userController = Get.find();
  // 表单状态键
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // 是否显示密码
  bool _obscureText = true;
  
  // 记住密码
  bool _rememberPassword = false;
  
  // 是否正在登录
  bool _isLoggingIn = false;

  // 登录按钮点击事件
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // 这里应该调用实际的登录API
      _login();
    }
  }

  _login () async{
    if (_isLoggingIn) return;
    
    setState(() {
      _isLoggingIn = true;
    });
    
    try{
      final res = await loginAPI({
        "account": _phoneController.text.trim(),
        "password": _passwordController.text.trim(),
      });
      _userController.updateUserInfo(res);
      TokenManager().setToken(res.token);
      ToastUtils.showToast(context, "登录成功");
      // 登录成功后跳转到主页面
      Navigator.pop(context);
    }catch(e){
      ToastUtils.showToast(context, (e as DioException).message);
    }
  }

  @override
  void initState() {
    super.initState();
    // 初始化时可以加载保存的账号信息（如果有的话）
    // 这里可以根据需要实现记住密码功能
  }

  @override
  void dispose() {
    // 释放控制器资源
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo 或标题
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 30),
                child: Column(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "欢迎回来",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "登录您的账户",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              
              // 手机号输入框
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "手机号",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "请输入手机号";
                  }
                  // 简单的手机号验证
                  if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
                    return "请输入正确的手机号";
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 15),
              
              // 密码输入框
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "密码",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "请输入密码";
                  }
                  if(!RegExp(r"^[a-zA-Z0-9_]{6,16}$").hasMatch(value)){
                    return "密码必须为6-16位字母、数字或下划线";
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 10),
              
              // 记住密码和忘记密码
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberPassword,
                        onChanged: (value) {
                          setState(() {
                            _rememberPassword = value ?? false;
                          });
                        },
                      ),
                      Text("记住密码"),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // 跳转到忘记密码页面
                      ToastUtils.showToast(context, "跳转到忘记密码页面");
                    },
                    child: Text("忘记密码?"),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // 登录按钮
              ElevatedButton(
                onPressed: _isLoggingIn ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: _isLoggingIn
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        "登录",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
              ),
              
              SizedBox(height: 20),
              
              // 注册链接
              Center(
                child: TextButton(
                  onPressed: () {
                    // 跳转到注册页面
                    ToastUtils.showToast(context, "跳转到注册页面");  
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "还没有账户？",
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: "立即注册",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 30),
              
              // 其他登录方式
              Column(
                children: [
                  Text(
                    "其他登录方式",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.wechat, color: Colors.green),
                        onPressed: () {
                          ToastUtils.showToast(context, "微信登录");
                        },
                      ),
                      SizedBox(width: 30),
                      IconButton(
                        icon: Icon(Icons.account_box, color: Colors.blue),
                        onPressed: () {
                          ToastUtils.showToast(context, "QQ登录");
                        },
                      ),
                      SizedBox(width: 30),
                      IconButton(
                        icon: Icon(Icons.apple, color: Colors.black),
                        onPressed: () {
                          ToastUtils.showToast(context, "Apple登录");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}