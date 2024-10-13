import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pixabay_image_setu/common/common.dart';
import 'package:pixabay_image_setu/res/res.dart';
import 'package:pixabay_image_setu/widgets/views/action_bar/action_bar.dart';
import 'package:pixabay_image_setu/widgets/views/common/common.dart';

class BaseScreen extends StatefulWidget {
  final String title;
  final String txtFloatingBtn;
  final String action;
  final String? appBarCustomIcon;
  final String navigateTo;
  final String floatingIcon;
  final bool isSafeAreaOnTop;
  final bool isIcon;
  final bool isCustomSvgIcon;
  final bool resizeToAvoidBottomInset;
  final bool isFloatingBtn;
  final bool isCustomBottomFAB;
  final bool isFloatingBtnWithLabel;
  final bool isLinearShade;
  final bool isTabView;
  final bool applyScroll;
  final bool enableAppBar;
  final bool homeAppBar;
  final bool isAppShadowEffect;
  final bool isAction;
  final bool isSpacingApply;
  final bool isSafeArea;
  final double iconSize;

  final Widget body;
  final Widget? bottomNav;

  final Widget? bottomSheet;

  final Color appBarBGColor;
  final Color appBarOtherColor;
  final Color appBarTitleColor;
  final Color? bgColor;
  final Function()? onAction;
  final Function()? onPressed;
  final Function()? fabOnTap1;
  final Function()? fabOnTap2;
  final Function()? fabOnTap3;
  final Function(dynamic data)? navigationCallback;

  final Object? args;

  final VoidCallback? expandableFABonTap;

  const BaseScreen(
      {super.key,
      this.title = "",
      this.isIcon = false,
      this.applyScroll = true,
      this.enableAppBar = true,
      this.homeAppBar = false,
      this.isLinearShade = false,
      this.isTabView = false,
      this.isFloatingBtn = false,
      this.isFloatingBtnWithLabel = false,
      this.isAppShadowEffect = true,
      this.isAction = false,
      this.isSpacingApply = true,
      this.isSafeArea = false, //true
      this.onAction,
      required this.body,
      this.action = "",
      this.bottomNav,
      this.navigateTo = "",
      this.floatingIcon = "",
      this.navigationCallback,
      this.onPressed,
      this.args,
      this.txtFloatingBtn = "Add new",
      this.appBarCustomIcon,
      this.appBarBGColor = AppColors.white,
      this.appBarOtherColor = AppColors.primary,
      this.appBarTitleColor = AppColors.greyDarkest,
      this.bgColor = AppColors.white,
      this.isCustomSvgIcon = false,
      this.bottomSheet,
      this.isCustomBottomFAB = false,
      this.fabOnTap1,
      this.fabOnTap2,
      this.fabOnTap3,
      this.expandableFABonTap,
      this.resizeToAvoidBottomInset = false,
      this.isSafeAreaOnTop = true,
      this.iconSize = 25});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen>
    with BasePageState, SingleTickerProviderStateMixin {
  bool isInternetConnected = false;
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;

  @override
  void initState() {
    checkInternetConnection();
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double sMobile = AppDimens.appSmallDevice;

    Widget scaffold = Scaffold(
      bottomSheet: widget.bottomSheet,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: widget.enableAppBar
          ? PreferredSize(
              preferredSize:
                  Size.fromHeight((width <= sMobile) ? 60.0.h : 70.0.h),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: CustomActionBar(
                  txtTitle: widget.title,
                  txtAction: widget.action,
                  onAction: widget.onAction,
                  isAppBottomShadow: widget.isAppShadowEffect,
                  isAction: widget.isAction,
                  customIcon: widget.appBarCustomIcon,
                  iconSize: widget.iconSize,
                  // customIconData: !widget.isSvgIcon
                  //     ? Icons.arrow_back
                  //     : Icons.arrow_back, // pavan sir created flags
                  isIcon: widget.isIcon,
                  appBarBGColor: widget.appBarBGColor,
                  appBarTitleColor: widget.appBarTitleColor,
                  appBarOtherColor: widget.appBarOtherColor,
                  isCustomSvgIcon: widget.isCustomSvgIcon,
                ),
              ),
            )
          : null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(),
        child: widget.applyScroll
            ? ScrollConfiguration(
                behavior: NoGlowBehaviour(),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Container(
                    color: AppColors.greyLight.withOpacity(0.15),
                    padding: widget.isSpacingApply
                        ? const EdgeInsets.symmetric(
                            horizontal: AppDimens.appHorizontalSpacing)
                        : EdgeInsets.zero,
                    child: widget.body,
                  ),
                ),
              )
            : Container(
                color: AppColors.greyLight.withOpacity(0.15),
                padding: widget.isSpacingApply
                    ? const EdgeInsets.symmetric(
                        horizontal: AppDimens.appHorizontalSpacing,
                        vertical: AppDimens.appVerticalPadding)
                    : EdgeInsets.zero,
                child: widget.body,
              ),
      ),
      bottomNavigationBar: widget.bottomNav,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //changed
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: widget.isCustomBottomFAB
          ? Container(
              margin: const EdgeInsets.only(top: 0),
              height: 64.h,
              width: 64.h,
              child: FloatingActionButton(
                backgroundColor: AppColors.primary,
                elevation: 0,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3.w,
                    color: AppColors.greyLightest,
                  ),
                  borderRadius: BorderRadius.circular(100).w,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.greyLightest,
                ),
              ),
            )
          : Visibility(
              visible: widget.isFloatingBtn,
              child: widget.isFloatingBtnWithLabel
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          // Add your onPressed code here!
                          widget.onPressed ??
                              navigateTo(widget.navigateTo, args: widget.args)
                                  .then((value) =>
                                      widget.navigationCallback!(value));
                        },
                        label: Text(
                          widget.txtFloatingBtn,
                          style: AppTextStyle.subTitle2M(
                              txtColor: AppColors.greyLightest),
                        ),
                        icon: SvgPicture.asset(
                          widget.floatingIcon,
                          colorFilter: const ColorFilter.mode(
                              AppColors.greyLightest, BlendMode.srcIn),
                        ),
                        backgroundColor: AppColors.primary,
                      ),
                    )
                  : FloatingActionButton(
                      heroTag: const Text('Floating Button'),
                      onPressed: () {
                        // Add your onPressed code here!
                        widget.onPressed ??
                            navigateTo(widget.navigateTo, args: widget.args)
                                .then((value) =>
                                    widget.navigationCallback!(value));
                      },
                      tooltip: widget.txtFloatingBtn,
                      backgroundColor: AppColors.primary,
                      child: SvgPicture.asset(
                        widget.floatingIcon,
                        colorFilter: const ColorFilter.mode(
                            AppColors.greyLightest, BlendMode.srcIn),
                      ),
                    ),
            ),
    );
    return !widget.isSafeArea
        ? SafeArea(
            top: false,
            bottom: true,
            child: scaffold,
          )
        : SafeArea(
            top: true,
            bottom: true,
            child: scaffold,
          );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }

    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {});
    } else {
      setState(() {});
    }
  }
}
