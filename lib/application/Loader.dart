import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader {
  static void start() {
    if (Get.isDialogOpen == false) {
      Get.dialog(
          Center(
            child: Center(
              child: Image.asset(
                'assets/images/spiner.gif',
                height: 150,
              ).paddingAll(10),
            ),
          ),
          barrierColor: Colors.transparent,
          barrierDismissible: false);
    }
  }

  static void stop() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}