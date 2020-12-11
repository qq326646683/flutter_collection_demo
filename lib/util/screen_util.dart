import 'package:flutter/cupertino.dart';
import 'package:flutter_collection_demo/util/common_util.dart';

const double designW = 375.0;
const double designH = 810.0;

class S {
  double _screenWidth;
  double _screenHeight;
  double _statusBarHeight;
  double _bottomBarHeight;


  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  double get statusBarHeight => _statusBarHeight;

  double get bottomBarHeight => _bottomBarHeight;


  static S _instance;

  factory  S() {
    if (_instance == null) {
      _instance = new S._();
    }
    return _instance;
  }

  double w(double width) {
    return width * _screenWidth / designW;
  }

  double h(double height) {
    return height * _screenHeight / designH;
  }

  S._() {
    MediaQueryData mediaQuery = MediaQuery.of(CommonUtil.currentContext);

    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
  }




}