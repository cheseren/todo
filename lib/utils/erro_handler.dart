import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/widgets/no_internet.dart';

errorhandler(Object e, String title, String description) {
  if (e.runtimeType == SocketException) {
        noInternetAlert();
      } else {
        Get.snackbar(
          title,
          description,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
}