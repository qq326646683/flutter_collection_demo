import 'package:flutter_collection_demo/net/code.dart';

class ResponseResult<T> {
  T? data;
  int? statusCode;
  int? code;
  String? msg;
  dynamic sourceData;

  ResponseResult();

  ResponseResult.from(this.statusCode, {this.data, this.code, this.msg});

  void setData(int? statusCode, dynamic? sourceData, T? data, int? code, String? msg) {
    this.statusCode = statusCode;
    this.sourceData = sourceData;
    this.data = data;
    this.code = code;
    this.msg = msg;
  }

  @override
  String toString() {
    return 'ResponseResult{data: $data, statusCode: $statusCode, code: $code, msg: $msg, sourceData: $sourceData}';
  }

  /// 业务成功
  bool get isSuccess => code == Code.CODE_ALL_SUCCESS;


}