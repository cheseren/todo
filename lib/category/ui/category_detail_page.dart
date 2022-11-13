import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:todo/widgets/busyWidget.dart';
import 'package:todo/widgets/todo_widgte.dart';

import '../../todos/models/todo_model.dart';
import '../controllers/category_detail_controller.dart';
import 'add_category_page.dart';

class CategoryDetailPage extends StatefulWidget {
  //  final String? catId;

  const CategoryDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  final c = Get.put(CategoryDetailController());

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
          child: c.busy.value == true
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
                    'Name : ${c.categoryModel.value.title}',
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              )),
          // Text(
          //   'Description : ${c.categoryModel.value!.description}',
          //   style: header4,
          // ),
        ],
      ),
    );
  }

  Widget buildTodos() {
    return Expanded(
      child: Obx(() {
        if (c.fetching.value == true)
          return Center(child: CircularProgressIndicator());
        else
          return LazyLoadScrollView(
            onEndOfPage: () => c.fetchMoreTodos(),
            child: RefreshIndicator(
              onRefresh: () async {
                await c.refreshTodos();
              },
              // child: Text('data'),
              child: itemsList(c.todos),
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
          name: c.todos[index].name,
          description: c.todos[index].description,
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
        child: Text('Products In Category: ${c.categoryModel.value.title}'),
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
    await c.fetchCategoryById(molId: Get.parameters['categoryId']);
  }
}
