import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/widgets/no_internet.dart';

import '../../network/services/todos_service.dart';
import '../models/todo_model.dart';
import '../models/todos_model.dart';

class CompletedController extends GetxController {
  TodosService _todosService = TodosService();
  var todos = <TodoModel>[].obs;
  var fetching = false.obs;
  var hasNext = false.obs;
  var fetchingMore = false.obs;
  var refreshing = false.obs;
  RxBool updating = false.obs;
  RxBool updated = false.obs;

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
      TodosModel doc = await _todosService.fetchManyApi(
        done: "yes",
      );
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
      TodosModel doc = await _todosService.fetchManyApi(
                done: "yes",
      );
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
          done: "yes",

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

  updateTodo({
    required String? todoId,
    required int position,
    String? done,
  }) async {
    try {
      updating.value = true;
      updated.value = false;
      var model = await _todosService.updateOneApi(
        TodoModel(
            name: todos[position].name,
            description: todos[position].description,
            categoryId: todos[position].categoryId,
            done: done),
        todoId,
      );
      todos.removeWhere((element) => element.id == todoId);
      todos.insert(position, model);
      // todos.add(model);
      updated.value = true;
      updating.value = false;
    } catch (e) {
      updating(false);
      updated.value = false;
      print(e.toString());
      if (e.runtimeType == SocketException) {
        noInternetAlert();
      } else {
        Get.snackbar(
          'Error',
          'Error Updating Todo, Try again later',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  updateDoneTodo({
    required String? todoId,
    required int position,
    String? done,
  }) async {
    try {
      updating.value = true;
      updated.value = false;
      var model = await _todosService.updateDoneApi(
        TodoModel(done: done),
        todoId,
      );
      todos.removeWhere((element) => element.id == todoId);
      // todos.insert(position, model);
      // todos.add(model);
      updated.value = true;
      updating.value = false;
    } catch (e) {
      updating(false);
      updated.value = false;
      print(e.toString());
      if (e.runtimeType == SocketException) {
        noInternetAlert();
      } else {
        Get.snackbar(
          'Error',
          'Error Updating Todo, Try again later',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    }
  }
}
