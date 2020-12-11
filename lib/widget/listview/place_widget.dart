import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/assets_util.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';
import 'package:flutter_collection_demo/widget/click_button.dart';

class PlaceWidget extends StatelessWidget {
  final String imgAsset;
  final String text;
  final VoidCallback onPress;

  //style
  double containH;
  Size placeImgSize;
  TextStyle textStyle;

  PlaceWidget({this.imgAsset = Assets.icon_logo_loading, this.text = 'No Data', this.onPress, this.containH, this.placeImgSize, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClickButton(
        onTap: () {
          onPress?.call();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                imgAsset,
                width: placeImgSize?.width ?? _Style.placeImgW,
                height: placeImgSize?.height ?? _Style.placeImgW,
              ),
              SizedBox(
                height: _Style.imageSpace,
              ),
              Text(text, style: textStyle ?? TextStyle(color: Color(0xffA19FBA), fontSize: S().w(20)))
            ],
          ),
        ),
      ),
    );
  }
}

class _Style {
  static double placeImgW = S().w(58.0);
  static double imageSpace = S().w(15.0);
}
