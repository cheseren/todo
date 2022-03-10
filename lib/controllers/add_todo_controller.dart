import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/services/category_service.dart';
import 'package:todo/services/todo_service.dart';
import 'package:todo/utils/erro_handler.dart';
import 'package:todo/widgets/no_internet.dart';

class AddTodoController extends GetxController {
  final todoModel = TodoModel().obs;
  final service = TodoService();
  final categoryService = CategoryService();
  String? todoId;

  final nameCtl = TextEditingController();
  final descriptionCtl = TextEditingController();
  final categoryCtl = TextEditingController();

  final nameFocusScope = FocusNode();
  final descriptionFocusScope = FocusNode();
  final categoryFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  RxBool creating = false.obs;
  RxBool created = false.obs;
  RxBool updating = false.obs;
  RxBool updated = false.obs;
  RxBool busy = false.obs;

  @override
  void onClose() {
    nameCtl.dispose();
    descriptionCtl.dispose();
    descriptionFocusScope.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    todoId = Get.parameters["todoId"];
    // print(Get.parameters["todoId"]);
    if (Get.parameters["todoId"] != null) {
      await fetchTodoById();
    }
  }

  void sendTodo() {}

  Future addTodo() async {
    try {
      creating(true);
      created.value = false;
      var model = await service.addTodo(todoModel.value);
      todoModel.value = model;
      created.value = true;
      creating(false);
    } catch (e) {
      creating(false);
      created(false);
      print(e.toString());
      errorhandler(e, 'Error', e.toString());
    }
  }

  updateTodo({required String? todoId}) async {
    try {
      updating.value = true;
      updated.value = false;
      var model =
          await service.updateTodo(id: todoId, todoModel: todoModel.value);
      todoModel.value = model;
      updated.value = true;
      updating.value = false;
    } catch (e) {
      creating(false);
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

  Future fetchTodoById() async {
    try {
      busy.value = true;
      var result = await service.fetchTodoById(Get.parameters["todoId"]);
      todoModel.value = result;
      nameCtl.text = todoModel.value.name!;
      descriptionCtl.text = todoModel.value.description!;
      categoryCtl.text = todoModel.value.category != null
          ? todoModel.value.category!.title!
          : '';
      busy.value = false;
    } catch (e) {
      busy.value = false;
      print(e.toString());

      if (e.runtimeType == SocketException) {
        noInternetAlert();
      } else {
        Get.snackbar(
          'Error',
          'Error Fetching Todo, Try again later',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  fetchCategorySuggestions(String queryString) async {
    try {} catch (e) {}
  }

  Future fetchCategorySuggestion(String queryString) async {
    try {
      var doc = await categoryService.fetchCategories(queryString: queryString);
      var mols = doc.docs;
      return mols;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
