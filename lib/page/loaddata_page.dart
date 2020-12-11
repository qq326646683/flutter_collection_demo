import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/net/code.dart';
import 'package:flutter_collection_demo/net/response_result.dart';
import 'package:flutter_collection_demo/util/loading_util.dart';
import 'package:flutter_collection_demo/util/time_util.dart';
import 'package:flutter_collection_demo/util/toast_util.dart';
import 'package:flutter_collection_demo/widget/listview/listview_widget.dart';
import 'package:flutter_collection_demo/widget/loaddata_widget.dart';

class LoadDataPage extends StatefulWidget {
  static final String sName = "loaddata";

  @override
  _LoadDataPageState createState() => _LoadDataPageState();
}

class _LoadDataPageState extends State<LoadDataPage> {
  String data;

  String currentState = 'error'; // 'error'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('普通的请求页面'),
        backgroundColor: Colors.white,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                currentState = value;
              });
              if (value == 'error') {
                ToastUtil.showSuccess('下拉刷新,上拉加载 测试网络异常');
              } else if (value == 'no more') {
                ToastUtil.showSuccess('上拉加载 测试无更多数据');
              } else if (value == 'empty') {
                ToastUtil.showSuccess('下拉刷新 测试无数据');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              const PopupMenuItem<String>(
                value: 'success',
                child: Text('success'),
              ),
              const PopupMenuItem<String>(
                value: 'error',
                child: Text('error'),
              )
            ],
          ),
        ],
      ),
      body: LoadDataWidget(
        loadData: getData,
        child: Text(data ?? ''),
      ),
    );
  }

  /// 下面代码为service代码，实际开发中应写在xxx_service.dart, 数据用redux或provider管理
  Future<ResponseResult<String>> getData() async {
    ResponseResult response = await fetchData();
    if (response.isSuccess) {
      setState(() {
        data = response.data;
      });
    }
    return response;
  }

  /// 模拟网络层Dao,实际开发中应写在xxx_dao.dart
  Future<ResponseResult<String>> fetchData() async {
    await TimeUtil.sleep(1000);
    ResponseResult response;
    if (currentState == 'success') {
      response = ResponseResult<String>.from(200, data: 'userInfo:{name: haha}', code: Code.CODE_ALL_SUCCESS);
    } else if (currentState == 'error') {
      response = ResponseResult<String>.from(400, msg: '请求失败', code: Code.CODE_REQUEST_ERROR);
    }
    return response;
  }
}
