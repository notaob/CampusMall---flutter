class BannerItem {
  String id;
  final String imgUrl;

  BannerItem({required this.id, required this.imgUrl});
  //从json数据创建BannerItem对象
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(id: json['id'] ?? '', imgUrl: json['imgUrl'] ?? '');
  }
}

//根据json编写class对象和工厂转化函数


