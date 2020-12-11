import 'package:flutter/material.dart';
import 'package:flutter_collection_demo/util/screen_util.dart';
import 'package:flutter_collection_demo/widget/click_button.dart';

class SnackbarWidget extends StatefulWidget {
  final String title;
  final bool autoDismiss;
  final List<String> actionTitleList;
  final List<VoidCallback> actionTapList;

  SnackbarWidget({Key key, this.title = '', this.autoDismiss, this.actionTitleList, this.actionTapList}) : super(key: key);

  @override
  SnackbarWidgetState createState() => SnackbarWidgetState();
}

class SnackbarWidgetState extends State<SnackbarWidget> {
  double height = 0;
  String title;

  @override
  void initState() {
    super.initState();
    title = widget.title;
  }

  show() {
    if (mounted)
      setState(() {
        height = S().w(100) + S().bottomBarHeight;
      });
  }

  hide() {
    if (mounted) {
      try {
        setState(() {
          height = 0;
        });
      } catch (e) {
      }
    }
  }

  changeTitle(newTitle) {
    if (mounted)
      setState(() {
        title = newTitle;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        AnimatedContainer(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Color(0xcc000000),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          duration: Duration(milliseconds: 200),
          width: S().screenWidth,
          height: height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: S().w(20)),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title ?? '',
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: S().w(18.0),
                      color: Color(0xff30344D),
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                ...widget.actionTitleList.map((e) =>
                    ClickButton(
                      onTap: widget.actionTapList[widget.actionTitleList.indexOf(e)],
                      child: Container(
                        width: S().w(92),
                        height: S().w(52),
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.5, color: Color(0xffC4C4C4)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x16000000),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ]
                        ),
                        child: Text(e, style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: S().w(16.0),
                          color: Color(0xff30344D),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),),
                      ),
                    )
                ).toList(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
