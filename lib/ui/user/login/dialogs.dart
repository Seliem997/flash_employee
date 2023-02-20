import 'package:flash_employee/ui/widgets/custom_button.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flash_employee/utils/colors.dart';
import 'package:flash_employee/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/custom_container.dart';
import '../../widgets/spaces.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: CustomContainer(
        width: 321,
        height: 340,
        radiusCircular: 12,
        padding: symmetricEdgeInsets(horizontal: 24,vertical: 38),
        child: Column(
          children: [
            TextWidget(
              text: 'Forgot password',
              fontWeight: MyFontWeight.bold,
              textSize: MyFontSize.size17,
            ),
            verticalSpace(35),
            TextWidget(
              text: 'Contact your direct Manager ',
              fontWeight: MyFontWeight.medium,
              textSize: MyFontSize.size15,
              color: const Color(0xFF3F3F3F),
            ),
            verticalSpace(16),
            Row(
                children: [
                  SvgPicture.asset('assets/svg/telephone.svg'),
                  horizontalSpace(27),
                  SvgPicture.asset('assets/svg/whatsapp.svg'),
                ]
            ),
            verticalSpace(24),
            DefaultButton(
              text: 'OK',
              fontWeight: MyFontWeight.bold,
              fontSize: MyFontSize.size16,
              height: 32,
              width: 225,
              onPressed: (){Navigator.pop(context);},
            ),
          ],
        ),
      ),
    );
  }
}


class ProblemSigning extends StatelessWidget {
  const ProblemSigning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: CustomContainer(
        width: 321,
        height: 203,
        radiusCircular: 12,
        padding: symmetricEdgeInsets(horizontal: 10,vertical: 20),
        child: Column(
          children: [
            TextWidget(
              text: 'Problem Signing',
              fontWeight: MyFontWeight.bold,
              textSize: MyFontSize.size17,
            ),
            verticalSpace(23),
            TextWidget(
              text: 'Contact your direct Manager ',
              fontWeight: MyFontWeight.medium,
              textSize: MyFontSize.size15,
              color: const Color(0xFF3F3F3F),
            ),
            verticalSpace(16),
            Row(
              children: [
                SvgPicture.asset('assets/svg/telephone.svg'),
                horizontalSpace(27),
                SvgPicture.asset('assets/svg/whatsapp.svg'),
              ]
            ),
            verticalSpace(24),
            DefaultButton(
              text: 'OK',
              fontWeight: MyFontWeight.bold,
              fontSize: MyFontSize.size16,
              height: 32,
              width: 225,
              onPressed: (){Navigator.pop(context);},
            ),
          ],
        ),
      ),
    );
  }
}
