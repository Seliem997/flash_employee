import 'package:flash_employee/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../utils/font_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: CustomContainer(
        width: 321,
        height: 233,
        radiusCircular: 12,
        padding: symmetricEdgeInsets(horizontal: 24,vertical: 38),
        child: Column(
          children: [
            TextWidget(
              text: 'Logout',
              fontWeight: MyFontWeight.bold,
              textSize: MyFontSize.size18,
              color: const Color(0xFFF24955),
            ),
            verticalSpace(24),
            TextWidget(
              text: 'Are you sure you want to logout',
              fontWeight: MyFontWeight.semiBold,
              textSize: MyFontSize.size20,
              color: const Color(0xFF2D2D2D),
            ),
            verticalSpace(32),
            Row(
              children: [
                DefaultButton(
                  text: 'Cancel and back',
                  fontWeight: MyFontWeight.bold,
                  fontSize: MyFontSize.size14,
                  height: 33,
                  width: 155,
                  backgroundColor: const Color(0xFF616161),
                  onPressed: (){Navigator.pop(context);},
                ),
                horizontalSpace(16),
                DefaultButton(
                  text: 'Logout',
                  fontWeight: MyFontWeight.bold,
                  fontSize: MyFontSize.size14,
                  height: 33,
                  width: 96,
                  backgroundColor: const Color(0xFFB85F66),
                  onPressed: (){Navigator.pop(context);},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}