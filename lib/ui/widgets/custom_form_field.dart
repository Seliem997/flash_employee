import 'package:flash_employee/ui/widgets/custom_container.dart';
import 'package:flash_employee/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors.dart';

class DefaultFormField extends StatelessWidget {
  const DefaultFormField(
      {Key? key,
      this.controller,
      this.height,
      this.keyboardType,
      this.onChanged,
      required this.hintText,
      this.isPassword = false,
      this.validator,
      this.suffixIcon,
      this.enabled = true,
      this.filled = false,
      this.fillColor,
      this.textColor,
      this.prefixIcon,
      this.padding,
      this.letterSpacing,
      this.textHeight,
      this.textInputAction,
      this.hintStyle,
      this.textAlign = TextAlign.start,
      this.inputFormatters = const [],
      this.icon})
      : super(key: key);

  final TextEditingController? controller;
  final double? height;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final bool isPassword, filled;
  final bool enabled;
  final Color? fillColor, textColor;
  final String hintText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon, icon;
  final DecorationImage? prefixIcon;
  final EdgeInsetsGeometry? padding;
  final TextStyle? hintStyle;
  final double? letterSpacing;
  final double? textHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 3.w, vertical: 1),
      decoration: BoxDecoration(
          color: enabled
              ? filled
                  ? fillColor
                  : null
              : Color(0xffE0E0E0),
          border: Border.all(
              width: 1, color: filled ? fillColor! : AppColor.borderGray),
          borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        enabled: enabled,
        onChanged: onChanged,
        validator: validator,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: TextStyle(
            color: textColor, letterSpacing: letterSpacing, height: textHeight),
        textInputAction: textInputAction,
        textAlign: textAlign,
        decoration: InputDecoration(
          prefixIcon:
              prefixIcon != null ? CustomContainer(image: prefixIcon!) : null,
          prefixIconConstraints: prefixIcon != null
              ? BoxConstraints.tight(Size.fromRadius(12))
              : null,
          prefix: horizontalSpace(5),
          suffixIcon: suffixIcon,
          icon: icon,
          border: InputBorder.none,
          hintText: hintText,
          filled: filled,
          fillColor: fillColor,
          hintStyle:
              hintStyle ?? TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
      ),
    );
  }
}
