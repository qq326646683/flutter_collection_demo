import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_collection_demo/net/response_result.dart';
import 'package:flutter_collection_demo/util/toast_util.dart';

import 'code.dart';
import 'model_factory.dart';

class NetMethod {
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String DELETE = 'delete';
}

class HttpManager {
  static String TAG = 'HttpManager';
  static Dio dio = new Dio(BaseOptions(connectTimeout: 10000));
  static String _token;

  static setToken(String t) {
    _token = t;
  }

  static Future<ResponseResult> netFetch<T>(url, String method, {noTip = false, bool isList = false, Map queryParameters, dynamic postParams}) async {
    ResponseResult responseResult = isList ? new ResponseResult<List<T>>() : new ResponseResult<T>();

    /// 无网络
    ConnectivityResult connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      responseResult.statusCode = Code.errorHandleEunction(Code.STATUS_CODE_NETWORK_ERROR, "", noTip);
      return responseResult;
    }
    Options option = new Options(method: method);
    Response response;

    String token = await getToken();
    if (token != null) option.headers = {'Authorization': 'Bearer $token'};
    try {
      response = await dio.request('https://www.wanandroid.com/' + url, data: postParams, options: option, queryParameters: queryParameters);
      if (_isHttpSuccess(response.statusCode)) {
        /// 业务正常
        if (response.data['errorCode'] == 0) {
          var needParseData = response.data['data'];
          if (isList) {
            responseResult.setData(response.statusCode, response.data, ModelFactory.createModelList<T>(needParseData), Code.CODE_ALL_SUCCESS, response.data['msg']);
          } else {
            T data;
            if (T == dynamic) {
              data = needParseData;
            } else {
              data = ModelFactory.createModel<T>(needParseData);
            }
            responseResult.setData(response.statusCode, response.data, data, Code.CODE_ALL_SUCCESS, null);
          }
        } else {
          /// 业务异常
          if (response.data['code'] == Code.LOGICAL_ERROR_10003) {
            responseResult.setData(Code.errorHandleEunction(Code.LOGICAL_ERROR_10003, '', noTip), response.data, null, response.data['errorCode'], response.data['errorMsg']);
          } else {
            responseResult.setData(response.statusCode, response.data, null, response.data['errorCode'], response.data['errorMsg']);
          }
          if (!noTip) ToastUtil.showWarning(responseResult.msg);
        }
      } else {
        responseResult.statusCode = response.statusCode;
        Code.errorHandleEunction(response.statusCode, "", noTip);
        responseResult.code = Code.CODE_REQUEST_ERROR;
      }
    } on DioError catch (e) {
      if (e.response != null) responseResult.sourceData = e.response.data;
      int statusCode = Code.STATUS_CODE_DIO_ERROR;
      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.SEND_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        statusCode = Code.STATUS_CODE_NETWORK_TIMEOUT;
      } else if (e.type == DioErrorType.CANCEL) {
        statusCode = Code.STATUS_CODE_NETWORK_CANCEL;
      }
      if (e.response != null && e.response.statusCode != null) {
        statusCode = e.response.statusCode;
      }
      responseResult.statusCode = Code.errorHandleEunction(statusCode, "", noTip);
      responseResult.code = Code.CODE_REQUEST_ERROR;
    }
    return responseResult;
  }

  static bool _isHttpSuccess(statusCode) {
    return statusCode == 200 || statusCode == 201;
  }

  static Future<String> getToken() async {
    if (_token == null) {
      String spToken = '';//await StorageUtil.getInstance().get(Const.TOKEN_KEY);
      if (spToken != null) {
        _token = spToken;
      }
    }
    return _token;
  }

  static clearToken() {
    _token = null;
    // StorageUtil.getInstance().remove(Const.TOKEN_KEY);
  }

}
