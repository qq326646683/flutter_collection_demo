import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';

class CanvasPaintPage extends StatefulWidget {
  static const String sName = 'CanvasPaintPage';

  @override
  _CanvasPaintPageState createState() => _CanvasPaintPageState();
}

class _CanvasPaintPageState extends State<CanvasPaintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CanvasPaintPage.sName),
      ),
      body: Container(
        child: CustomPaint(
          painter: CanvasPainter1(context),
        ),
      ),
    );
  }
}

class CanvasPainter1 extends CustomPainter {
  BuildContext context;

  CanvasPainter1(BuildContext context) {
    this.context = context;
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawAntiAliasColor(canvas);
    drawStyleStrokeWidth(canvas);
    drawSrokeCap(canvas);
    drawStrokeJoin(canvas);
  }

  drawAntiAliasColor(Canvas canvas) {
    double width = ScreenUtil.screenWidth(context) * 0.2;
    Paint paint = Paint();
    paint
      ..color = Colors.blue
      ..strokeWidth = 5;
    canvas.drawCircle(Offset(width, width), width, paint);
    paint
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..isAntiAlias = false;
    canvas.drawCircle(Offset(width * 3, width), width, paint);
  }

  drawStyleStrokeWidth(Canvas canvas) {
    double width = ScreenUtil.screenWidth(context) * 0.2;

    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50;
    canvas.drawCircle(Offset(width, width), width, paint);
    paint
      ..style = PaintingStyle.fill
      ..strokeWidth = 50;
    canvas.drawCircle(Offset(width * 3.5, width), width, paint);
  }

  drawSrokeCap(Canvas canvas) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    canvas.drawLine(Offset(50, 50), Offset(50, 150), paint..strokeCap = StrokeCap.butt); // 线帽类型： 不出头
    canvas.drawLine(Offset(100, 50), Offset(100, 150), paint..strokeCap = StrokeCap.round); // 圆头
    canvas.drawLine(Offset(150, 50), Offset(150, 150), paint..strokeCap = StrokeCap.square); // 方头
  }

  drawStrokeJoin(Canvas canvas) {
    Paint paint = Paint();
    Path path = Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    path.moveTo(50, 50);
    path.lineTo(50, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.bevel);// 线接类型：斜角

    path.reset();
    path.moveTo(50 + 150.0, 50);
    path.lineTo(50 + 150.0, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.miter);// 锐角/斜接

    path.reset();
    path.moveTo(50 + 150.0 * 2, 50);
    path.lineTo(50 + 150.0 * 2, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.round);// 圆角
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
