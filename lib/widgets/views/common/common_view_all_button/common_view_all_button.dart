import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixabay_image_setu/res/res.dart';

class CommonViewAllButton extends StatelessWidget {
  final int? type;
  final double? height;
  final double? width;
  final String? text;
  final IconData? icon;

  // final Color? iconColor;
  final Color? bgColor;

  // final double? iconPadding;
  // final double? iconSize;
  final double? paddingFromTop;
  final Function()? onTap;

  const CommonViewAllButton({
    super.key,
    this.type = 1,
    this.height = 170,
    this.width = 140,
    this.text = 'View All',
    this.icon = Icons.keyboard_arrow_down,
    // this.iconColor = Colors.white,
    // this.iconPadding = 1,
    this.bgColor = AppColors.primary,
    this.onTap,
    this.paddingFromTop = 40,
    // this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    double finalHeight;
    double finalWidth;

    // Determine final dimensions based on type and provided height/width
    switch (type) {
      case 2:
        finalHeight = height!.w;
        finalWidth = width!.w;
        break;
      case 3:
        finalHeight = 120.w;
        finalWidth = 140.w;
        break;
      default:
        finalHeight = height!.w;
        finalWidth = width!.w;
    }

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: finalHeight.h,
        width: finalWidth.w,
        child: Padding(
          padding: EdgeInsets.only(top: paddingFromTop!.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View All',
                style: AppTextStyle.bodyM(
                  txtColor: AppColors.primary,
                  fSize: 15.sp,
                ),
              ),
              SizedBox(height: 5.h),
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.primary),
                padding: REdgeInsets.all(1),
                child: Icon(icon!, color: AppColors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
