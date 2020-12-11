import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/widget/toast_widget.dart';
import 'package:oktoast/oktoast.dart';

const int shortToastDuration = 2000;
const int longToastDuration = 3500;

class ToastUtil {
  static ToastFuture showWarning(String msg, {bool isShort = false}) {
    return showToastWidget(
      ToastWidget(
        content: msg,
        toastType: ToastType.warning,
      ),
      duration: Duration(milliseconds: isShort ? shortToastDuration : longToastDuration),
      animationBuilder: _AnimBuilder(),
    );
  }

  static ToastFuture showSuccess(String msg, {bool isShort = true}) {
    return showToastWidget(
      ToastWidget(
        content: msg,
        toastType: ToastType.success,
      ),
      duration: Duration(milliseconds: isShort ? shortToastDuration : longToastDuration),
      animationBuilder: _AnimBuilder(),
    );
  }
}

class _AnimBuilder extends BaseAnimationBuilder {
  @override
  Widget buildWidget(
    BuildContext context,
    Widget child,
    AnimationController controller,
    double percent,
  ) {
    final opacity = min(1.0, percent + 0.2);
    final offset = -(1 - percent) * 20;
    return Opacity(
      opacity: opacity,
      child: Transform.translate(
        child: child,
        offset: Offset(0, offset),
      ),
    );
  }
}
