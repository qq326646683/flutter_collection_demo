import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';

class CanvasCanvas2Page extends StatefulWidget {
  static const String sName = 'CanvasCanvas2Page';

  @override
  _CanvasCanvas2PageState createState() => _CanvasCanvas2PageState();
}

class _CanvasCanvas2PageState extends State<CanvasCanvas2Page> {
  ui.Image _image;

  @override
  void initState() {
    super.initState();
    _loadImg();
  }

  _loadImg() async {
    // _image = await loadImageFromAssets('assets/plant.png');
    // _image = await loadImageFromAssets('assets/right_chat.png');
    _image = await loadImageFromAssets('assets/shoot.png');
    setState(() {});
  }

  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CanvasCanvas2Page.sName),
      ),
      body: Container(
        child: CustomPaint(
          size: Size(ScreenUtil.screenWidth(context), ScreenUtil.screenHeight(context)),
          painter: CanvasCanvasPainter2(_image),
        ),
      ),
    );
  }
}

class Sprite {
  Rect position; // 雪碧图 中 图片矩形区域
  Offset offset; // 移动偏倚
  int alpha; // 透明度
  double rotation; // 旋转角度
  Sprite({this.offset, this.alpha, this.rotation, this.position});
}

class CanvasCanvasPainter2 extends CustomPainter {
  ui.Image _image;
  Paint _paint;
  final double step = 20;
  final List<Sprite> spriteList = [];

