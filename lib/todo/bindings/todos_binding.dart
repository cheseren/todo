import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:todo/todo/controllers/todo_controller.dart';

class TodosBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodosController>(() => TodosController());
  }
}
