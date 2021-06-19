import 'package:dokit/dokit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/page/function_page.dart';
import 'package:flutter_collection_demo/page/more_page.dart';
import 'package:flutter_collection_demo/page/widget_page.dart';
import 'package:flutter_collection_demo/util/common_util.dart';
import 'package:flutter_collection_demo/util/navigation/navigation_util.dart';
import 'package:oktoast/oktoast.dart';

import 'net/model_factory.dart';

void main() {
  DoKit.runApp(
    app: DoKitApp(MyApp()),
    useInRelease: true
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        navigatorKey: CommonUtil.navigatorKey,
        navigatorObservers: [NavigationUtil.getInstance()!],
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 页面控制
  late PageController _pageController;

  // 当前页面
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    ModelFactory.registerAllCreator();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // 底部栏切换
  void _onBottomNavigationBarTap(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[WidgetPage(), FunctionPage(), MorePage()],
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        onTap: _onBottomNavigationBarTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), title: Text('组件')),
          BottomNavigationBarItem(icon: Icon(Icons.style), title: Text('功能')),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_vert), title: Text('更多')),
        ],
      ),
    );
  }
}
