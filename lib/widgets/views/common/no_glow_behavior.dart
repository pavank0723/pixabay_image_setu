// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/cupertino.dart';

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
