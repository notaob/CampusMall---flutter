import 'package:campusmall/viewmodels/SuggestionItem.dart';
import 'package:flutter/material.dart';

class Suggestion extends StatefulWidget {
  final SuggestionResult suggestionResult;
  Suggestion({Key? key, required this.suggestionResult}) : super(key: key);

  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {

  //取前三条数据
  List<GoodsItem> _getSuggestionItems() {
    if (widget.suggestionResult.subTypes.isEmpty) {
      return [];
    }
    return widget.suggestionResult.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  //顶部标题
  Widget _buildHeaderView() {
    return Container(
      height: 45, // 稍微减少高度
      width: double.infinity,
      padding: EdgeInsets.only(left: 5), // 调整内边距
      child: Image.asset(
        "lib/assets/home_cmd_title.png",
        alignment: Alignment.centerLeft,
        fit: BoxFit.contain, // 保持图片比例
      ),
    );
  }

  Widget _buildLeftView() {
    return Container(
      width: 100,
      height: 1000,
      padding: EdgeInsets.only(left: 15, bottom: 40), // 调整内边距
      child: Image.asset(
        "lib/assets/home_cmd_inner.png",
        fit: BoxFit.contain, // 保持图片比例
      ),
    );
  }

  List<Column> _buildRightView() {
    List<GoodsItem> suggestionItems = _getSuggestionItems();
    return List.generate(suggestionItems.length, (index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 商品图片容器
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: NetworkImage(suggestionItems[index].picture),

                //图片未加载时显示的占位符
                // placeholder 参数已被移除，使用 errorBuilder 处理加载失败
                width: 75,
                height: 75,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 75,
                    height: 75,
                    child: Image.asset(
                      "lib/assets/home_cmd_inner.png",
                      fit: BoxFit.cover, // 保持图片比例
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 8),

          // 商品价格
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.redAccent.withOpacity(0.2),
                  Colors.deepOrange.withOpacity(0.2),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.redAccent.withOpacity(0.4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.attach_money_outlined,
                  size: 14,
                  color: Colors.redAccent.shade700,
                ),
                Text(
                  suggestionItems[index].price,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.redAccent.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 增加垂直间距
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // 稍微增加圆角
          image: DecorationImage(
            image: AssetImage("lib/assets/home_cmd_sm.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildHeaderView(),
            SizedBox(height: 8), // 增加标题和下方内容的间距
            Expanded(
              child: Row(
                children: [
                  _buildLeftView(),
                  SizedBox(width: 8), // 增加左视图和右视图的间距
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _buildRightView(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
