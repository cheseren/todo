import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/services/category_serivice.dart';
import '../models/categories_model.dart';
import '../models/category_model.dart';

class CategoryListController extends GetxController {
  CategoryService _categoryService = CategoryService();
  var categories = <CategoryModel>[].obs;

  var fetching = false.obs;
  var hasNext = false.obs;
  var fetchingMore = false.obs;
  var refreshing = false.obs;

  Future fetchCategories(String? queryString) async {
    try {
      fetching(true);
      print("..................$queryString.................");
      CategoriesModel doc =
          await _categoryService.fetchManyApi(productName: queryString);
      // print(doc.docs);
      categories.clear();
      categories.addAll(doc.categories!);
      hasNext.value = doc.hasNextPage!;
      fetching(false);
    } catch (error) {
      return Get.dialog(
        AlertDialog(
          title: Text("An error occured"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(error.toString()),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future refreshCategories(String name) async {
    try {
      refreshing(true);
      CategoriesModel doc = await _categoryService.fetchManyApi(
        productName: name,
      );
      categories.clear();
      categories.addAll(doc.categories!);
      hasNext.value = doc.hasNextPage!;
      refreshing(false);
    } catch (error) {
      return Get.dialog(
        AlertDialog(
          title: Text("An error occured"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(error.toString()),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future fetchMoreProducts(String name) async {
    try {
      fetchingMore(true);
      if (hasNext.value == true) {
        CategoriesModel doc = await _categoryService.fetchManyApi(
            offset: categories.length, productName: name);
        categories.addAll(doc.categories!);
        hasNext(doc.hasNextPage);
        fetchingMore(false);
      }
    } catch (error) {
      return Get.dialog(
        AlertDialog(
          title: Text("An error occured"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(error.toString()),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
