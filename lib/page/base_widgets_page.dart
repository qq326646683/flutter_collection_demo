import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/loading_util.dart';
import 'package:flutter_collection_demo/util/overlay_util.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';
import 'package:flutter_collection_demo/util/snackbar_util.dart';
import 'package:flutter_collection_demo/util/toast_util.dart';
import 'package:flutter_collection_demo/widget/pop_confirm_widget.dart';

class BaseWidgetsPage extends StatefulWidget {
  static final String sName = "base_widgets";

  @override
  _BaseWidgetsPageState createState() => _BaseWidgetsPageState();
}

class _BaseWidgetsPageState extends State<BaseWidgetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基础组件'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              LoadingUtil.show();
              Future.delayed(Duration(seconds: 2), () {
                LoadingUtil.hide();
              });
            },
            title: Text('loading'),
          ),
          ListTile(
            onTap: () {
              ToastUtil.showSuccess("Success");
            },
            title: Text('toast'),
          ),
          ListTile(
            onTap: () async {
              await OverlayUtil.showPull(
                context,
                child: Container(
                  width: S().screenWidth,
                  height: S().screenHeight * 0.3,
                  child: Text('baahhhfsdf'),
                ),
              );
            },
            title: Text('pull'),
          ),
          ListTile(
            onTap: () async {
              int resultIndex = await OverlayUtil.showPop(
                  barrierDismissible: false,
                  child: PopConfirmWidget(
                    titleTxt: 'Allow Maestro to access y',
                    contentTxt: 'To enable this, please tap Settings below and activat} under App Permissions',
                    titleList: ['Not now', 'Settings'],
                  ));
              ToastUtil.showSuccess(resultIndex.toString());
            },
            title: Text('pop'),
          ),
          ListTile(
            title: Text('show snack bar'),
            onTap: () {
              SnackbarUtil.show(title: 'hehe');
            },
          ),
          ListTile(
            title: Text('show stick snack bar'),
            onTap: () {
              SnackbarUtil.show(
                title: 'show messages',
                autoDismiss: false,
                actionTitleList: ['Confirm', 'Cancel'],
                actionTapList: [
                  () {
                    ToastUtil.showSuccess('Confirm');
                  },
                  () {
                    ToastUtil.showWarning('Cancel');
                    SnackbarUtil.hide();
                  }
                ],
              );
            },
          ),
          ListTile(
            title: Text('change snack'),
            onTap: () {
              SnackbarUtil.changeTitle('hahaha');
            },
          ),
          ListTile(
            title: Text('hide snack bar'),
            onTap: () {
              SnackbarUtil.hide();
            },
          ),
        ],
      ),
    );
  }
}
