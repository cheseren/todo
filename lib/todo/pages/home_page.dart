import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:todo/common/custom_button.dart';
import 'package:todo/common/todo_widgte.dart';
import 'package:todo/todo/controllers/todo_controller.dart';
import 'package:todo/todo/models/todo_model.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<TodosController>();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title".tr,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                controller.fetchTodos();
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
        tooltip: 'Increment',
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
      controller: controller.scrollController,
      itemCount: products.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // controller.setProductId(products[index]);
        return TodoWidget(
          name: controller.todos[index].name,
          description: controller.todos[index].description,
          done: controller.todos[index].done,
          bdone: controller.updating.value ? CircularProgressIndicator() :  Checkbox(
            value: controller.todos[index].done == "yes" ? true : false,
            onChanged: (val)async {
              await controller.updateTodo(
                todoId: controller.todos[index].id,
                position: index,
                todoModel: TodoModel(done: val == true ? 'yes' : 'no'),
              );
            },
          ),
          onTap: () {
            _editTodo(controller.todos[index].id);
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
                controller.fetchTodos();
              },
              busy: controller.fetching.value)
        ],
      ),
    );
  }

  _addTodo() async {
    var result = await Get.toNamed('/addTodoPage');
    if (result != null) {
      TodoModel todoModel = result;
      controller.todos.add(todoModel);
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
        await Get.toNamed('/addTodoPage?todoId=$todoId', arguments: todoId);
    if (result != null) {
      TodoModel model = result;
      controller.todos.removeWhere((element) => element.id == todoId);
      controller.todos.add(model);

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
