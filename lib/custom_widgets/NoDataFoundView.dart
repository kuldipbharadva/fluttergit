import 'package:flutter/material.dart';
import 'package:flutter_learn_app/utilities/AppColor.dart';

class NoDataFoundView extends StatelessWidget {

  final String msg;

  const NoDataFoundView({Key key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          child: Text(
              msg,
              style:
              TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color:AppColor.appGrey,
              )),
        ));
  }
}
