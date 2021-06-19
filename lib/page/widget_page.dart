import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/page/base_widgets_page.dart';
import 'package:flutter_collection_demo/page/interactiveviewer_page.dart';
import 'package:flutter_collection_demo/page/listview_page.dart';
import 'package:flutter_collection_demo/page/loaddata_page.dart';
import 'package:flutter_collection_demo/util/common_util.dart';
import 'package:flutter_collection_demo/util/navigation/navigation_util.dart';
import 'package:flutter_collection_demo/util/toast_util.dart';
import 'package:flutter_collection_demo/widget/circular_icon.dart';
import 'package:flutter_collection_demo/widget/list_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class WidgetPage extends StatefulWidget {
  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: EasyRefresh.custom(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100.0,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text('组件'),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListItem(
                title: '基础组件',
                describe: 'loading/toast/pull/pop/snackbar封装',
                onPressed: () {
                  NavigationUtil.getInstance()?.pushNamed(BaseWidgetsPage.sName);
                },
                icon: CircularIcon(
                  bgColor: Theme.of(context).primaryColor,
                  icon: Icons.format_list_bulleted,
                ),
              ),
              ListItem(
                title: 'ClickButton',
                describe: '防止快速点击的Button: click_button.dart',
                onPressed: () {
                  CommonUtil.throttle( () {
                    ToastUtil.showSuccess('点击了');
                  });
                },
                icon: CircularIcon(
                  bgColor: Theme.of(context).primaryColor,
                  icon: Icons.view_array,
                ),
              ),
              ListItem(
                title: 'ListView',
                describe: '统一封装listview组件,兼容网络异常/无更多数据/空列表',
                onPressed: () {
                  NavigationUtil.getInstance()?.pushNamed(ListViewPage.sName);
                },
                icon: CircularIcon(
                  bgColor: Theme.of(context).primaryColor,
                  icon: Icons.inbox,
                ),
              ),
              ListItem(
                title: 'LoadData',
                describe: '统一封装LoadData组件，兼容网络异常',
                onPressed: () {
                  NavigationUtil.getInstance()?.pushNamed(LoadDataPage.sName);
                },
                icon: CircularIcon(
                  bgColor: Theme.of(context).primaryColor,
                  icon: Icons.view_agenda,
                ),
              ),
              ListItem(
                title: '图片视频预览',
                describe: 'interactiveviewer的封装,增强gallery',
                onPressed: () {
                  NavigationUtil.getInstance()?.pushNamed(InteractiveviewerPage.sName);

                },
                icon: CircularIcon(
                  bgColor: Theme.of(context).primaryColor,
                  icon: Icons.format_line_spacing,
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
