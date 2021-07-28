import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:todo/category/controllers/add_category_controller.dart';

class AddCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCategoryController>(() => AddCategoryController());
  }
}