import 'package:flash_employee/models/servicesModel.dart';
import 'package:flash_employee/providers/requests_provider.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/font_styles.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/spaces.dart';

import 'package:flutter/services.dart';
import '../../../utils/colors.dart';

class ExtraServicesWidget extends StatelessWidget {
  const ExtraServicesWidget(
      {super.key, this.infoOnPressed, this.onTap, required this.extraService});

  final VoidCallback? infoOnPressed;
  final GestureTapCallback? onTap;
  final ServiceData extraService;

  @override
  Widget build(BuildContext context) {
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context);
    return CustomContainer(
      height: 59,
      // width: 313,
      backgroundColor: extraService.isSelected || extraService.quantity > 0
          ? const Color(0xFFE1ECFF)
          : const Color(0xFFD1D1D1),
      backgroundColorDark: extraService.isSelected || extraService.quantity > 0
          ? const Color(0xFFE1ECFF) : null,
      radiusCircular: 4,
      child: Row(
        children: [
          Row(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: IconButton(
                  icon: const Icon(Icons.info, size: 20, color: AppColor.primary),
                  onPressed: infoOnPressed,
                ),
              ),
              CustomSizedBox(
                height: 30,
                width: 30,
                child: Image.network(extraService.image!),
              ),
              horizontalSpace(10),
              CustomContainer(
                width: 140,
                borderColorDark: Colors.transparent,
                child: TextWidget(
                  text: extraService.title!,
                  textSize: MyFontSize.size10,
                  fontWeight: MyFontWeight.semiBold,
                  maxLines: 2,
                  colorDark: extraService.isSelected || extraService.quantity > 0
                      ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: onlyEdgeInsets(end: 10),
              child: extraService.countable!
                  ? Row(
                children: [
                  CustomContainer(
                    onTap: () {
                      if (extraService.quantity > 0) {
                        extraService.quantity--;
                        requestsProvider.notifyListeners();
                      }
                    },
                    width: 25,
                    height: 25,
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.zero,
                    backgroundColor: Colors.transparent,
                    image: const DecorationImage(
                        image: AssetImage('assets/images/minus.png'),
                        fit: BoxFit.fitHeight),
                  ),
                  horizontalSpace(9),
                  TextWidget(
                    text: extraService.quantity.toString(),
                    fontWeight: MyFontWeight.bold,
                    textSize: MyFontSize.size12,
                    colorDark: extraService.quantity > 0 ? Colors.black : Colors.white,
                  ),
                  horizontalSpace(9),
                  CustomContainer(
                    onTap: () {
                      extraService.quantity++;
                      requestsProvider.notifyListeners();
                    },
                    width: 25,
                    height: 25,
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.zero,
                    backgroundColor: Colors.transparent,
                    image: const DecorationImage(
                        image: AssetImage('assets/images/plus.png'),
                        fit: BoxFit.fitHeight),
                  ),
                ],
              )
                  : CustomContainer(
                borderColorDark: Colors.transparent,
                onTap: () {
                  extraService.isSelected = !extraService.isSelected;
                  extraService.isSelected ? extraService.quantity = 1 : extraService.quantity = 0;
                  requestsProvider.notifyListeners();
                },
                radiusCircular: 5,
                backgroundColor: extraService.isSelected
                    ? AppColor.primary
                    : Colors.transparent,
                height: 17,
                width: 17,
                borderColor: extraService.isSelected
                    ? AppColor.primary
                    : AppColor.subTextGrey,
                child: extraService.isSelected
                    ? Image.asset('assets/images/checkIcon.png')
                    : Container(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
