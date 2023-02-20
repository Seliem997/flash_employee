import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class RequiredLabel extends StatelessWidget {
  const RequiredLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 2.w, right: 2.w, top: 2),
      child: Text('required',
          style: TextStyle(color: Colors.red[800], fontSize: 12)),
    );
  }
}
