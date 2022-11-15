import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:todo/todos/controllers/add_todo_controller.dart';
import 'package:todo/widgets/custom_button.dart';

import '../../category/models/category_model.dart';


class AddTodoPage extends StatelessWidget {
  // final String? todoId;
  AddTodoPage({Key? key}) : super(key: key);
    final c = Get.put(AddTodoController());


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
                key: c.formKey,
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
      controller: c.nameCtl,
      // initialValue: c.todoModel.value.name,
      focusNode: c.nameFocusScope,
      validator: (value) {
        if (value!.isEmpty) return "Todo title cannot be empty.";
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Title",
      ),
      onChanged: (val) {
        c.todoModel.value.name = val;
      },
      onFieldSubmitted: (val) {
        c.descriptionFocusScope.requestFocus();
      },
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget buildescription() {
    return TextFormField(
      controller: c.descriptionCtl,
      // initialValue: c.todoModel.value.description,

      focusNode: c.descriptionFocusScope,
      maxLines: 4,
      validator: (value) {
        // if (value!.isEmpty) return "Description can't be empty.";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Description (Optional)",
      ),
      onChanged: (val) {
        c.todoModel.value.description = val;
      },
      onFieldSubmitted: (val) {
        // conttroller.descriptionFocusScope.requestFocus();
      },
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget buildCategory() {
    return TypeAheadFormField<CategoryModel>(
        textFieldConfiguration: TextFieldConfiguration(
          focusNode: c.categoryFocusNode,
          controller: c.categoryCtl,
          decoration: InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: (val) async {
          return await c.fetchCategorySuggestion(val);
        },
        debounceDuration: Duration(milliseconds: 500),
        itemBuilder: (context, CategoryModel? suggestion) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(suggestion!.title!),
          );
        },
        onSuggestionSelected: (CategoryModel? suggestion) {
          c.categoryCtl.text = suggestion!.title!;
          c.todoModel.value.categoryId = suggestion;
          c.selectedCategoryModel.value = suggestion;
          // c.categoryModel = suggestion;
        },
        validator: (value) => value != null && value.isEmpty ||
                c.selectedCategoryModel.value.id == null
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
  }

  Widget buildSendButton() {
    return CustomButton(
      title: c.isForEdit.value ? "Save Changes":"Send",
      send: send,
      busy: c.creating.value,
    );
  }

  void send() async {
    c.nameFocusScope.unfocus();
    c.descriptionFocusScope.unfocus();
    if (c.formKey.currentState!.validate()) {
      if (c.todoId == null) {
        await c.addTodo();
        if (c.created.value == true) {
          Get.back(result: c.todoModel.value);
        }
      } else {
        await c.updateTodo(todoId: c.todoId);
        if (c.updated.value == true) {
          Get.back(result: c.todoModel.value);
        }
      }
    }
  }
}
