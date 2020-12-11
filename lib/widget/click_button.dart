import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/common_util.dart';

class ClickButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final HitTestBehavior behavior;
  final GestureLongPressCallback onLongPress;
  final int durationTime;


  ClickButton({Key key, this.child, this.onTap, this.onLongPress, this.behavior = HitTestBehavior.opaque, this.durationTime = CommonUtil.deFaultDurationTime}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: behavior,
      child: child,
      onTap: () => CommonUtil.throttle(onTap, durationTime: durationTime),
      onLongPress: onLongPress,
    );
  }
}
