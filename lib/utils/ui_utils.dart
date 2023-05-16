import 'package:flutter/cupertino.dart';

class UIUtils {
  UIUtils._();

  static const mobileScreenWidthMax = 599;
  static const tabletScreenWidthMin = 600;
  static const tabletScreenWidthMax = 1099;
  static double authFormWidth = 500;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static openKeyboard() => FocusManager.instance.primaryFocus?.requestFocus();

  static bool isMobile(BuildContext context) {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    if (data.size.shortestSide < mobileScreenWidthMax) {
      return true;
    }
    return false;
  }

  static bool isWeb(BuildContext context) {
    final data = width(context);
    if (data >= tabletScreenWidthMax) {
      return true;
    }
    return false;
  }

  static bool isTab(BuildContext context) {
    final data = width(context);
    if (data >= tabletScreenWidthMin && data <= tabletScreenWidthMax) {
      return true;
    }
    return false;
  }

  static Screen deviceMode(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= mobileScreenWidthMax) {
      return Screen.mobile;
    } else if (width <= tabletScreenWidthMax && width >= tabletScreenWidthMin) {
      return Screen.tablet;
    } else {
      return Screen.web;
    }
  }
}

enum Screen { mobile, tablet, web }
