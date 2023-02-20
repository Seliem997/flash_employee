import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class SmallIconRounded extends StatelessWidget {
  const SmallIconRounded({
    Key? key,
    required this.iconData,
  }) : super(key: key);
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: AppColor.secondary, shape: BoxShape.circle),
      padding: const EdgeInsets.all(7),
      child: Icon(iconData, color: AppColor.white, size: 15),
    );
  }
}
