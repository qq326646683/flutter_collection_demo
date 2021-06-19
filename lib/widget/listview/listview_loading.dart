import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ListViewLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: S.getInstance()?.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60,
              child: SpinKitSquareCircle(
                color: Colors.orange,
                size: 20,
              ),
            ),
            SizedBox(height: 10,),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
