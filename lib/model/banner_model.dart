class BannerModel {
  int id;
  String desc;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  BannerModel({required this.id, required this.desc, required this.imagePath, required this.isVisible, required this.order, required this.title, required this.type, required this.url});

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json['id'] as int,
        desc: json['desc'] as String,
        imagePath: json['imagePath'] as String,
        isVisible: json['isVisible'] as int,
        order: json['order'] as int,
        title: json['title'] as String,
        type: json['type'] as int,
        url: json['url'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'desc': desc,
        'imagePath': imagePath,
        'isVisible': isVisible,
        'order': order,
        'title': title,
        'type': type,
        'url': url,
      };
}
