import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/model/banner_model.dart';
import 'package:flutter_collection_demo/net/http_manager.dart';
import 'package:flutter_collection_demo/net/response_result.dart';
import 'package:flutter_collection_demo/util/overlay_util.dart';
import 'package:flutter_collection_demo/util/toast_util.dart';
import 'package:flutter_collection_demo/widget/circular_icon.dart';
import 'package:flutter_collection_demo/widget/click_button.dart';
import 'package:flutter_collection_demo/widget/list_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_vap/flutter_vap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/toast_util.dart';

class FunctionPage extends StatefulWidget {
  @override
  _FunctionPageState createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          EasyRefresh.custom(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 100.0,
                pinned: true,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text('功能'),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  ListItem(
                    title: '自动生成assets引用文件',
                    describe: '方便开发,避免代码冲突: test/asset_generate.dart',
                    onPressed: () {
                      ToastUtil.showSuccess('运行test/asset_generate.dart');
                    },
                    icon: CircularIcon(
                      bgColor: Theme
                          .of(context)
                          .primaryColor,
                      icon: Icons.format_list_bulleted,
                    ),
                  ),
                  ListItem(
                    title: '屏幕工具',
                    describe: '屏幕适配，取状态栏高度/屏幕宽高等',
                    onPressed: () {
                      ToastUtil.showSuccess('查阅util/screen_util.dart');
                    },
                    icon: CircularIcon(
                      bgColor: Theme
                          .of(context)
                          .primaryColor,
                      icon: Icons.format_list_bulleted,
                    ),
                  ),
                  ListItem(
                    title: '路由管理',
                    describe: '无context跳转/获取路由栈信息/监听路由变化/监听页面焦点',
                    onPressed: () async {
                      const url = 'https://juejin.cn/post/6844903877221810184';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    icon: CircularIcon(
                      bgColor: Theme
                          .of(context)
                          .primaryColor,
                      icon: Icons.format_list_bulleted,
                    ),
                  ),
                  ListItem(
                    title: '网络请求json解析',
                    describe: 'dio的封装',
                    onPressed: () async {
                      ResponseResult<List<BannerModel>> response = await HttpManager.netFetch<BannerModel>('banner/json', NetMethod.GET, isList: true);
                      if (response.isSuccess) {
                        OverlayUtil.showPull(context,
                            child: Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  children: [for (BannerModel banner in response.data) ClickButton(
                                    onTap: () async {
                                      if (await canLaunch(banner.url)) {
                                        await launch(banner.url);
                                      } else {
                                        throw 'Could not launch ${banner.url}';
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(imageUrl: banner.imagePath, width: 300, height: 130,),
                                        Text(banner.title),
                                      ],
                                    ),
                                  )],
                                ),
                              ),
                            ));
                      }
                    },
                    icon: CircularIcon(
                      bgColor: Theme
                          .of(context)
                          .primaryColor,
                      icon: Icons.format_list_bulleted,
                    ),
                  ),
                  ListItem(
                    title: '队列任务',
                    describe: '多处调用耗时任务,将其队列执行',
                    onPressed: () async {
                      print("加入队列-net, taskNo: 1");
                      QueueUtil.get("net").addTask(() {
                        return _doFuture("net", 1);
                      });
                      print("加入队列-net, taskNo: 2");
                      QueueUtil.get("net").addTask(() {
                        return _doFuture("net", 2);
                      });
                      // print("加入队列-local, taskNo: 1");
                      // QueueUtil.get("local").addTask(() {
                      //   return _doFuture("local", 1);
                      // });
                    },
                    icon: CircularIcon(
                      bgColor: Theme
                          .of(context)
                          .primaryColor,
                      icon: Icons.format_list_bulleted,
                    ),
                  ),
                  ListItem(
                    title: '取消队列任务',
                    describe: '多处调用耗时任务,将其队列执行',
                    onPressed: () async {
                      QueueUtil.get("net").cancelTask();
                    },
                    icon: CircularIcon(
                      bgColor: Theme
                          .of(context)
                          .primaryColor,
                      icon: Icons.format_list_bulleted,
                    ),
                  ),
                  ListItem(
                    title: '播放vap',
                    describe: '透明视频动画',
                    onPressed: () async {
                      VapController.playAsset("assets/video/vap.mp4");
                    },
                    icon: CircularIcon(
                      bgColor: Theme
                          .of(context)
                          .primaryColor,
                      icon: Icons.format_list_bulleted,
                    ),
                  )
                ]),
              ),
            ],
          ),
          IgnorePointer(
            // VapView can set the width and height through the outer package Container() to limit the width and height of the pop-up video
            child: VapView(),
          ),
        ],
      ),
    );
  }

  Future _doFuture(String queueName, int taskNo) {
    return Future.delayed(Duration(seconds: 2), () {
      ToastUtil.showSuccess("任务$queueName-$taskNo完成");
      print("任务完成  queueName: $queueName, taskNo: $taskNo");
    });
  }

  @override
  bool get wantKeepAlive => true;
}
