import 'package:flash_employee/ui/widgets/spaces.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../utils/colors.dart';
import 'custom_container.dart';

class RequiredLabel extends StatelessWidget {
  const RequiredLabel({
    Key? key,
    this.condition = false,
  }) : super(key: key);

  final bool condition;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: condition,
      child: CustomContainer(
        backgroundColor: AppColor.transparent,
        borderColorDark: Colors.transparent,
        margin: onlyEdgeInsets(top: 5),
        child: Row(
          children: [
            const Icon(Icons.cancel_outlined, size: 15, color: Colors.red),
            horizontalSpace(5),
            const TextWidget(text: "Required", textSize: 12, color: Colors.red)
          ],
        ),
      ),
    );
  }
}
