import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/src/common/no_internet.dart';
import 'package:todo/todo/models/todo_model.dart';
import 'package:todo/todo/models/todo_res_model.dart';
import 'package:todo/todo/services/todo_service.dart';

class TodosController extends GetxController {
  TodoService service = TodoService();
  var todos = <TodoModel>[].obs;
  var fetching = false.obs;
  var hasNext = false.obs;
  var fetchingMore = false.obs;
  var refreshing = false.obs;

  var scrollController = ScrollController();

  @override
  void onInit() async {
    // called after the widget is rendered on screen
    super.onInit();
    await fetchTodos();
  }

  Future fetchTodos() async {
    try {
      fetching(true);
      TodoResponseModel doc = await service.fetchTodos();
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
      TodoResponseModel doc = await service.fetchTodos();
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
        TodoResponseModel doc = await service.fetchTodos(
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
}
