import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/assets_util.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';

enum ToastType {
  success,
  warning,
}

class ToastWidget extends StatelessWidget {
  final String content;
  final ToastType toastType;

  ToastWidget({this.toastType, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: S().statusBarHeight),
        Container(
          width: S().w(309),
          height: S().w(76),
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [BoxShadow(color: Color(0x44000000), blurRadius: 10, offset: Offset(1, 2))],
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Image.asset(
                  toastType == ToastType.warning ? Assets.icon_toast_warning : Assets.icon_toast_success,
                  width: S().w(20),
                  height: S().w(20),
                ),
              ),
              Expanded(
                  child: Text(
                content ?? '',
                style: TextStyle(color: Color(0xff4B4B72), fontSize: S().w(16)),
              ))
            ],
          ),
        )
      ],
    );
  }
}
