
import 'package:get/get.dart';

import '../category/ui/add_category_page.dart';
import '../category/ui/category_detail_page.dart';
import '../category/ui/category_list_page.dart';
import '../todos/ui/todos_page.dart';
import '../todos/ui/add_todo_page.dart';
import '../todos/ui/home_page.dart';

class Routes {
  // static const String addCategoryPage = '/addCategoryPage';

  static final List<GetPage> getPages = [
    GetPage(name: "/addCategory", page: () => AddCategoryPage()),
    GetPage(name: "/addTodo", page: () => AddTodoPage()),
    GetPage(name: "/categoryDetail", page: () => CategoryDetailPage()),
    GetPage(name: "/categories", page: () => CategoryListPage()),
    GetPage(name: "/home", page: () => HomePage()),
    GetPage(name: "/todos", page: () => TodosPage()),
    
  ];
}
