import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/src/common/no_internet.dart';
import 'package:todo/todo/models/todo_model.dart';
import 'package:todo/todo/services/todo_service.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class AddTodoController extends GetxController {
  final todoModel = TodoModel().obs;
  final service = TodoService();

  final nameCtl = TextEditingController();
  final descriptionCtl = TextEditingController();

  final nameFocusScope = FocusNode();
  final descriptionFocusScope = FocusNode();

  final formKey = GlobalKey<FormState>();

  RxBool creating = false.obs;
  RxBool created = false.obs;

  @override
  void onClose() {
    nameCtl.dispose();
    descriptionCtl.dispose();
    descriptionFocusScope.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void sendTodo() {}

  Future addTodo() async {
    try {
      creating(true);
      created(false);
      var todoId = uuid.v4();
      todoModel.value.todoId = todoId;
      todoModel.value.dateCreated = DateTime.now().microsecondsSinceEpoch;
      await service.addTodo(todoModel.value);
      created(true);

      creating(false);
    } catch (e) {
      creating(false);
      created(false);
      print(e.toString());

      if (e.runtimeType == SocketException) {
        noInternetAlert();
      } else {
        Get.snackbar(
          'Error',
          'Error Adding Todo, Try again later',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  void updateTodo({required String? todoId}) {
    try {
      service.updateTodo(id: todoId, todoModel: todoModel.value);
    } catch (e) {
      creating(false);
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
