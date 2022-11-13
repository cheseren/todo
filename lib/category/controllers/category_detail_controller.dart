import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/widgets/no_internet.dart';

import '../../network/services/category_serivice.dart';
import '../../network/services/todos_service.dart';
import '../../todos/models/todo_model.dart';
import '../../todos/models/todos_model.dart';
import '../models/category_model.dart';
class CategoryDetailController extends GetxController {
  final _categoryService = CategoryService();
  final _todosService = TodosService();

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
      TodosModel doc = await _todosService.fetchManyApi();
      todos.clear();
      todos.addAll(doc.todos!);
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
      TodosModel doc = await _todosService.fetchManyApi();
      todos.clear();
      todos.addAll(doc.todos!);
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
        TodosModel doc = await _todosService.fetchManyApi(
          offset: todos.length,
        );
        todos.addAll(doc.todos!);
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
      CategoryModel model = await _categoryService.fetchOneApi(molId!);
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
