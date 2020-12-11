import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/common_util.dart';
import 'package:flutter_collection_demo/widget/loading_widget.dart';

class LoadingUtil {
  static bool isShowing = false;

  static OverlayEntry entry = OverlayEntry(builder: (BuildContext context) {
    return LoadingWidget();
  });

  static show() {
    if (isShowing == false) {
      CommonUtil.navigatorState.overlay.insert(entry);
      isShowing = true;
    }
  }

  static hide() {
    if (isShowing == true) {
      entry.remove();
      isShowing = false;
    }
  }
}
