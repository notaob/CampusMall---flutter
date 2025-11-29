import 'package:campusmall/constants/index.dart';
import 'package:campusmall/utils/DioRequest.dart';
import 'package:campusmall/viewmodels/BannerItem.dart';
import 'package:campusmall/viewmodels/CategoryItem.dart';
import 'package:campusmall/viewmodels/GoodDetailItem.dart';
import 'package:campusmall/viewmodels/SuggestionItem.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  final data = await dioRequest.get(HTTPConstants.BANNER_LIST);
  return (data as List).map((json) => BannerItem.fromJson(json as Map<String, dynamic>)).toList();
}

Future<List<CategoryItem>> getCategoryListAPI() async {
  final data = await dioRequest.get(HTTPConstants.CATEGORY_LIST);
  return (data as List).map((json) => CategoryItem.fromJson(json as Map<String, dynamic>)).toList();
}

Future<SuggestionResult> getSuggestionListAPI() async {
  final data = await dioRequest.get(HTTPConstants.SUGGESTION_LIST);
  return SuggestionResult.fromJson(data as Map<String, dynamic>);
}

Future<SuggestionResult> getInvogueListAPI() async {
  final data = await dioRequest.get(HTTPConstants.INVOGUE_LIST);
  return SuggestionResult.fromJson(data as Map<String, dynamic>);
}

Future<SuggestionResult> getOnestopListAPI() async {
  final data = await dioRequest.get(HTTPConstants.ONESTOP_LIST);
  return SuggestionResult.fromJson(data as Map<String, dynamic>);
}

// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await dioRequest.get(HTTPConstants.RECOMMEND_LIST, params: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}
