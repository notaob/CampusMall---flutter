import 'package:flutter/material.dart';

class ToastUtils {
  //阀门控制
  static bool _isShow = false;
  static void showToast(BuildContext context, String? msg) {
    if (_isShow) {
      return;
    }
    _isShow = true;
    Future.delayed(Duration(seconds: 2), () {
      _isShow = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        content: Text(msg ?? '刷新成功', textAlign: TextAlign.center),
      ),
    );
  }
}