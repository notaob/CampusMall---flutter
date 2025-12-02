import 'package:campusmall/viewmodels/SuggestionItem.dart';
import 'package:flutter/material.dart';

class Hot extends StatefulWidget {
  final SuggestionResult dataList;
  final String type;
  Hot({Key? key, required this.dataList, required this.type}) : super(key: key);

  @override
  _HotState createState() => _HotState();
}

class _HotState extends State<Hot> {
    List<GoodsItem> _getHotItems() {
    if (widget.dataList.subTypes.isEmpty) {
      return [];
    }
    return widget.dataList.subTypes.first.goodsItems.items
        .take(2)
        .toList();
  }
List<Column> _buildHotView() {
    List<GoodsItem> hotItems = _getHotItems();
    return List.generate(hotItems.length, (index) {
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
                image: NetworkImage(hotItems[index].picture),

                //图片未加载时显示的占位符
                // placeholder 参数已被移除，使用 errorBuilder 处理加载失败
                width: 75,
                height: 75,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 75,
                    height: 75,
                    child: Image.asset(
                      "lib/assets/home_cmd_inner.png",
                      fit: BoxFit.fill, // 保持图片比例
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
                  hotItems[index].price,
                  style: TextStyle(
                    fontSize: 12,
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
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.type == "invogue" 
            ? [const Color.fromARGB(255, 61, 125, 170), Colors.grey]
            : [const Color.fromARGB(255, 158, 158, 158), Colors.grey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: widget.type == "invogue" 
              ? Colors.red.withOpacity(0.3)
              : Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              widget.type == "invogue" ? "爆款推荐" : "一站买全",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildHotView(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}