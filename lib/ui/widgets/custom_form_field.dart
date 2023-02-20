import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      this.padding,
      this.textInputAction,
      this.hintStyle,
      this.textAlign = TextAlign.start,
      this.inputFormatters = const [], this.icon})
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
  final EdgeInsetsGeometry? padding;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 3.w, vertical: 5),
      decoration: BoxDecoration(
          color: enabled
              ? filled
                  ? fillColor
                  : null
              : AppColor.grey,
          border: Border.all(
              width: 1, color: filled ? fillColor! : AppColor.borderGray),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        enabled: enabled,
        onChanged: onChanged,
        validator: validator,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: TextStyle(color: textColor),
        textInputAction: textInputAction,
        textAlign: textAlign,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          icon: icon,
          border: InputBorder.none,
          hintText: hintText,
          filled: filled,
          fillColor: fillColor,
          hintStyle: hintStyle ?? TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
