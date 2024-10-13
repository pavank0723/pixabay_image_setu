import 'package:flutter/material.dart';
import 'package:pixabay_image_setu/res/res.dart';

class CommonContainer extends StatefulWidget {
  final Widget child;
  final Function()? onTap;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final BoxDecoration? decoration;

  final bool rippleEffect;

  const CommonContainer({
    Key? key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.boxShadow,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.rippleEffect = true,
    this.height,
    this.width,
    this.backgroundColor,
    this.decoration,
  }) : super(key: key);

  @override
  State<CommonContainer> createState() => _CommonContainerState();
}

class _CommonContainerState extends State<CommonContainer> {
  bool isTapped = false; // Track tap state

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        if (widget.rippleEffect) {
          setState(() {
            isTapped = true; // Set tapped state to true when tapped
          });
        }
      },
      onTapCancel: () {
        if (widget.rippleEffect) {
          setState(
            () {
              isTapped = false; // Reset tapped state when tap is canceled
            },
          );
        }
      },
      onTap: () {
        if (widget.onTap != null && widget.rippleEffect) {
          widget.onTap!();
        }
        setState(() {
          isTapped = false; // Reset tapped state after tap action
        });
      },
      child: Container(
        margin: widget.margin,
        padding: widget.padding,
        height: widget.height,
        width: widget.width,
        decoration: widget.decoration ??
            BoxDecoration(
              color: widget.backgroundColor ?? AppColors.white,
              borderRadius: widget.borderRadius ??
                  const BorderRadius.all(
                      Radius.circular(AppDimens.appWidgetRadius)),
              boxShadow: isTapped && widget.rippleEffect
                  ? []
                  : (widget.boxShadow ??
                      const [
                        BoxShadow(
                          color: Color(0x33616161),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        )
                      ]),
            ),
        child: widget.child,
      ),
    );
  }
}
