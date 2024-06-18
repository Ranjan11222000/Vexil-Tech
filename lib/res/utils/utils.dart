import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils{
  static errorSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: const Icon(
        Icons.error,
        size: 28,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static successSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: const Icon(
        Icons.check_circle,
        size: 28,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}