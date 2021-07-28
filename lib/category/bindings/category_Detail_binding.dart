import 'package:get/get.dart';
import 'package:todo/category/controllers/category_detail_controller.dart';

class CategoryDetailBunding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryDetailController>(() => CategoryDetailController());
  }
}