import 'package:flutter/material.dart';
import 'package:katim_app/utils/app_constants.dart';

class CustomSnackBar {
  showSnackBar({required String content, required BuildContext context}) {
    final snackBar = SnackBar(
      content: Text(content),
      backgroundColor: AppConstants.searchBarColor,
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
