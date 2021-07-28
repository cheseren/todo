import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:todo/category/models/category_model.dart';
import 'package:todo/common/custom_button.dart';
import 'package:todo/todo/controllers/add_todo_controller.dart';

class AddTodoPage extends StatelessWidget {
  // final String? todoId;
  AddTodoPage({Key? key}) : super(key: key);
  final controller = Get.find<AddTodoController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title:  Text(
              Get.parameters["todoId"] == null ? 'Add Todo' : 'Edit Todo',
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // * name
                      builaname(),
                      SizedBox(height: 15),
                      // *description
                      buildescription(),
                      SizedBox(height: 15),

                      // *category
                      buildCategory(),

                      //date
                      SizedBox(height: 15),

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
      // initialValue: controller.todoModel.value.name,
      focusNode: controller.nameFocusScope,
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
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget buildescription() {
    return TextFormField(
      controller: controller.descriptionCtl,
      // initialValue: controller.todoModel.value.description,

      focusNode: controller.descriptionFocusScope,
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
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget buildCategory() => TypeAheadFormField<CategoryModel>(
        textFieldConfiguration: TextFieldConfiguration(
          focusNode: controller.categoryFocusNode,
          controller: controller.categoryCtl,
          decoration: InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: (val) async {
          return await controller.fetchCategorySuggestion(val);
        },
        debounceDuration: Duration(milliseconds: 500),
        itemBuilder: (context, CategoryModel? suggestion) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(suggestion!.title!),
          );
        },
        onSuggestionSelected: (CategoryModel? suggestion) {
          controller.categoryCtl.text = suggestion!.title!;
          controller.todoModel.value.category = suggestion;
          // categoryModel = suggestion;
        },
        validator: (value) => value != null && value.isEmpty ||
                controller.todoModel.value.category == null
            ? 'Please select a Category from list'
            : null,
        noItemsFoundBuilder: (context) {
          return ListTile(
            title: Text('No Category Found'),
            trailing: TextButton(
                onPressed: () => Get.toNamed('/addCategoryPage'),
                child: Text('Create New')),
          );
        },
      );

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
      if (controller.todoId == null) {
        await controller.addTodo();
        if (controller.created.value == true) {
          Get.back(result: controller.todoModel.value);
        }
      } else {
        await controller.updateTodo(todoId: controller.todoId);
        if (controller.updated.value == true) {
          Get.back(result: controller.todoModel.value);
        }
      }
    }
  }
}
