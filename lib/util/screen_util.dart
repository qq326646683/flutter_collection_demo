import 'package:flutter/material.dart';

class ScreenUtil {
  static bool isHorizontal(BuildContext context) => MediaQuery.of(context).size.width / MediaQuery.of(context).size.height > 1;

  static bool isVertical(BuildContext context) => MediaQuery.of(context).size.width / MediaQuery.of(context).size.height < 1;

  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
}