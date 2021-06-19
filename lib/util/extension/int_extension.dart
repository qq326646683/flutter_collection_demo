import 'package:flutter_collection_demo/util/screen_util.dart';

extension IntExtension on int {
  double get dp {
    return S.getInstance()?.w(this.toDouble()) ?? 0;
  }

  double get hdp {
    return S.getInstance()?.h(this.toDouble()) ?? 0;
  }
}