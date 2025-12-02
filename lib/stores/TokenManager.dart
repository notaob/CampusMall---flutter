import 'package:campusmall/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  Future<SharedPreferences> _getInstance() async {
    return SharedPreferences.getInstance();
  }

  String _token = "";
  
  // 初始化 token
  init() async { 
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  // 设置 token
  setToken(String token) async {
    final prefs = await _getInstance();
    await prefs.setString(GlobalConstants.TOKEN_KEY, token);
    _token = token;
  }
  
  // 获取 token（同步方法，返回当前存储的 token）
  String getToken() {
    return _token;
  }

  // 异步获取 token（从 SharedPreferences 中获取最新的 token）
  Future<String> getStoredToken() async {
    final prefs = await _getInstance();
    return prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  // 移除 token
  removeToken() async {
    final prefs = await _getInstance();
    await prefs.remove(GlobalConstants.TOKEN_KEY);
    _token = "";
  }
}

final tokenManager = TokenManager();
