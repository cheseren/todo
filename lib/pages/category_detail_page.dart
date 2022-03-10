import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:todo/controllers/category_detail_controller.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/widgets/busyWidget.dart';
import 'package:todo/widgets/todo_widgte.dart';

import 'add_category_page.dart';

class CategoryDetailPage extends StatefulWidget {
  //  final String? catId;

  const CategoryDetailPage({Key? key,}) : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  
    final controller = CategoryDetailController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchCategoryById();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,

      appBar: AppBar(
                  elevation: 0.0,

        title: Text("Catgeory Detail"),
         actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: goToEdit,
            )
          ],
      ),
       body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: controller.busy.value == true
              ? BusyWidget()
              : Column(
                  children: [
                    buildCategory(),
                    buildTodosTitle(),
                    buildTodos(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildCategory() {
    return Container(
      // color: Theme.of(context).primaryColor,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Name : ${controller.categoryModel.value.title}',
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              )),
          // Text(
          //   'Description : ${controller.categoryModel.value!.description}',
          //   style: header4,
          // ),
       
        ],
      ),
    );
  }

   Widget buildTodos() {
    return Expanded(
      child: Obx(() {
        if (controller.fetching.value == true)
          return Center(child: CircularProgressIndicator());
        else
          return LazyLoadScrollView(
            onEndOfPage: () => controller.fetchMoreTodos(),
            child: RefreshIndicator(
                onRefresh: () async {
                  await controller.refreshTodos();
                },
                // child: Text('data'),
                child: itemsList(controller.todos),
                ),
          );
      }),
    );
  }

   Widget itemsList(List<TodoModel> todos) {
    if (todos.length == 0) {
      return buildEmptyListWidget();
    }
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: todos.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return TodoWidget(
      name: controller.todos[index].name,
      description: controller.todos[index].description,
      done: index.toString(),
    
    );
      },
    );
  }


  Widget buildEmptyListWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8),
        child: Text(
          'No products for this company!',
        ),
      ),
    );
  }

  Widget buildTodosTitle() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            'Products In Category: ${controller.categoryModel.value.title}'),
      ),
    );
  }

  void goToEdit() async {
    var result = await Get.to(
      AddCategoryPage(
        categoryId: Get.parameters['categoryId'],
      ),
    );
    if (result == true) {
      Get.snackbar(
        'Success!',
        'Category Upadted Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
      );
      fetchCategoryById();
    }
  }

void fetchCategoryById() async {
    await controller.fetchCategoryById(molId: Get.parameters['categoryId']);
  }  
}
