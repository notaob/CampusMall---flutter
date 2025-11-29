import 'package:campusmall/api/Home.dart';
import 'package:campusmall/components/Home/Category.dart';
import 'package:campusmall/components/Home/Hot.dart';
import 'package:campusmall/components/Home/MoreList.dart';
import 'package:campusmall/components/Home/Slider.dart';
import 'package:campusmall/components/Home/Suggestion.dart';
import 'package:campusmall/utils/ToastUtils.dart';
import 'package:campusmall/viewmodels/BannerItem.dart';
import 'package:campusmall/viewmodels/CategoryItem.dart';
import 'package:campusmall/viewmodels/GoodDetailItem.dart';
import 'package:campusmall/viewmodels/SuggestionItem.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BannerItem> _bannerList = [];
  List<CategoryItem> _categoryList = [];
  SuggestionResult _suggestionResult = SuggestionResult(
    id: '',
    title: '',
    subTypes: [],
  );
  SuggestionResult _InvogueResult = SuggestionResult(
    id: '',
    title: '',
    subTypes: [],
  );
  SuggestionResult _OnestopResult = SuggestionResult(
    id: '',
    title: '',
    subTypes: [],
  );
  // 推荐列表
  List<GoodDetailItem> _recommendList = [];
    List<Widget> _getSlivers() {
    return [
      SliverToBoxAdapter(child: Sliders(bannerList: _bannerList)),

      SliverToBoxAdapter(child: SizedBox(height: 20)),

      SliverToBoxAdapter(child: Category(categoryList: _categoryList)),

      SliverToBoxAdapter(child: SizedBox(height: 20)),

      SliverToBoxAdapter(child: Suggestion(suggestionResult: _suggestionResult)),

      SliverToBoxAdapter(child: SizedBox(height: 20)),

      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: Hot(dataList: _InvogueResult, type: 'invogue',)),
              SizedBox(width: 20),
              Expanded(child: Hot(dataList: _OnestopResult, type: 'onestop',)),
            ],
          ),
        ),
      ),

      SliverToBoxAdapter(child: SizedBox(height: 20)),

      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        sliver: MoreList(recommendList: _recommendList),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _registerScrollController();
    Future.microtask(() {
      _paddingTop = 100;
      _refreshIndicatorKey.currentState?.show();
      setState(() {});
    } );
  }

  void _registerScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        // 加载更多数据
        _getRecommendList();
      }
    });
  }
  Future<void>  _getBannerList() async {
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  //获取分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }

  //获取特惠推荐
  Future<void> _getSuggestionList() async {
    _suggestionResult = await getSuggestionListAPI();
    setState(() {});
  }
  //获取热门搜索
  Future<void> _getInvogueList() async {
    _InvogueResult = await getInvogueListAPI();
    setState(() {});
  }
  //获取一次停止
  Future<void> _getOnestopList() async {
    _OnestopResult = await getOnestopListAPI();
    setState(() {});
  }
  int _recommendListPage = 1;
  // 推荐列表是否在加载中
  bool _recommendListLoading = false;
  //是否还有下一页
  bool _recommendListHasMore = true;
    // 获取推荐列表
  Future<void> _getRecommendList() async {
    if (!_recommendListHasMore || _recommendListLoading) {
      return;
    }
    _recommendListLoading = true;
    int request=_recommendListPage*2;
    _recommendList = await getRecommendListAPI({"limit": request});
    _recommendListLoading = false;
    if (_recommendList.length < request) {
      _recommendListHasMore = false;
      return;
    }
    _recommendListPage++;
    setState(() {});
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final ScrollController _scrollController = ScrollController();
  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        // 重置分页参数
        _recommendListPage = 1;
        _recommendListHasMore = true;
        _recommendListLoading = false;
        // 重新加载所有数据
        await _getBannerList();
        await _getCategoryList();
        await _getSuggestionList();
        await _getInvogueList();
        await _getOnestopList();
        await _getRecommendList();
        // 刷新成功后显示提示
        ToastUtils.showToast(context, '刷新成功');
        // 刷新完成后，将 paddingTop 设为 0
        _paddingTop = 0;
        setState(() {});
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(top: _paddingTop),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: _getSlivers(),
        ),
      ),
    );
  }
}
