import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../main.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';

class LabelWithInput extends StatelessWidget {
  const LabelWithInput({
    Key? key,
    required this.onTap,
    required this.title,
    required this.value,
    required this.iconPath,
    this.isBlue = false,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;
  final String iconPath;
  final String value;
  final bool isBlue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: title,
          textSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColor.secondary,
        ),
        verticalSpace(12),
        CustomContainer(
          width: double.infinity,
          height: 48,
          alignment: Alignment.center,
          borderRadius: BorderRadius.circular(5),
          borderColor: isBlue ? AppColor.primary : AppColor.borderGray,
          padding: symmetricEdgeInsets(horizontal: 16),
          backgroundColor: isBlue ? Color(0xffEDF6FD) : Color(0xffE0E0E0),
          onTap: () => onTap(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: value,
                // intl.DateFormat(
                //         DFormat.dmy.key, LanguageKey.en.key)
                //     .format(widget.isShowing
                //         ? DateTime.parse(widget.requestData!.date!)
                //         : installationProvider.needByDate),
                color: Colors.black,
              ),
              CustomContainer(
                child: Image.asset(
                  iconPath,
                  color: MyApp.themeMode(context) ? Colors.white : Colors.black,
                ),
                borderColorDark: Colors.transparent,
              ),
              // horizontalSpace(5),
            ],
          ),
        ),
      ],
    );
  }
}
