import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/common_util.dart';
import 'package:flutter_collection_demo/util/time_util.dart';
import 'package:flutter_collection_demo/widget/snackbar_widget.dart';

// 不能低于300ms
const int snackbarDuration = 2500;

class SnackbarUtil {
  static OverlayEntry? entry;
  static GlobalKey<SnackbarWidgetState>? key;

  static show({required String title, bool autoDismiss = true, List<String> actionTitleList = const [], List<VoidCallback> actionTapList = const []}) async {
    if (key != null && entry != null) return;

    key = new GlobalKey<SnackbarWidgetState>();

    entry = OverlayEntry(builder: (BuildContext context) {
      return SnackbarWidget(key: key!, title: title, autoDismiss: autoDismiss, actionTitleList: actionTitleList, actionTapList: actionTapList);
    });

    /// 插入overlay
    CommonUtil.navigatorState?.overlay?.insert(entry!);

    /// 动画展示
    Future.delayed(Duration(milliseconds: 100), () => key?.currentState?.show());

    /// 自动隐藏
    if (autoDismiss == true) {
      Future.delayed(Duration(milliseconds: snackbarDuration), () => hide());
    }
  }

  static changeTitle(String title) {
    key?.currentState?.changeTitle(title);
  }

  static hide() async {
    if (key != null && entry != null) {
      /// 动画隐藏
      key?.currentState?.hide();
      await TimeUtil.sleep(200);

      /// 移除overlay
      entry?.remove();

      key = null;
      entry = null;
    }
  }
}
