import 'package:flutter_collection_demo/model/banner_model.dart';

typedef T CreateModel<T>(Map<String, dynamic> json);

class ModelFactory {
  static void registerAllCreator() {
    ModelFactory.getInstance()._registerCreator(BannerModel, (Map<String, dynamic> json) => BannerModel.fromJson(json));
  }

  static T createModel<T>(Map<dynamic, dynamic> json) {
    return ModelFactory.getInstance()._generateModel<T>(mapDynamicDynamicToStringDynamic(json));
  }

  static List<T> createModelList<T>(List<dynamic> jsonList) {
    return ModelFactory.getInstance()._generateModelList<T>(jsonList);
  }

  static Map<String, dynamic> mapDynamicDynamicToStringDynamic(Map<dynamic, dynamic> map) {
    Map<String, dynamic> targetMap = {};
    if (map == null) {
      return targetMap;
    }
    List<dynamic> keyList = map.keys.toList();
    for (dynamic key in keyList) {
      targetMap[key.toString()] = map[key];
    }
    return targetMap;
  }

  Map<Type, CreateModel> typeMaps = new Map();

  static ModelFactory? _instance;

  static ModelFactory getInstance() {
    if (_instance == null) {
      _instance = new ModelFactory();
    }
    return _instance!;
  }

  _registerCreator(Type type, CreateModel creator) {
    typeMaps[type] = creator;
  }

  T _generateModel<T>(Map<String, dynamic> json) {
    CreateModel? creator = typeMaps[T];
    if (creator == null) throw Exception('未注册[$T]解析器');
    return creator(json);
  }

  List<T> _generateModelList<T>(List<dynamic> jsonList) {
    CreateModel? creator = typeMaps[T];
    if (creator == null) throw Exception('未注册[$T]解析器');
    return jsonList.map((dynamic json) => creator(json) as T).toList();
  }
}
