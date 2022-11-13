import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/services/category_serivice.dart';
import '../models/category_model.dart';

class AddCategoryController extends GetxController {
  CategoryService _categoryService = CategoryService();
  var categoryModel = CategoryModel().obs;
  RxBool busy = false.obs;
  RxBool added = false.obs;
  RxBool updated = false.obs;

  Future addCategory() async {
    try {
      busy(true);
      added(false);
      await _categoryService.addOneApi(categoryModel.value);
      busy(false);
      added(true);
    } catch (error) {
      busy(false);
      added(false);
      return Get.dialog(AlertDialog(
        title: Text("Failed to create new category"),
        content: Text(error.toString()),
        actions: [
          ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ));
    }
  }

  Future updateCategory({required String? categoryId}) async {
    try {
      busy(true);
      updated(false);
      await _categoryService.updateOneApi(
        categoryModel.value,
        categoryId,
      );
      busy(false);
      updated(true);
    } catch (e) {
      busy(false);
      added(false);
      return Get.dialog(AlertDialog(
        title: Text("Fail to edit category"),
        content: Text(e.toString()),
        actions: [
          ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ));
    }
  }

  Future fetchCategoryById({required String? categoryId}) async {
    try {
      busy.value = false;
      CategoryModel model =
          await _categoryService.fetchOneApi(categoryId!);
      categoryModel.value = model;
      busy.value = false;
      return;
    } catch (error) {
      return Get.dialog(AlertDialog(
        title: Text("Failed to load category"),
        content: Text(error.toString()),
        actions: [
          ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ));
    }
  }
}
