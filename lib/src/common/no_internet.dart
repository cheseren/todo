import 'package:flutter/material.dart';
import 'package:get/get.dart';

noInternetAlert() {
  Get.dialog(
    AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          'Connection Issue!',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Check your internet connection. Make sure you are connected to internet before you proceed',
        ),
      ),
      actions: [
        ElevatedButton(
          child: Text("OK"),
          onPressed: () {
            Get.back();
          },
        )
      ],
    ),
  );
}
