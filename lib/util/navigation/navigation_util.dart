import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/page/base_widgets_page.dart';
import 'package:flutter_collection_demo/page/interactiveviewer_page.dart';
import 'package:flutter_collection_demo/page/listview_page.dart';
import 'package:flutter_collection_demo/page/loaddata_page.dart';

class RouteInfo {
  Route currentRoute;
  List<Route> routes;

  RouteInfo(this.currentRoute, this.routes);

  @override
  String toString() {
    return 'RouteInfo{currentRoute: $currentRoute, routes: $routes}';
  }


}

class NavigationUtil extends NavigatorObserver{
  static NavigationUtil _instance;

  static Map<String, WidgetBuilder> configRoutes = {
    BaseWidgetsPage.sName: (_) => BaseWidgetsPage(),
    InteractiveviewerPage.sName: (_) => InteractiveviewerPage(),
    ListViewPage.sName: (_) => ListViewPage(),
    LoadDataPage.sName: (_) => LoadDataPage(),
  };

  ///路由信息
  RouteInfo _routeInfo;
  RouteInfo get routeInfo => _routeInfo;
  ///stream相关
  static StreamController _streamController;
  StreamController<RouteInfo> get streamController=> _streamController;
  ///用来路由跳转
  static NavigatorState navigatorState;


  static NavigationUtil getInstance() {
    if (_instance == null) {
      _instance = new NavigationUtil();
      _streamController = StreamController<RouteInfo>.broadcast();
    }
    return _instance;
  }

  ///push route
  Future<T> pushRoute<T>(Route<T> route) {
    return navigatorState.push<T>(
        route
    );
  }

  ///push页面
  Future<T> pushNamed<T>(String routeName, {WidgetBuilder builder, bool fullscreenDialog}) {
    return navigatorState.push<T>(
      MaterialPageRoute(
        builder: builder ?? configRoutes[routeName],
        settings: RouteSettings(name: routeName),
        fullscreenDialog: fullscreenDialog ?? false,
      ),
    );
  }

  ///replace页面
  Future<T> pushReplacementNamed<T, R>(String routeName, {WidgetBuilder builder, bool fullscreenDialog}) {
    return navigatorState.pushReplacement<T, R>(
      MaterialPageRoute(
        builder: builder ?? configRoutes[routeName],
        settings: RouteSettings(name: routeName),
        fullscreenDialog: fullscreenDialog ?? false,
      ),
    );
  }

  // pop 页面
  pop<T>([T result]) {
    navigatorState.pop<T>(result);
  }
  //poputil返回到指定页面
  popUntil(String newRouteName) {
    return navigatorState.popUntil(ModalRoute.withName(newRouteName));
  }

  pushNamedAndRemoveUntil(String newRouteName, {arguments}) {
    return navigatorState.pushNamedAndRemoveUntil(newRouteName, (Route<dynamic> route) => false, arguments: arguments);
  }

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    if (_routeInfo == null) {
      _routeInfo = new RouteInfo(null, new List<Route>());
    }
    ///这里过滤调push的是dialog的情况
    if (route is CupertinoPageRoute || route is MaterialPageRoute) {
      _routeInfo.routes.add(route);
      routeObserver();
    }
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace();
    if (newRoute is CupertinoPageRoute || newRoute is MaterialPageRoute) {
      _routeInfo.routes.remove(oldRoute);
      _routeInfo.routes.add(newRoute);
      routeObserver();
    }
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    if (route is CupertinoPageRoute || route is MaterialPageRoute) {
      _routeInfo.routes.remove(route);
      routeObserver();
    }
  }

  @override
  void didRemove(Route removedRoute, Route oldRoute) {
    super.didRemove(removedRoute, oldRoute);
    if (removedRoute is CupertinoPageRoute || removedRoute is MaterialPageRoute) {
      _routeInfo.routes.remove(removedRoute);
      routeObserver();
    }
  }



  void routeObserver() {
    _routeInfo.currentRoute = _routeInfo.routes.last;
    navigatorState = _routeInfo.currentRoute.navigator;
//    L.d(_routeInfo.toString(), 'NavigationUtil');
    _streamController.sink.add(_routeInfo);
  }



}