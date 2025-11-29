// 特惠推荐相关的模型类

// 商品项类
class GoodsItem {
  final String id;
  final String name;
  final String? desc;
  final String price;
  final String picture;
  final int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  // 从JSON创建对象的工厂方法
  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id'] as String,
      name: json['name'] as String,
      desc: json['desc'] as String?,
      price: json['price'] as String,
      picture: json['picture'] as String,
      orderNum: json['orderNum'] as int,
    );
  }

  // 转换为JSON的方法
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'picture': picture,
      'orderNum': orderNum,
    };
  }
}

// 商品列表容器类
class GoodsItems {
  final int counts;
  final int pageSize;
  final int pages;
  final int page;
  final List<GoodsItem> items;

  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  // 从JSON创建对象的工厂方法
  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'] as int,
      pageSize: json['pageSize'] as int,
      pages: json['pages'] as int,
      page: json['page'] as int,
      items: (json['items'] as List<dynamic>)
          .map((item) => GoodsItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // 转换为JSON的方法
  Map<String, dynamic> toJson() {
    return {
      'counts': counts,
      'pageSize': pageSize,
      'pages': pages,
      'page': page,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

// 子类型类
class SubType {
  final String id;
  final String title;
  final GoodsItems goodsItems;

  SubType({
    required this.id,
    required this.title,
    required this.goodsItems,
  });

  // 从JSON创建对象的工厂方法
  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id'] as String,
      title: json['title'] as String,
      goodsItems: GoodsItems.fromJson(json['goodsItems'] as Map<String, dynamic>),
    );
  }

  // 转换为JSON的方法
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'goodsItems': goodsItems.toJson(),
    };
  }
}

// 推荐结果类
class SuggestionResult {
  final String id;
  final String title;
  final List<SubType> subTypes;

  SuggestionResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  // 从JSON创建对象的工厂方法
  factory SuggestionResult.fromJson(Map<String, dynamic> json) {
    return SuggestionResult(
      id: json['id'] as String,
      title: json['title'] as String,
      subTypes: (json['subTypes'] as List<dynamic>)
          .map((subType) => SubType.fromJson(subType as Map<String, dynamic>))
          .toList(),
    );
  }

  // 转换为JSON的方法
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subTypes': subTypes.map((subType) => subType.toJson()).toList(),
    };
  }
}
