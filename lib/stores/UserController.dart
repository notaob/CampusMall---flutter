import 'package:campusmall/viewmodels/UserInfo.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  var user = UserInfo.fromJSON({}).obs;
  updateUserInfo(UserInfo userInfo){
    user.value = userInfo;
  }
  // 退出登录
  void logout() {
    user.value = UserInfo.fromJSON({});
  }
}