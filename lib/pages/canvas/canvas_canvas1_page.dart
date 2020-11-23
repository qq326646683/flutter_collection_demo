import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';

class CanvasCanvas1Page extends StatefulWidget {
  static const String sName = 'CanvasCanvas1Page';

  @override
  _CanvasCanvas1PageState createState() => _CanvasCanvas1PageState();
}

class _CanvasCanvas1PageState extends State<CanvasCanvas1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CanvasCanvas1Page.sName),
      ),
      body: Container(
        child: CustomPaint(
          size: Size(ScreenUtil.screenWidth(context), ScreenUtil.screenHeight(context)),
          painter: CanvasCanvasPainter1(),
        ),
      ),
    );
  }
}

/// 平移变换  缩放变换
class CanvasCanvasPainter1 extends CustomPainter {
  Paint _gridPaint;
  final double step = 20;
  final double strokeWidth = .5;
  final Color color = Colors.grey;

  CanvasCanvasPainter1() {
    _gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawCenter(canvas, size);
    _drawGridLine(canvas, size);
    _drawRotateDot(canvas, size);
    _drawPoints(canvas);
    _drawAxis(canvas, size);
    _drawRect(canvas);
    _drawDRRect(canvas);
    _drawArc(canvas);
    _drawPaint(canvas, size);
    _drawShadow(canvas, size);
    _drawPath(canvas);
  }

  _drawCenter(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    // 画布起点移到屏幕中心
    canvas.translate(size.width / 2, size.height / 2);
    // canvas.drawCircle(Offset(0, 0), 50, paint);

    // canvas.drawLine(
    //     Offset(0, 0),
    //     Offset(70, 70),
    //     paint
    //       ..color = Colors.red
    //       ..strokeWidth = 5
    //       ..strokeCap = StrokeCap.round);
  }

  _drawGridLine(Canvas canvas, Size size) {
    _draw1_4Grid(canvas, size);
    canvas.save();
    canvas.scale(1, -1);
    _draw1_4Grid(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1);
    _draw1_4Grid(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1);
    _draw1_4Grid(canvas, size);
    canvas.restore();
  }

  _draw1_4Grid(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPaint);
      canvas.translate(0, step);
    }
    canvas.restore();
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _gridPaint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  _drawRotateDot(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final int count = 12;
    canvas.save();
    for (int i = 0; i < count; i++) {
      canvas.drawLine(Offset(100, 0), Offset(120, 0), paint);
      canvas.rotate(2 * pi / count);
    }
    canvas.restore();
  }

  _drawPoints(Canvas canvas) {
    final List<Offset> points = [
      Offset(-120, -20),
      Offset(-80, -80),
      Offset(-40, -40),
      Offset(0, -100),
      Offset(40, -140),
      Offset(80, -160),
      Offset(120, -100),
    ];
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawPoints(ui.PointMode.polygon, points, paint);
  }

  _drawAxis(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _paint);
    canvas.drawLine(Offset(0, -size.height / 2), Offset(0, size.height / 2), _paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(0 - 7.0, size.height / 2 - 10), _paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(0 + 7.0, size.height / 2 - 10), _paint);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _paint);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _paint);
  }

  _drawRect(Canvas canvas) {
    Paint paint = Paint()..color = Colors.lightBlueAccent;
    // 矩形中心构造
    Rect rectFromCenter = Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRect(rectFromCenter, paint);
    // 矩形左上右下构造
    Rect rectFromLTRB = Rect.fromLTRB(-120, -120, -80, -80);
    canvas.drawRect(rectFromLTRB, paint..color = Colors.red);
    // 矩形左上宽高构造
    Rect rectFromLTWH = Rect.fromLTWH(80, -120, 40, 40);
    canvas.drawRect(rectFromLTWH, paint..color = Colors.orange);
    // 矩形内切圆构造
    Rect rectFromCircle = Rect.fromCircle(center: Offset(100, 100), radius: 20);
    canvas.drawRect(rectFromCircle, paint..color = Colors.green);
    // 矩形两点构造
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRect(rectFromPoints, paint..color = Colors.purple);
  }

  _drawDRRect(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    Rect outRect = Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    Rect inRect = Rect.fromCenter(center: Offset(0, 0), width: 80, height: 80); // 后者的区域必须小于前者

    canvas.drawDRRect(RRect.fromRectXY(outRect, 20, 20), RRect.fromRectXY(inRect, 10, 10), paint);
  }

  _drawArc(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    Rect rect = Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100);
    canvas.drawArc(rect, 0, pi / 2 * 3, true, paint);
  }

  _drawPaint(Canvas canvas, Size size) {
    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    Paint paint = Paint()
      ..shader = ui.Gradient.linear(Offset(0, 0), Offset(size.width, 0), colors, pos)
      ..blendMode = BlendMode.lighten;
    canvas.drawPaint(paint);
  }

  _drawShadow(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(80, 80);
    path.lineTo(-80, 80);
    path.close();
    canvas.drawShadow(path, Colors.red, 3, true);
    canvas.translate(200, 0);
    canvas.drawShadow(path, Colors.red, 3, false);
  }

  _drawPath(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.blue;
    Path path = Path();
    path.lineTo(60, 60);
    path.lineTo(-60, 60);
    path.lineTo(60, -60);
    path.lineTo(-60, -60);
    path.close();

    canvas.drawPath(path, paint);
    canvas.translate(140, 0);
    canvas.drawPath(path, paint..style = PaintingStyle.stroke);

  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
