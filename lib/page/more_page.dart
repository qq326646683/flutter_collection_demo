import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/toast_util.dart';
import 'package:flutter_collection_demo/widget/circular_icon.dart';
import 'package:flutter_collection_demo/widget/list_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> with AutomaticKeepAliveClientMixin{
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
              title: Text('更多'),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListItem(
                title: 'more',
                describe: 'more describe',
                onPressed: () {
                  ToastUtil.showSuccess('敬请期待');
                },
                icon: CircularIcon(
                  bgColor: Theme.of(context).primaryColor,
                  icon: Icons.format_list_bulleted,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
