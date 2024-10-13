import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixabay_image_setu/res/res.dart';

class NoDataAvailable extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String subtitle;
  final String icon;
  final bool requiredBtn;
  final bool isSvg;
  final bool isIcon;
  final String btnText;
  final Function()? onBtnClick;

  const NoDataAvailable({
    super.key,
    // this.imgUrl = AppImages.imgNoDataAvailable,
    this.imgUrl = "",
    required this.title,
    this.subtitle = "",
    this.btnText = "okay",
    required this.onBtnClick,
    this.requiredBtn = false,
    this.isSvg = true,
    this.isIcon = false,
    this.icon = "",
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double sMobile = AppDimens.appSmallDevice;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          isSvg
              ? SvgPicture.asset(
                  imgUrl,
                  height: (width <= sMobile) ? 150 : 200,
                )
              : Image.asset(
                  imgUrl,
                  height: (width <= sMobile) ? 150 : 200,
                ),
          const SizedBox(
            height: 16,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.subTitle1M(fSize: (width <= sMobile) ? 16 : 18),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyle.captionM(
                fSize: (width <= sMobile) ? 12 : 15,
                txtColor: AppColors.greyBefore),
          ),
          SizedBox(
            height: 30.h,
          ),

        ],
      ),
    );
  }
}
