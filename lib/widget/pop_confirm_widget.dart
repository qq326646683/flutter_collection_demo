import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/overlay_util.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';
import 'package:flutter_collection_demo/widget/click_button.dart';
import 'package:flutter_collection_demo/util/extension/int_extension.dart';


class PopConfirmWidget extends StatelessWidget {
  String? titleTxt;
  String? contentTxt;
  List<String> titleList;
  TextStyle titleStyle;
  List<BoxShadow> buttonShadow;
  bool alwayShow;
  ValueChanged? onClickIndex;
  bool showCloseIcon;

  PopConfirmWidget({this.titleTxt, this.contentTxt, required this.titleList, this.alwayShow = false, this.onClickIndex, this.showCloseIcon = false, titleStyle, buttonShadow})
      : this.titleStyle = titleStyle ??
            TextStyle(
              fontSize: 20.dp,
              fontWeight: FontWeight.w500,
            ),
        this.buttonShadow = buttonShadow ?? [BoxShadow(color: Color(0x44000000), blurRadius: 5, offset: Offset(0, 2))];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 26.dp, right: 27.dp, top: 22.dp, bottom: 38.dp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              titleTxt != null
                  ? Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(bottom: 17.dp),
                      child: Text(
                        titleTxt!,
                        style: titleStyle,
                      ),
                    )
                  : SizedBox(),
              contentTxt != null
                  ? Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(bottom: 25.dp),
                      child: Text(
                        contentTxt!,
                        style: TextStyle(
                          color: Color(0xFF8D8D8D),
                          fontSize: 14.dp,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    )
                  : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: titleList.map((String titleStr) {
                  int index = titleList.indexOf(titleStr);
                  bool isLast = index == titleList.length - 1;
                  return ClickButton(
                    onTap: () {
                      OverlayUtil.popCompleter?.complete(index);
                      OverlayUtil.popCompleter = null;
                      onClickIndex?.call(index);
                      if (alwayShow) {
                        return;
                      }
                      OverlayUtil.hidePop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 120.dp,
                      height: 52.dp,
                      decoration: BoxDecoration(
                        color: isLast ? Color(0xFFCE5431) : Colors.white,
                        border: isLast ? null : Border.all(color: Color(0xffD2D2D2), width: 1),
                        boxShadow: buttonShadow,
                      ),
                      child: Text(
                        titleStr,
                        style: isLast
                            ? TextStyle(
                                color: Colors.white,
                                fontSize: 18.dp,
                              )
                            : TextStyle(
                                color: Color(0xff30344D),
                                fontSize: 18.dp,
                              ),
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
        if (showCloseIcon)
          Positioned(
            right: 17.dp,
            top: 17.dp,
            child: ClickButton(
              child: Icon(
                Icons.close,
                color: Color(0xff231f20),
              ),
              onTap: () {
                OverlayUtil.hidePop();
              },
            ),
          )
      ],
    );
  }
}
