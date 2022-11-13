import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:todo/todos/controllers/todo_controller.dart';
import 'package:todo/widgets/custom_button.dart';
import 'package:todo/widgets/todo_widgte.dart';

import '../models/todo_model.dart';

class HomePage extends StatelessWidget {

  HomePage({Key? key}) : super(key: key);
      final c = Get.put(TodosController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                c.fetchTodos();
              },
              child: Text(
                'Refresh',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (Get.find<TodosController>().fetching.value == true)
                return Center(child: CircularProgressIndicator());
              else
                return LazyLoadScrollView(
                  onEndOfPage: () =>
                      Get.find<TodosController>().fetchMoreTodos(),
                  child: RefreshIndicator(
                      onRefresh: () async {
                        await Get.find<TodosController>().refreshTodos();
                      },
                      child: itemsList(Get.find<TodosController>().todos)),
                );
            }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        backgroundColor: Get.theme.primaryColor,
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemsList(List<TodoModel> products) {
    if (products.length == 0) {
      return buildEmptyListWidget();
    }
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      controller: c.scrollController,
      itemCount: products.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // c.setProductId(products[index]);
        return TodoWidget(
          name: c.todos[index].name,
          description: c.todos[index].description,
          done: c.todos[index].done,
          bdone: c.updating.value ? CircularProgressIndicator() :  Checkbox(
            value: c.todos[index].done == "yes" ? true : false,
            onChanged: (val)async {
              await c.updateTodo(
                todoId: c.todos[index].id,
                position: index,
                todoModel: TodoModel(done: val == true ? 'yes' : 'no'),
              );
            },
          ),
          onTap: () {
            _editTodo(c.todos[index].id);
          },
        );
      },
    );
  }

  Widget buildEmptyListWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'I seems there is nothing to show!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 15),
          CustomButton(
              title: 'Retry',
              send: () {
                c.fetchTodos();
              },
              busy: c.fetching.value)
        ],
      ),
    );
  }

  _addTodo() async {
    var result = await Get.toNamed('/addTodo');
    if (result != null) {
      TodoModel todoModel = result;
      c.todos.add(todoModel);
      Get.snackbar(
        'Success',
        'Todo was added successfully',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    }
  }

  _editTodo(String? todoId) async {
    var result =
        await Get.toNamed('/addTodo?todoId=$todoId', arguments: todoId);
    if (result != null) {
      TodoModel model = result;
      c.todos.removeWhere((element) => element.id == todoId);
      c.todos.add(model);

      Get.snackbar(
        'Success',
        'Todo was updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    }
  }
}
