import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/src/common/custom_button.dart';
import 'package:todo/todo/controllers/add_todo_controller.dart';

class AddTodoPage extends StatelessWidget {
  final String? todoId;
  AddTodoPage({Key? key, this.todoId}) : super(key: key);
  final controller = Get.find<AddTodoController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Add Todo',
                style: TextStyle(
                  color: Colors.white,
                )),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // * name
                      builaname(),
                      SizedBox(height: 15),
                      // *description
                      buildescription(),
                      SizedBox(height: 15),

                      // *category

                      buildSendButton(),
                    ],
                  ),
                )),
          )),
    );
  }

  Widget builaname() {
    return TextFormField(
      controller: controller.nameCtl,
      focusNode: controller.nameFocusScope,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) return "Todo title cannot be empty.";
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Title",
      ),
      onChanged: (val) {
        controller.todoModel.value.name = val;
      },
      onFieldSubmitted: (val) {
        controller.descriptionFocusScope.requestFocus();
      },
    );
  }

  Widget buildescription() {
    return TextFormField(
      controller: controller.descriptionCtl,
      focusNode: controller.descriptionFocusScope,
      autofocus: true,
      maxLines: 4,
      validator: (value) {
        if (value!.isEmpty) return "Description can't be empty.";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Description",
      ),
      onChanged: (val) {
        controller.todoModel.value.description = val;
      },
      onFieldSubmitted: (val) {
        // conttroller.descriptionFocusScope.requestFocus();
      },
    );
  }

  Widget buildSendButton() {
    return CustomButton(
      title: "Send",
      send: send,
      busy: controller.creating.value,
    );
  }

  void send() async {
    controller.nameFocusScope.unfocus();
    controller.descriptionFocusScope.unfocus();
    if (controller.formKey.currentState!.validate()) {
      if (todoId == null) {
        await controller.addTodo();
        if (controller.created.value == true) {
          Get.back(result: controller.todoModel.value);
        }
      } else {
        controller.updateTodo(todoId: todoId);
      }
    }
  }
}
