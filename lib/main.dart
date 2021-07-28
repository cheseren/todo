import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/category/bindings/add_category_binding.dart';
import 'package:todo/category/bindings/list_category_binding.dart';
import 'package:todo/category/pages/add_category_page.dart';
import 'package:todo/category/pages/category_list_page.dart';
import 'package:todo/todo/bindings/add_todo_binding.dart';
import 'package:todo/todo/bindings/todos_binding.dart';
import 'package:todo/todo/pages/add_todo_page.dart';
import 'package:todo/utils/my_translations.dart';

import 'todo/pages/home_page.dart';
import 'unknown_route_page.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    defaultTransition: Transition.zoom,
    translations: MyTranslations(),
    locale: Locale('en', 'US'),
    theme: ThemeData(
      primarySwatch: Colors.pink,
      primaryColor: Colors.purple,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    
    // home: MyApp(),
    initialRoute: '/',
    unknownRoute: GetPage(
      name: '/notfound',
      page: () => UnknownRoutePage(),
    ),
    getPages: [
      GetPage(
        name: '/',
        page: () => HomePage(),
        binding: TodosBindings(),
      ),
      GetPage(
        name: '/addTodoPage',
        page: () => AddTodoPage(),
        binding: AddTodoBindings(),
      ),
      GetPage(
        name: '/addCategory',
        page: () => AddCategory(),
        binding: AddCategoryBinding(),
      ),
      GetPage(
        name: '/categoryListPage',
        page: () => CategoryListPage(),
        binding: CategoryListBinding(),
      ),
      GetPage(
        name: '/addTodoPage',
        page: () => AddTodoPage(),
        binding: AddTodoBindings(),
      ),
    ],
  ));
}
