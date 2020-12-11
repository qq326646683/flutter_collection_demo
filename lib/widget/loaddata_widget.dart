import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/net/response_result.dart';
import 'package:flutter_collection_demo/widget/listview/listview_loading.dart';
import 'package:flutter_collection_demo/widget/listview/place_widget.dart';

enum LoadDataStatus { Loading, Success, SuccessEmpty, Failure }

class LoadDataWidget extends StatefulWidget {
  final Widget child;
  final Function loadData;
  final bool needDelay;
  final LoadDataStatus newDataStatus;

  LoadDataWidget({Key key, @required this.loadData, @required this.child, this.needDelay = false, this.newDataStatus}) : super(key: key);

  @override
  LoadDataWidgetState createState() => LoadDataWidgetState();
}

class LoadDataWidgetState extends State<LoadDataWidget> {
  LoadDataStatus loadStatus = LoadDataStatus.Loading;

  @override
  void initState() {
    super.initState();
    if (widget.needDelay) {
      Future.delayed(Duration(milliseconds: 200), () => _load());
    } else {
      _load();
    }
  }

  @override
  void didUpdateWidget(LoadDataWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.newDataStatus != oldWidget.newDataStatus) {
      if (mounted)
        setState(() {
          loadStatus = widget.newDataStatus;
        });
    }
  }

  _load() async {
    if (mounted)
      setState(() {
        loadStatus = LoadDataStatus.Loading;
      });

    ResponseResult response = await widget.loadData?.call();
    if (response.isSuccess) {
      if (response.data is List && (response.data as List).isEmpty) {
        loadStatus = LoadDataStatus.SuccessEmpty;
      } else {
        loadStatus = LoadDataStatus.Success;
      }
    } else {
      loadStatus = LoadDataStatus.Failure;
    }
    if (mounted) setState(() {});
  }

  setLoadStatus(LoadDataStatus status) {
    if (mounted)
      setState(() {
        loadStatus = loadStatus;
      });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (loadStatus) {
      case LoadDataStatus.Loading:
        body = ListViewLoading();
        break;
      case LoadDataStatus.SuccessEmpty:
        body = PlaceWidget();
        break;
      case LoadDataStatus.Success:
        body = widget.child;
        break;
      case LoadDataStatus.Failure:
        body = PlaceWidget(
          onPress: _load,
          text: "Please click and try again",
        );
        break;
    }
    return body;
  }
}