  CanvasCanvasPainter2(this._image) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.5
      ..color = Colors.blue;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawGridLine(canvas, size);
    _drawAxis(canvas, size);
    // _drawImg(canvas);
    // _drawImageRect(canvas);
    // _drawImageNine(canvas);
    // _drawAtlas(canvas);
    // _drawRawAtlas(canvas);
    // _drawTextWithParagraph(canvas);
    // _drawTextPaint(canvas);
    _drawAxisText(canvas, size);
  }

  void _drawImg(Canvas canvas) {
    if (_image != null) {
      canvas.drawImage(_image, Offset(-_image.width / 2, -_image.height / 2), _paint);
    }
  }

  void _drawImageRect(Canvas canvas) {
    if (_image != null) {
      canvas.drawImageRect(
        _image,
        Rect.fromCenter(center: Offset(_image.width / 2, _image.height / 2), width: 60, height: 60),
        Rect.fromLTRB(0, 0, 100, 100).translate(200, 0),
        _paint,
      );

      canvas.drawImageRect(
        _image,
        Rect.fromCenter(center: Offset(_image.width / 2, _image.height / 2 + 60), width: 60, height: 60),
        Rect.fromLTRB(0, 0, 100, 100).translate(-280, -100),
        _paint,
      );

      canvas.drawImageRect(
        _image,
        Rect.fromCenter(center: Offset(_image.width / 2 - 60, _image.height / 2), width: 60, height: 60),
        Rect.fromLTRB(0, 0, 100, 100).translate(-280, 50),
        _paint,
      );
    }
  }

  void _drawImageNine(Canvas canvas) {
    if (_image != null) {
      canvas.drawImageNine(
        _image,
        Rect.fromCenter(center: Offset(_image.width / 2, _image.height - 6.0), width: _image.width - 20.0, height: 2.0),
        Rect.fromCenter(center: Offset(0, 0), width: 300, height: 140).translate(200, 0),
        _paint,
      );
    }
  }

  void _drawAtlas(Canvas canvas) {
    if (_image == null) {
      return;
    }
    spriteList.add(
      Sprite(
        position: Rect.fromLTWH(0, 325, 275, 166),
        offset: Offset(0, 0),
        alpha: 255,
        rotation: 0,
      ),
    );

    List<RSTransform> transforms = spriteList
        .map((sprite) => RSTransform.fromComponents(
              rotation: sprite.rotation,
              scale: 1.0,
              anchorX: 0,
              anchorY: 0,
              translateX: sprite.offset.dx,
              translateY: sprite.offset.dy,
            ))
        .toList();

    List<Rect> rects = spriteList.map((e) => e.position).toList();

    canvas.drawAtlas(_image, transforms, rects, null, null, null, _paint);
  }

  void _drawRawAtlas(Canvas canvas) {
    spriteList.add(Sprite(position: Rect.fromLTWH(0, 325, 257, 166), offset: Offset(0, 0), alpha: 255, rotation: 0));

    spriteList.add(Sprite(position: Rect.fromLTWH(0, 325, 257, 166), offset: Offset(257, 130), alpha: 255, rotation: 0));

    Float32List rectList = Float32List(spriteList.length * 4);
    Float32List transformList = Float32List(spriteList.length * 4);

    for (int i = 0; i < spriteList.length; i++) {
      Sprite sprite = spriteList[i];
      rectList[i * 4 + 0] = sprite.position.left;
      rectList[i * 4 + 1] = sprite.position.top;
      rectList[i * 4 + 2] = sprite.position.right;
      rectList[i * 4 + 3] = sprite.position.bottom;

      RSTransform transform = RSTransform.fromComponents(
        rotation: sprite.rotation,
        scale: 1.0,
        anchorX: 0,
        anchorY: 0,
        translateX: sprite.offset.dx,
        translateY: sprite.offset.dy,
      );

      transformList[i * 4 + 0] = transform.scos;
      transformList[i * 4 + 1] = transform.ssin;
      transformList[i * 4 + 2] = transform.tx;
      transformList[i * 4 + 3] = transform.ty;
    }
    canvas.drawRawAtlas(_image, transformList, rectList, null, null, null, _paint);
  }

  _drawTextWithParagraph(Canvas canvas) {
    ui.ParagraphBuilder builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.left,
      fontSize: 40,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ));
    builder.pushStyle(ui.TextStyle(color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic));
    builder.addText("Hello World");
    ui.Paragraph phragraph = builder.build();
    phragraph.layout(ui.ParagraphConstraints(width: 300));
    canvas.drawParagraph(phragraph, Offset(0, 0));
    canvas.drawRect(Rect.fromLTRB(0, 0, 300, 40), _paint..color = Colors.red.withAlpha(33));
  }

  _drawTextPaint(Canvas canvas) {
    Paint textPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: 'Hello Flutter',
        style: TextStyle(
          fontSize: 40,
          foreground: textPaint,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: 200);
    Size size = textPainter.size;
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));
  }

  _drawGridLine(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

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
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _paint);
      canvas.translate(0, step);
    }
    canvas.restore();
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _paint);
      canvas.translate(step, 0);
    }
    canvas.restore();
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

  _drawAxisText(Canvas canvas, Size size) {
    // y > 0的字
    canvas.save();
    for (int i = 0; i< size.height / 2 / step; i++) {
      if (i.isOdd || i == 0) {
        canvas.translate(0, step);
        continue;
      } else {
        String str = (i * step).toInt().toString();
        _drawAxisTextText(canvas, str);
      }
      canvas.translate(0, step);
    }
    canvas.restore();

    // x > 0的字
    canvas.save();
    for (int i = 0; i< size.height / 2 / step; i++) {
      if (i.isOdd) {
        canvas.translate(step, 0);
        continue;
      } else {
        if (i == 0) {
          _drawAxisTextText(canvas, "0", isX: null);
        } else {
          String str = (i * step).toInt().toString();
          _drawAxisTextText(canvas, str, isX: true);
        }

      }
      canvas.translate(step, 0);
    }
    canvas.restore();

    // y < 0的字
    canvas.save();
    for (int i = 0; i< size.height / 2 / step; i++) {
      if (i.isOdd || i == 0) {
        canvas.translate(0, -step);
        continue;
      } else {
        String str = (-i * step).toInt().toString();
        _drawAxisTextText(canvas, str);
      }
      canvas.translate(0, -step);
    }
    canvas.restore();

    // x < 0的字
    canvas.save();
    for (int i = 0; i< size.height / 2 / step; i++) {
      if (i.isOdd || i == 0) {
        canvas.translate(-step, 0);
        continue;
      } else {
        String str = (-i * step).toInt().toString();
        _drawAxisTextText(canvas, str, isX: true);
      }
      canvas.translate(-step, 0);
    }
    canvas.restore();
  }

  _drawAxisTextText(Canvas canvas, String str, {bool isX = false}) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: str,
        style: TextStyle(
          fontSize: 11,
          color: Colors.green
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    Size size = textPainter.size;
    Offset offset = Offset.zero;

    if (isX == null) {
      offset = Offset(5, 5);
    } else if (isX) {
      offset = Offset(-size.width / 2, -size.height / 2 + 10);
    } else {
      offset = Offset(size.height / 2, -size.height + 5);
    }

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
