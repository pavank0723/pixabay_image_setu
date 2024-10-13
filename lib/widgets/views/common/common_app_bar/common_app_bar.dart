import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixabay_image_setu/res/res.dart';

class CommonAppBar extends StatelessWidget {
  final IconData? leadingIcon;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool isCenter;
  final String? title;
  final double? iconSize;
  final List<Widget>? action;

  const CommonAppBar({
    super.key,
    this.leadingIcon = Icons.arrow_back_ios_rounded,
    this.iconColor = AppColors.greyDark,
    this.isCenter = true,
    this.title = "Title",
    this.iconSize = 24,
    this.backgroundColor,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          leadingIcon,
          size: iconSize,
          color: iconColor,
        ),
      ),
      centerTitle: isCenter,
      title: Text(
        title.toString(),
        style: AppTextStyle.subTitle1M(
            fSize: 18.sp, txtColor: AppColors.greyDark, wFont: FontWeight.w500),
      ),
      actions: action,
    );
  }
}
