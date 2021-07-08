import 'package:flutter/material.dart';

import 'breakpoints.dart';

class ScreenSize {
  bool isMobile({required BuildContext context}) {
    return MediaQuery.of(context).size.width <= Breakpoints.mobile;
  }

  bool isTablet({required BuildContext context}) {
    return MediaQuery.of(context).size.width > Breakpoints.mobile &&
        MediaQuery.of(context).size.width <= Breakpoints.tablet;
  }

  double totalWidth({required BuildContext context}) {
    return MediaQuery.of(context).size.width;
  }

  double totalHeight({required BuildContext context}) {
    return MediaQuery.of(context).size.height;
  }
}
