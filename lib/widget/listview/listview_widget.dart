import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/net/response_result.dart';
import 'package:flutter_collection_demo/util/assets_util.dart';
import 'package:flutter_collection_demo/util/time_util.dart';
import 'package:flutter_collection_demo/widget/listview/listview_loading.dart';
import 'package:flutter_collection_demo/widget/listview/place_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

typedef FetchCallBack = Future<ResponseResult<List<dynamic>>> Function(int page);

enum LoadDataStatus { Loading, Success, SuccessEmpty, Failure }

class ListViewWidget extends StatefulWidget {
  final IndexedWidgetBuilder buildItem;
  final int itemCount;
  final FetchCallBack fetchCallBack;
  final String emptyImg;
  final String emptyText;
  final bool firstRefresh;

  ListViewWidget({
    Key key,
    @required this.buildItem,
    @required this.itemCount,
    this.fetchCallBack,
    this.emptyImg = Assets.icon_logo_loading,
    this.emptyText = 'No Data',
    this.firstRefresh = true,
  }) : super(key: key);

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  EasyRefreshController _controller;
  ScrollController _scrollController;
  int page = 1;
  LoadDataStatus loadStatus;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    if (widget.firstRefresh) _onRefresh();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// load failure
    if (loadStatus == LoadDataStatus.Failure) {
      return PlaceWidget(
        onPress: _retry,
        text: "Please click and try again",
      );
    }

    /// first loading
    if (widget.itemCount == null || loadStatus == LoadDataStatus.Loading) {
      return ListViewLoading();
    }

    /// empty and nornal
    return EasyRefresh.custom(
      scrollController: _scrollController,
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      controller: _controller,
      emptyWidget: widget.itemCount == 0
          ? PlaceWidget(
              imgAsset: widget.emptyImg,
              text: widget.emptyText,
            )
          : null,
      header: PhoenixHeader(),
      footer: ClassicalFooter(),
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            widget.buildItem,
            childCount: widget.itemCount ?? 0,
          ),
        ),
      ],
    );
  }

  Future<void> _onRefresh() async {
    page = 1;
    ResponseResult response = await widget.fetchCallBack?.call(page);
    if (response.isSuccess) {
      _controller.finishRefresh(success: true);
      _controller.finishLoad(
        success: true,
        noMore: response.data.length < 10,
      );
      if (mounted)
        setState(() {
          loadStatus = LoadDataStatus.Success;
        });
    } else {
      _controller.finishRefresh(success: false);
      if (mounted)
        setState(() {
          loadStatus = LoadDataStatus.Failure;
        });
    }
  }

  Future<void> _retry() async {
    if (mounted)
      setState(() {
        loadStatus = LoadDataStatus.Loading;
      });
    page = 1;
    ResponseResult response = await widget.fetchCallBack?.call(page);
    if (response.isSuccess) {
      if (mounted)
        setState(() {
          loadStatus = LoadDataStatus.Success;
        });
    } else {
      if (mounted)
        setState(() {
          loadStatus = LoadDataStatus.Failure;
        });
    }
  }

  Future<void> _onLoad() async {
    page++;
    ResponseResult response = await widget.fetchCallBack?.call(page);
    if (response.isSuccess) {
      _controller.finishLoad(
        success: true,
        noMore: response.data.length < 10,
      );
    } else {
      _controller.finishLoad(success: false);
    }
  }
}
