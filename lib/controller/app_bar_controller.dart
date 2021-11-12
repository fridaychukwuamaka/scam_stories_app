import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarController extends GetxController {
  var appBarElevationNotifier = 0.0.obs;
  ScrollController verticalScrollController = ScrollController();

  updateAppBarElevation(double newVal) {
    appBarElevationNotifier.value = newVal;
  }

  initController() {
    verticalScrollController.addListener(() {
      if (verticalScrollController.offset > 20) {
        updateAppBarElevation(4.0);
      } else {
        updateAppBarElevation(0.0);
      }
    });
  }
}
