import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/models/category_model.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/models/todo_res_model.dart';
import 'package:todo/services/category_service.dart';
import 'package:todo/services/todo_service.dart';
import 'package:todo/widgets/no_internet.dart';
class CategoryDetailController extends GetxController {
  final _categoryService = CategoryService();
  final _todoService = TodoService();

  var categoryModel = CategoryModel().obs;

  RxBool busy = false.obs;
  var todos = <TodoModel>[].obs;
  RxBool fetching = false.obs;
  RxBool hasNext = false.obs;
  RxBool fetchingMore = false.obs;
  RxBool refreshing = false.obs;

   Future fetchTodos() async {
    try {
      fetching(true);
      TodoResponseModel doc = await _todoService.fetchTodos();
      todos.clear();
      todos.addAll(doc.docs!);
      hasNext.value = doc.hasNextPage!;
      fetching(false);
    } catch (error) {
      printError(info: error.toString());
      fetching(false);
      if (error.runtimeType == SocketException) {
        noInternetAlert();
      } else {
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

  Future refreshTodos() async {
    try {
      refreshing(true);
      TodoResponseModel doc = await _todoService.fetchTodos();
      todos.clear();
      todos.addAll(doc.docs!);
      hasNext.value = doc.hasNextPage!;
      refreshing(false);
    } catch (error) {
      refreshing.value = false;
      if (error.runtimeType == SocketException) {
        noInternetAlert();
      } else {
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

  Future fetchMoreTodos() async {
    try {
      fetchingMore(true);
      if (hasNext.value == true) {
        TodoResponseModel doc = await _todoService.fetchTodos(
          offset: todos.length,
        );
        todos.addAll(doc.docs!);
        hasNext.value = doc.hasNextPage!;
        print(doc.hasNextPage!);
        fetchingMore(false);
      }
      fetchingMore(false);
    } catch (error) {
      fetchingMore(false);

      if (error.runtimeType == SocketException) {
        noInternetAlert();
      } else {
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

  

  

  Future fetchCategoryById({required String? molId}) async {
    try {
      busy.value = true;
      CategoryModel model = await _categoryService.fetchCategoryById(molId!);
      categoryModel.value = model;
      await fetchTodos();
      busy.value = false;
      return;
    } catch (error) {
      busy(false);
      return Get.dialog(AlertDialog(
        title: Text("Failed to load company"),
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
