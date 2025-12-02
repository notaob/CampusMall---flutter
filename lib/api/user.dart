import 'package:campusmall/constants/index.dart';
import 'package:campusmall/utils/DioRequest.dart';
import 'package:campusmall/viewmodels/UserInfo.dart';

Future<UserInfo> loginAPI(Map<String,dynamic> data) async {
  final res = await dioRequest.post(HTTPConstants.LOGIN, data:data);
  return UserInfo.fromJSON(res);
}

Future<UserInfo> getUserProfileAPI() async {
  final res = await dioRequest.get(HTTPConstants.USER_PROFILE);
  return UserInfo.fromJSON(res);
}
