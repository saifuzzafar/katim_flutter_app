import 'package:flutter/material.dart';
import 'package:katim_app/utils/ui_manager/ui_manager.dart';

class KatimUIManager extends UIManager {
  KatimUIManager(BuildContext context) : super(context);

  @override
  Size referenceModel() {
    return const Size(320, 640);
  }
}
