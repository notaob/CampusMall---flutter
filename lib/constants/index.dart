//全局常量
class GlobalConstants {
  static const String BASE_URL = "https://meikou-api.itheima.net";//接口基础地址
  static const int DEFAULT_TIMEOUT = 5000;//默认超时时间
  static const String SUCCESS_CODE = "1";//成功状态码
  static const String FAIL_CODE = "0";//失败状态码
}

//存放请求地址接口常量
class HTTPConstants {
  static const String BANNER_LIST = "/home/banner";//轮播图列表  
  static const String CATEGORY_LIST = "/home/category/head";//分类列表
  static const String SUGGESTION_LIST = "/hot/preference";//建议列表
  static const String INVOGUE_LIST = "/hot/inVogue";//爆款推荐
  static const String ONESTOP_LIST = "/hot/oneStop";//一站买全
  static const String RECOMMEND_LIST = "/home/recommend";//商品列表
}