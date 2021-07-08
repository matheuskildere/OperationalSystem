import 'package:flutter/material.dart';

import 'screen_size.dart';

class AppColumns extends ScreenSize {
  static double column1({required BuildContext context}) {
    final width = 8.33 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  static double column2({required BuildContext context}) {
    final width = 16.66 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  static double column3({required BuildContext context}) {
    final width = 25 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  static double column4({required BuildContext context}) {
    final width = 33.33 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  static double column5({required BuildContext context}) {
    final width = 41.66 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  static double column6({required BuildContext context}) {
    final width = 50 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  static double column7({required BuildContext context}) {
    final width = 58.33 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  static double column8({required BuildContext context}) {
    final width = 66.66 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  static double column9({required BuildContext context}) {
    final width = 75 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  static double column10({required BuildContext context}) {
    final width = 83.33 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  static double column11({required BuildContext context}) {
    final width = 91.66 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  static double column12({required BuildContext context}) {
    final width = 100 * MediaQuery.of(context).size.width;
    return width;
  }
}
