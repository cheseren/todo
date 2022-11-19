import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/utils/erro_handler.dart';
import 'package:todo/widgets/no_internet.dart';

import '../../network/services/category_serivice.dart';
import '../../network/services/todos_service.dart';
import '../models/todo_model.dart';

class AddTodoController extends GetxController {
  final todoModel = TodoModel().obs;
  // final selectedCategoryModel = CategoryModel().obs;
  final _todosService = TodosService();
  final _categoryService = CategoryService();
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
  RxBool isForEdit = false.obs;

  @override
  void onClose() {
    nameCtl.dispose();
    descriptionCtl.dispose();
    descriptionFocusScope.unfocus();
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    fetchTodoById();
  }

  void sendTodo() {}

  Future addTodo() async {
    try {
      creating(true);
      created.value = false;
      // todoModel.value.categoryId = selectedCategoryModel.value;
      var model = await _todosService.addOneApi(
        TodoModel(
            name: nameCtl.text,
            description: descriptionCtl.text,
            categoryId: todoModel.value.categoryId),
      );
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
      var model = await _todosService.updateOneApi(
        TodoModel(
            name: nameCtl.text,
            description: descriptionCtl.text,
            categoryId: todoModel.value.categoryId),
        todoId,
      );
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
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future fetchTodoById() async {
    try {
      String? _todoId = Get.parameters["todoId"];
      todoId = _todoId;
      if (_todoId != null) {
        busy.value = true;
        isForEdit(true);
        TodoModel result = await _todosService.fetchOneApi(todoId);
        todoModel.value = result;
        nameCtl.text = result.name!;
        descriptionCtl.text = result.description!;
        // selectedCategoryModel.value = result.categoryId!;
        if (result.categoryId != null) {
          categoryCtl.text = result.categoryId!.title!;
        }
        busy.value = false;
      } else {
        isForEdit(false);
      }
    } catch (e) {
      busy(false);
      isForEdit(false);
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

  Future fetchCategorySuggestion(String queryString) async {
    try {
      var doc = await _categoryService.fetchManyApi(productName: queryString);
      var mols = doc.categories;
      return mols;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<TodoModel?> deleteTodo({required String? todoId}) async {
    try {
      var model = await _todosService.deleteOneApi(todoId);
      return model;
    } catch (e) {
      creating(false);
      updated.value = false;
      print(e.toString());
      if (e.runtimeType == SocketException) {
        noInternetAlert();
      } else {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        return null;
      }
    }
  }
}
