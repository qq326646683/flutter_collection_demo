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
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    // _moveToLineTo(canvas);
    // _relativeMoveToLineTo(canvas);
    // _arcTo(canvas);
    // _arcToPoint(canvas);
    _conicTo(canvas);
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
