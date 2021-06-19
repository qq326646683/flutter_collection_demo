import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/assets_util.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';
import 'package:flutter_collection_demo/util/extension/int_extension.dart';


enum ToastType {
  success,
  warning,
}

class ToastWidget extends StatelessWidget {
  final String? content;
  final ToastType? toastType;

  ToastWidget({this.toastType, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: S.getInstance()?.statusBarHeight),
        Container(
          width: 309.dp,
          height: 76.dp,
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
                  width: 20.dp,
                  height: 20.dp,
                ),
              ),
              Expanded(
                  child: Text(
                content ?? '',
                style: TextStyle(color: Color(0xff4B4B72), fontSize: 16.dp),
              ))
            ],
          ),
        )
      ],
    );
  }
}
