class Code {
  ///请求成功&业务成功
  static const CODE_ALL_SUCCESS = 666;
  ///网络错误
  static const STATUS_CODE_NETWORK_ERROR = -1;
  // http status code 错误
  static const CODE_REQUEST_ERROR = -100;
  ///网络超时
  static const STATUS_CODE_NETWORK_TIMEOUT = -2;
  //请求取消
  static const STATUS_CODE_NETWORK_CANCEL = -5;
  //上传失败
  static const STATUS_CODE_UPLOAD_FAILURE = -6;
  //下载失败
  static const STATUS_CODE_DOWNLOAD_FAILURE = -7;
  //Dio默认错误
  static const STATUS_CODE_DIO_ERROR = -7;



  // 业务异常码
  // token失效
  static const LOGICAL_ERROR_10003 = 10003;


  static errorHandleEunction(code, message, noTip) {
    switch (code) {
    /////////// 一定提示  ////////////
      case Code.LOGICAL_ERROR_10003:
        break;
      case Code.STATUS_CODE_UPLOAD_FAILURE:
        //上传失败
        break;

    ////////// 线上不提示Dio报错  //////////
      case Code.STATUS_CODE_DIO_ERROR:
        break;
    ////////// 按需提示 ////////////
      case Code.STATUS_CODE_DOWNLOAD_FAILURE:
        break;
      case Code.STATUS_CODE_NETWORK_ERROR:
        break;
      case Code.STATUS_CODE_NETWORK_TIMEOUT:
        break;
      default:
        break;
    }

    return code;

  }


}