import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/models/category_model.dart';
import 'package:todo/models/category_res_model.dart';
import 'package:todo/services/category_service.dart';

class CategoryListController extends GetxController {
  CategoryService service = CategoryService();
  var categories = <CategoryModel>[].obs;

  var fetching = false.obs;
  var hasNext = false.obs;
  var fetchingMore = false.obs;
  var refreshing = false.obs;

  Future fetchCategories(String? queryString) async {
    try {
      fetching(true);
      print("..................$queryString.................");
      CategoryResModel doc = await service.fetchCategories(queryString: queryString);
      // print(doc.docs);
      categories.clear();
      categories.addAll(doc.docs!);
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
      CategoryResModel doc = await service.fetchCategories(queryString: name);
      categories.clear();
      categories.addAll(doc.docs!);
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
        CategoryResModel doc = await service.fetchCategories(
            offset: categories.length, queryString: name);
        categories.addAll(doc.docs!);
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
