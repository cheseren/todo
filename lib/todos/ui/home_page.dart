import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'completed_page.dart';
import 'todos_page.dart';


class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        // centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Get.toNamed("/categories");
                // c.fetchTodos();
              },
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ))
        ],
        bottom: TabBar(
          controller: c.tabController,
          tabs: [
            Tab(
              text: "Todos",
              icon: Icon(Icons.task),
              ),
            Tab(
              text: "Completed",
              icon: Icon(Icons.done)),
          ],
        ),
      ),
       body: TabBarView(
        controller: c.tabController,
        children: [
          TodosPage(),
          CompletedPage(),
        ],
      ),
     
    );
  }




 

  
}
