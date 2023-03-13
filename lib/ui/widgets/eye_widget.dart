import 'package:flash_employee/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EyeWidget extends StatelessWidget {
  const EyeWidget({Key? key, required this.onTap, required this.show})
      : super(key: key);

  final Function onTap;

  final bool show;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          'assets/images/eye.png',
          color: !show ? AppColor.primary : null,
        ),
      ),
    );
  }
}
