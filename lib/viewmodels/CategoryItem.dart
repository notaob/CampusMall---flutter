class CategoryItem {
  String id;
  final String name;
  final String picture;
  //子分类列表
  final List<CategoryItem>? children;
  //商品列表
  final List<Map<String, dynamic>>? goods;

  CategoryItem({required this.id, required this.name, required this.picture, this.children, this.goods});
  //从json数据创建CategoryItem对象
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    List<CategoryItem>? children;
    if (json['children'] != null) {
      children = (json['children'] as List)
          .map((child) => CategoryItem.fromJson(child as Map<String, dynamic>))
          .toList()
          .cast<CategoryItem>();
    }

    return CategoryItem(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
      children: children,
      goods: json['goods'] as List<Map<String, dynamic>>?,
    );
  }
}
