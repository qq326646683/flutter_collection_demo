import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';

class CanvasPath1Page extends StatefulWidget {
  static const String sName = 'CanvasPath1Page';

  @override
  _CanvasPath1PageState createState() => _CanvasPath1PageState();
}

class _CanvasPath1PageState extends State<CanvasPath1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CanvasPath1Page.sName),
      ),
      body: Container(
        child: CustomPaint(
          size: Size(ScreenUtil.screenWidth(context), ScreenUtil.screenHeight(context)),
          painter: CanvasPath1Painter(),
        ),
      ),
    );
  }
}

class CanvasPath1Painter extends CustomPainter {
  double step = 20.0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    // _moveToLineTo(canvas);
    // _relativeMoveToLineTo(canvas);
    // _arcTo(canvas);
    // _arcToPoint(canvas);
    // _conicTo(canvas);
    // _quadraticBezierTo(canvas);
    // _cubicTo(canvas);
    // _addRect(canvas);
    // _addPolygon(canvas);
    _drawGridLine(canvas, size);
  }

  _moveToLineTo(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..style = PaintingStyle.fill;
    path
      ..moveTo(0, 0)
      ..lineTo(60, 80)
      ..lineTo(60, 0)
      ..lineTo(0, -80)
      ..close();

    canvas.drawPath(path, paint);

    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    path
      ..moveTo(0, 0)
      ..lineTo(-60, 80)
      ..lineTo(-60, 0)
      ..lineTo(0, -80);
    canvas.drawPath(path, paint);
  }

  _relativeMoveToLineTo(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..style = PaintingStyle.fill;

    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo(60, -10)
      ..close();
    canvas.drawPath(path, paint);

    path.reset();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.green
      ..strokeWidth = 2;

    path
      ..relativeMoveTo(-200, 0)
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo(60, -10)
      ..close();

    canvas.drawPath(path, paint);
  }

  // 圆弧
  _arcTo(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    //绘制左侧
    Rect rect = Rect.fromCenter(center: Offset(0, 0), width: 160, height: 100);
    path.lineTo(0, -20);
    path..arcTo(rect, 0, pi * 1.5, false);
    canvas.drawPath(path, paint);
  }

  // 点定弧
  _arcToPoint(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.lineTo(80, -40);

    path
      ..arcToPoint(Offset(30, 30), radius: Radius.circular(60), largeArc: true, clockwise: true)
      ..close();
    canvas.drawPath(path, paint);
  }

  // 圆锥曲线
  _conicTo(Canvas canvas) {
    final Offset p1 = Offset(80, -100);
    final Offset p2 = Offset(160, 0);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1.5);
    canvas.drawPath(path, paint);
  }

  // 二阶贝塞尔
  _quadraticBezierTo(Canvas canvas) {
    final Offset p1 = Offset(100, -100);
    final Offset p2 = Offset(160, 50);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    path.relativeQuadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    canvas.drawPath(path, paint);
  }

  // 三阶贝塞尔
  _cubicTo(Canvas canvas) {
    final Offset p1 = Offset(80, -100);
    final Offset p2 = Offset(80, 50);
    final Offset p3 = Offset(160, 50);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    path.cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    path.relativeCubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    canvas.drawPath(path, paint);
  }

  // 加矩形、圆、椭圆
  _addRect(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromPoints(Offset(100, 100), Offset(160, 160));
    Rect rect2 = Rect.fromPoints(Offset(100, 100), Offset(160, 140));

    path
      ..lineTo(100, 100)
      ..addRect(rect)
      ..lineTo(200, 0)
      ..addOval(rect2.translate(100, -100))
      ..addArc(rect2, 0, pi);

    canvas.drawPath(path, paint);
  }

  // 加多边形
  _addPolygon(Canvas canvas) {
    Offset p = Offset(100, 100);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    path
      ..lineTo(100, 100)
      ..addPolygon([
        p,
        p.translate(20, -20),
        p.translate(40, -20),
        p.translate(60, 0),
        p.translate(60, 20),
        p.translate(40, 40),
        p.translate(20, 40),
        p.translate(0, 20),
      ], true)
      ..addPath(Path()..relativeQuadraticBezierTo(125, -100, 260, 0), Offset.zero)
      ..lineTo(160, 100);
    canvas.drawPath(path, paint);
  }

  _drawGridLine(Canvas canvas, Size size) {
    Paint _gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5
      ..color = Colors.grey;
    Path _gridPath = Path();

    for (int i = 0; i < size.width / 2 / step; i++) {
      _gridPath.moveTo(step * i, -size.height / 2);
      _gridPath.relativeLineTo(0, size.height);
      _gridPath.moveTo(-step * i, -size.height / 2);
      _gridPath.relativeLineTo(0, size.height);
    }

    for (int i = 0; i < size.height / 2 / step; i++) {
      _gridPath.moveTo(-size.width / 2, step * i);
      _gridPath.relativeLineTo(size.width, 0);
      _gridPath.moveTo(-size.width / 2, -step * i);
      _gridPath.relativeLineTo(size.width, 0);
    }

    canvas.drawPath(_gridPath, _gridPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
