import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum DividerType {
  horizontal,
  vertical,
}

class CommonDivider extends StatelessWidget {
  final DividerType dividerType;
  final bool dashed;
  final Color color;
  final double thickness;
  final double height;
  final double width;

  const CommonDivider({
    Key? key,
    required this.dividerType,
    this.dashed = false,
    this.color = Colors.black,
    this.thickness = 1.0,
    this.height = double.infinity,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dividerType == DividerType.horizontal) {
      return FractionallySizedBox(
        widthFactor: 1.0.w,
        heightFactor: height == double.infinity ? null : 0.0,
        child: dashed
            ? CustomPaint(
                size: Size(width.w, thickness),
                painter: DashedLinePainter(color: color, thickness: thickness),
              )
            : Divider(
                color: color,
                thickness: thickness,
              ),
      );
    } else {
      return FractionallySizedBox(
        widthFactor: width == double.infinity ? null : 0.0,
        heightFactor: 1.0.h,
        child: RotatedBox(
          quarterTurns: 1,
          child: dashed
              ? CustomPaint(
                  size: Size(thickness, height.h),
                  painter:
                      DashedLinePainter(color: color, thickness: thickness),
                )
              : Divider(
                  color: color,
                  thickness: thickness,
                ),
        ),
      );
    }
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double thickness;

  DashedLinePainter({
    required this.color,
    required this.thickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5.0;
    const double gapWidth = 5.0;
    double currentX = 0.0;

    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, 0.0),
        Offset(currentX + dashWidth, 0.0),
        paint,
      );
      currentX += dashWidth + gapWidth;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
