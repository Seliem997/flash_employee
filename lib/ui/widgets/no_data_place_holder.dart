import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class NoDataPlaceHolder extends StatelessWidget {
  const NoDataPlaceHolder({Key? key, this.useExpand = true, this.title})
      : super(key: key);
  final bool useExpand;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return useExpand
        ? Expanded(
            child: Container(
              alignment: Alignment.center,
              child: TextWidget(
                text: title ?? 'No Data Available',
                color: AppColor.grey,
              ),
            ),
          )
        : Center(
            child: TextWidget(
              text: title ?? 'No Data Available',
              color: AppColor.grey,
            ),
          );
  }
}
