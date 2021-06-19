
import 'package:flutter_collection_demo/util/screen_util.dart';

extension DoubleExtension on double {
  double get dp {
    return S.getInstance()?.w(this) ?? 0;
  }

  double get hdp {
    return S.getInstance()?.h(this) ?? 0;
  }
}