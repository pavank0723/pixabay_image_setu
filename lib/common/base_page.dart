import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:pixabay_image_setu/res/res.dart';
import 'package:pixabay_image_setu/utils/util_methods.dart';
import 'package:pixabay_image_setu/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

mixin BasePageState<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
  }

  Future navigateTo(String destination, {Object? args}) {
    return Navigator.pushNamed(context, destination, arguments: args);
  }

  Future<R?> navigateToWithReturnData<R>(String destination, {Object? args}) {
    return Navigator.pushNamed<R>(context, destination, arguments: args);
  }

  Future replaceWith(String destination, {dynamic args}) {
    return Navigator.pushReplacementNamed(context, destination,
        arguments: args);
  }

  void showToast(String msg, ToastType type) {
    UtilMethods.showToast(msg, type);
  }

  Future<bool> checkInternetConnection() async {
    bool isConnected =
        await InternetConnectivityHelper.checkInternetConnectivity();
    if (isConnected) {
      return true;
    } else {
      showNotInternetDialog();
      return false;
    }
  }

  void showLoading(bool flag) {
    flag
        ? SmartDialog.showLoading(
            msg: "Loading...",
          )
        : SmartDialog.dismiss();
  }

  void showNotInternetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Not Connected'),
          content: const Text('Please check your internet connection.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showLogInOrLogOutPopup(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Already $title'),
          content: Text('You have already $content today.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void setStatusBarColor(bool isSafeArea) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isSafeArea ? AppColors.appBgColor : Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: AppColors.appBgColor,
    ));
  }

  Widget hDashDivider(
      {double height = 1, double width = 10.0, Color color = Colors.black}) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth) + 10).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(
            dashCount,
            (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.white,
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: AppTextStyle.bodyB(txtColor: AppColors.primary),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Yes',
                    style: AppTextStyle.bodyB(txtColor: AppColors.primary)),
              ),
            ],
          ),
        )) ??
        false;
  }

  void showValidPopup(
      {String? title = 'Validation Error', String? message = ''}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            backgroundColor: AppColors.white,
            title: Text(title!),
            content: Text(message!),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showConfirmationPopup(String message) {
    message = "Do you perform this action";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            backgroundColor: AppColors.white,
            title: const Text('Are you sure?'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildShimmerHeadingContent({
    double width = AppDimens.appShimmerHeadingWidth,
    double height = AppDimens.appShimmerHeadingHeight,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(6))),
        height: height,
        width: width,
      ),
    );
  }

  Widget buildShimmerCircularContent(
      {double radius = AppDimens.appShimmerCircularRadius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget buildShimmerRoundRectangleContent(
      {double size = AppDimens.appShimmerHeadingWidth,
      double radius = AppDimens.appShimmerCircularRadius,
      bool isRadius = false}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: isRadius ? radius * 10 : size,
        width: size,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget buildListShimmer(Widget itemWidget,
      {int itemCount = 10, Axis scrollDirection = Axis.vertical}) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: true,
      controller: ScrollController(),
      itemCount: itemCount,
      physics: const ScrollPhysics(),
      itemBuilder: (_, index) {
        return Padding(
          padding: scrollDirection == Axis.horizontal
              ? const EdgeInsets.only(right: 15.0)
              : const EdgeInsets.only(bottom: 15.0),
          child: itemWidget,
        );
      },
    );
  }

  Widget buildListShimmerWithIndex(Widget Function(int index) itemWidget,
      {int itemCount = 10, Axis scrollDirection = Axis.vertical}) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: true,
      controller: ScrollController(),
      itemCount: itemCount,
      physics: const ScrollPhysics(),
      itemBuilder: (_, index) {
        return Padding(
          padding: scrollDirection == Axis.horizontal
              ? const EdgeInsets.only(right: 15.0)
              : const EdgeInsets.only(bottom: 15.0),
          child: itemWidget(index),
        );
      },
    );
  }

  Widget buildGridShimmer({
    Widget itemWidget = const SizedBox(),
    int itemCount = 10,
    int crossAxisCount = 2,
    double crossAxisSpacing = 10,
    double mainAxisSpacing = 10,
    double mainAxisExtent = 240,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          mainAxisExtent: mainAxisExtent,
          childAspectRatio: 1.2),
      itemBuilder: (_, index) {
        return itemWidget;
      },
    );
  }

  Widget buildShimmerDataContent(
      {double width = AppDimens.appShimmerDataWidth,
      double height = AppDimens.appShimmerDataHeight,
      double radius = 0,
      bool isPadding = true}) {
    return Padding(
      padding: !isPadding ? EdgeInsets.zero : const EdgeInsets.only(top: 8.0),
      child: Shimmer.fromColors(
        // direction: ShimmerDirection.ttb,
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          height: height,
          width: width,
        ),
      ),
    );
  }

  Widget vGap({double height = AppDimens.appVerticalSpacing}) => SizedBox(
        height: height,
      );

  Widget hGap({double width = AppDimens.appHorizontalSpacing}) => SizedBox(
        width: width,
      );

  Widget vDivider(
      {double width = 1,
      double height = 50,
      bool isMargin = true,
      Color color = AppColors.greyDark}) {
    return Container(
      width: width,
      height: height,
      color: color, // Outline color
      margin: EdgeInsets.symmetric(vertical: isMargin ? 8.0 : 0),
    );
  }

  Widget hDivider(
      {double width = double.infinity,
      double height = 0.5,
      Color color = AppColors.primary,
      bool isCustomMargin = false,
      EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 8.0)}) {
    return Container(
      width: width,
      height: height,
      color: color, // Outline color
      margin:
          isCustomMargin ? margin : const EdgeInsets.symmetric(vertical: 8.0),
    );
  }
}
