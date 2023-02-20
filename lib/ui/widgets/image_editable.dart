import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors.dart';

class ImageEditable extends StatelessWidget {
  const ImageEditable({
    Key? key,
    required this.imageUrl,
    this.onTap,
    this.height,
    this.width,
    this.showEditIcon = false,
    this.isVehicle = false,
    this.topPositioned,
  }) : super(key: key);
  final String imageUrl;
  final bool showEditIcon;
  final bool isVehicle;
  final double? height, width, topPositioned;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: height ?? 55,
            width: width ?? 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageUrl.isEmpty
                    ? AssetImage(
                        isVehicle
                            ? "assets/images/tesla_model.png"
                            : 'assets/images/User.png',
                      )
                    : CachedNetworkImageProvider(imageUrl) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Visibility(
            visible: showEditIcon,
            child: Positioned(
              top: topPositioned ?? 8.h,
              right: 0,
              child: CircleAvatar(
                backgroundColor: AppColor.grey,
                radius: 16,
                child: SvgPicture.asset('assets/svg/camera.svg', height: 3.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
