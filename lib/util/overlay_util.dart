import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_collection_demo/util/common_util.dart';
import 'package:flutter_collection_demo/widget/click_button.dart';

class OverlayUtil {
  static bool isPopShowing = false;
  static late OverlayEntry popEntry;
  static Completer<int>? popCompleter;

  static Future<int>? showPop({
    required Widget child,
    barrierDismissible = true,
    barrierColor = const Color(0x99000000),
  }) {
    popCompleter = Completer<int>();
    popEntry = OverlayEntry(builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          if (barrierDismissible) {
            return true;
          }
          return false;
        },
        child: ClickButton(
          onTap: () {
            if (barrierDismissible) {
              hidePop();
            }
          },
          child: Material(
            color: barrierColor,
            child: Dialog(
              insetAnimationDuration: Duration(seconds: 1),
              child: child,
              insetPadding: EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
            ),
          ),
        ),
      );
    });
    CommonUtil.navigatorState?.overlay?.insert(popEntry);
    isPopShowing = true;
    return popCompleter?.future;
  }

  static hidePop() {
    if (isPopShowing == true) {
      popEntry.remove();
      isPopShowing = false;
    }
  }

  static showPull<T>(context, {required Widget child, Color? barrierColor, bool showTop = true}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      barrierColor: barrierColor,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              showTop
                  ? Container(
                      width: 50,
                      height: 4,
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Color(0x99000000),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(2),
                          right: Radius.circular(2),
                        ),
                      ),
                    )
                  : Container(
                      width: 50,
                      height: 4,
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                    ),
              child,
            ],
          ),
        );
      },
    );
  }

  static OverlayEntry showOverlay({required Widget child, barrierDismissible = true, barrierColor = const Color(0x99000000), Function? dissmissCallBack}) {
    OverlayEntry? entry;
    entry = OverlayEntry(builder: (_) {
      return Stack(
        children: <Widget>[
          ClickButton(
            onTap: () {
              if (barrierDismissible) {
                entry?.remove();
                dissmissCallBack?.call();
              }
            },
            child: Container(
              color: barrierColor,
            ),
          ),
          child,
        ],
      );
    });

    CommonUtil.navigatorState?.overlay?.insert(entry);
    return entry;
  }
}
