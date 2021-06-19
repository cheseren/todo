import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:todo/src/common/custom_button.dart';
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
        onPressed: () async {
          var result = await Get.toNamed('/addTodo');
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
        },
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
        return todoWidget(todo: index);
      },
    );
  }

  Widget todoWidget({required int todo}) {
    return Card(
        child: ListTile(
      title: Text(
        Get.find<TodosController>().todos[todo].name ?? 'Untitled Todo',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        Get.find<TodosController>().todos[todo].description!,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
      trailing: Text(
        todo.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    ));
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
}
