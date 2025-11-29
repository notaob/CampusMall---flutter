//基于Dio进行二次封装
import 'package:campusmall/constants/index.dart';
import 'package:dio/dio.dart';

class DioRequest {
  final Dio _dio = Dio();
  //基础地址拦截器
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(milliseconds: GlobalConstants.DEFAULT_TIMEOUT)
      ..receiveTimeout = Duration(milliseconds: GlobalConstants.DEFAULT_TIMEOUT);
    //添加拦截器
    _addInterceptors();
  }
  //添加拦截器
  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          //在发送请求之前做一些事情
          return handler.next(request); //继续发送请求
        },
        onResponse: (response, handler) {
          //在收到响应数据之前做一些事情
          //http状态码 200 300
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response); //继续处理响应
            return;
          }
          handler.reject(DioException(requestOptions: response.requestOptions));
        },
        onError: (e, handler) {
          //在发生错误时做一些事情
          return handler.next(e); //继续处理错误
        },
      ),
    );
  }

  //get请求
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  //进一步处理返回结果函数
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data['code'] == GlobalConstants.SUCCESS_CODE) {
        return data['result'];
      }
      throw Exception(data['msg'] ?? '请求失败');
    } catch (e) {
      throw Exception(e);
    }
  }
}

//单例对象
final dioRequest = DioRequest();
