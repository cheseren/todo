import 'package:get/get.dart';
import 'package:todo/controllers/add_category_controller.dart';
import 'package:todo/controllers/add_todo_controller.dart';
import 'package:todo/controllers/category_detail_controller.dart';
import 'package:todo/controllers/category_list_controller.dart';
import 'package:todo/controllers/todo_controller.dart';

class AllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCategoryController>(() => AddCategoryController());
    Get.lazyPut<CategoryDetailController>(() => CategoryDetailController());
    Get.lazyPut<CategoryListController>(() => CategoryListController());
    Get.lazyPut<AddTodoController>(() => AddTodoController());
    Get.lazyPut<TodosController>(() => TodosController());

  }
}