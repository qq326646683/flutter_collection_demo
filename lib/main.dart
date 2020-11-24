import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/pages/canvas/canvas_canvas1_page.dart';
import 'package:flutter_collection_demo/pages/canvas/canvas_canvas2_page.dart';
import 'package:flutter_collection_demo/pages/canvas/canvas_paint_page.dart';
import 'package:flutter_collection_demo/pages/canvas/canvas_path1_page.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        CanvasPaintPage.sName: (_) => CanvasPaintPage(),
        CanvasCanvas1Page.sName: (_) => CanvasCanvas1Page(),
        CanvasCanvas2Page.sName: (_) => CanvasCanvas2Page(),
        CanvasPath1Page.sName: (_) => CanvasPath1Page(),
      },
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _renderHeader() {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil.isVertical(context) ? ScreenUtil.screenWidth(context) : ScreenUtil.screenWidth(context) / 2,
      height: ScreenUtil.isVertical(context) ? ScreenUtil.screenWidth(context) * 0.4 : ScreenUtil.screenHeight(context),
      color: Colors.pinkAccent,
      child: Text('我是头部'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ScreenUtil.isVertical(context) ? _buildVertical() : _buildHorizontal(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildVertical() {
    return Column(
      children: [
        _renderHeader(),
        Expanded(
          child: _buildList(),
        ),
      ],
    );
  }

  Widget _buildHorizontal() {
    return Row(
      children: [
        _renderHeader(),
        Expanded(
          child: _buildList(),
        ),
      ],
    );
  }

  Widget _buildList() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildListItem(CanvasPaintPage.sName),
          _buildListItem(CanvasCanvas1Page.sName),
          _buildListItem(CanvasCanvas2Page.sName),
          _buildListItem(CanvasPath1Page.sName),
        ],
      ),
    );
  }

  _buildListItem(String routName) {
    return FlatButton(
      onPressed: () {
        Navigator.pushNamed(context, routName);
      },
      child: Card(
        child: Container(
          alignment: Alignment.center,
          width: ScreenUtil.isVertical(context) ? ScreenUtil.screenWidth(context) : ScreenUtil.screenWidth(context) / 2,
          height: ScreenUtil.screenWidth(context) * 0.1,
          child: Text(routName),
        ),
      ),
    );
  }
}
