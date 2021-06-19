import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double headerContainerH = 44;
    return Column(
      children: <Widget>[
        SizedBox(
          height: (S.getInstance()?.statusBarHeight ?? 0) + headerContainerH,
        ),
        Expanded(
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: (S.getInstance()?.statusBarHeight ?? 0) + headerContainerH / 2),
            child: Container(
              width: 90,
              height: 90,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Color(0xcc000000), borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 30,
                    child: SpinKitSquareCircle(
                      color: Colors.orange,
                      size: 18,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      'Loading',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
