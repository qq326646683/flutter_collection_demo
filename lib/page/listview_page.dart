import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/net/code.dart';
import 'package:flutter_collection_demo/net/response_result.dart';
import 'package:flutter_collection_demo/util/loading_util.dart';
import 'package:flutter_collection_demo/util/time_util.dart';
import 'package:flutter_collection_demo/util/toast_util.dart';
import 'package:flutter_collection_demo/widget/listview/listview_widget.dart';

class ListViewPage extends StatefulWidget {
  static final String sName = "listview";

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  List<int>? dataList;

  String currentState = 'success'; // 'error'\'no more'\'empty'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView封装'),
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
              ),
              const PopupMenuItem<String>(
                value: 'no more',
                child: Text('no more'),
              ),
              const PopupMenuItem<String>(
                value: 'empty',
                child: Text('empty'),
              ),
            ],
          ),
        ],
      ),
      body: ListViewWidget(
        fetchCallBack: getData,
        buildItem: (_, i) {
          return Container(
            height: 90,
            child: Center(
              child: Text(i.toString()),
            ),
          );
        },
        itemCount: dataList?.length,
      ),
    );
  }

  /// 下面代码为service代码，实际开发中应写在xxx_service.dart, 数据用redux或provider管理
  Future<ResponseResult<List<int>>> getData(int page) async {
    ResponseResult<List<int>> response = await fetchList(page);
    if (response.isSuccess == true) {
      if (page == 1) {
        dataList = response.data;
      } else {
        dataList?.addAll(response.data!);
      }
      setState(() {});
    }
    return response;
  }

  /// 模拟网络层Dao,实际开发中应写在xxx_dao.dart
  Future<ResponseResult<List<int>>> fetchList(int page) async {
    await TimeUtil.sleep(1000);
    ResponseResult<List<int>> response = ResponseResult<List<int>>.from(200, data: List.generate(10, (index) => (page - 1) * 10 + index), code: Code.CODE_ALL_SUCCESS);
    if (currentState == 'success') {
      response = ResponseResult<List<int>>.from(200, data: List.generate(10, (index) => (page - 1) * 10 + index), code: Code.CODE_ALL_SUCCESS);
    } else if (currentState == 'error') {
      response = ResponseResult<List<int>>.from(400, msg: '请求失败', code: Code.CODE_REQUEST_ERROR);
    } else if (currentState == 'no more') {
      response = ResponseResult<List<int>>.from(200, data: List.generate(5, (index) => (page - 1) * 10 + index), code: Code.CODE_ALL_SUCCESS);
    } else if (currentState == 'empty') {
      response = ResponseResult<List<int>>.from(200, data: List.generate(0, (index) => (page - 1) * 10 + index), code: Code.CODE_ALL_SUCCESS);
    }
    return response;
  }
}
