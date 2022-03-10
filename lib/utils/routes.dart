
import 'package:get/get.dart';
import 'package:todo/pages/add_category_page.dart';
import 'package:todo/pages/add_todo_page.dart';
import 'package:todo/pages/category_detail_page.dart';
import 'package:todo/pages/category_list_page.dart';
import 'package:todo/pages/home_page.dart';
import 'package:todo/pages/todo_list_page.dart';

class Routes {
  static const String addCategoryPage = '/addCategoryPage';
  static const String addTodoPage = '/addTodoPage';
  static const String categoryDetailPage = '/categoryDetailPage';
  static const String categoryListPage = '/categoryListPage';
    static const String homePage = '/';
  static const String todoListPage = '/todoListPage';
  

  static final List<GetPage> getPages = [
    GetPage(name: addCategoryPage, page: () => AddCategoryPage()),
    GetPage(name: addTodoPage, page: () => AddTodoPage()),
    GetPage(name: categoryDetailPage, page: () => CategoryDetailPage()),
    GetPage(name: categoryDetailPage, page: () => CategoryDetailPage()),
    GetPage(name: categoryListPage, page: () => CategoryListPage()),
    GetPage(name: homePage, page: () => HomePage()),
    GetPage(name: todoListPage, page: () => TodoListPage()),
    
  ];
}
