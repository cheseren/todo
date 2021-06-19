import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/home/home_page.dart';
import 'package:todo/todo/bindings/add_todo_binding.dart';
import 'package:todo/todo/bindings/todos_binding.dart';
import 'package:todo/todo/pages/add_todo_page.dart';
import 'package:todo/utils/my_translations.dart';

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
        name: '/addTodo',
        page: () => AddTodoPage(),
        binding: AddTodoBindings(),
      ),
    ],
  ));
}
