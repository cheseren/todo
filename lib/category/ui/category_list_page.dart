import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:todo/widgets/debouncer.dart';

import '../controllers/category_list_controller.dart';
import '../models/category_model.dart';
import 'add_category_page.dart';

class CategoryListPage extends StatefulWidget {
  final String? someString;

  const CategoryListPage({Key? key, this.someString}) : super(key: key);
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryListPage> {
    final c = Get.put(CategoryListController());

  //search
  final _searchCtl = TextEditingController();
  late final FocusNode _searchFocus;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _searchCtl.addListener(() => setState(() {}));
    _searchFocus = FocusNode();
    Future.delayed(Duration.zero, () {
      fetchCategories();
    });
  }

  @override
  void dispose() {
    _searchCtl.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  Future<void> fetchCategories() async {
    return await c.fetchCategories(_searchCtl.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          // backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text("Categories"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: goToAdd,
            )
          ],
        ),
        body: Column(
          children: [
            searchTxtInput(),
            Expanded(
              child: Obx(() {
                if (c.fetching.value == true)
                  return Center(child: CircularProgressIndicator());
                else
                  return LazyLoadScrollView(
                    onEndOfPage: () =>
                        c.fetchMoreProducts(_searchCtl.text),
                    child: RefreshIndicator(
                        onRefresh: () async {
                          await c.refreshCategories(_searchCtl.text);
                        },
                        child: itemList(c.categories)),
                  );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget itemList(List<CategoryModel> categories) {
    if (categories.length == 0) {
      return buildEmptyListWidget();
    }
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: c.categories.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return categoryWidget(
            c.categories[index], widget.someString, context);
      },
    );
  }

  Widget buildEmptyListWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8),
        child: Text(
          'I seems there is nothing to show!',
          
        ),
      ),
    );
  }

  Widget categoryWidget(
      CategoryModel model, String? someString, BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(model.title ?? "",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            )),
        // subtitle: Text(index.toString()),
        trailing: Icon(Icons.menu),
        onTap: () {
          someString == null
              ? Get.toNamed('/categoryDetailPage?categoryId=${model.id}')
               
              : Get.back(result: model);
        },
      ),
    );
  }

  //search
  Widget searchTxtInput() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        autofocus: false,
        focusNode: _searchFocus,
        decoration: InputDecoration(
          hintText: "Search Categories...",
          prefixIcon: Icon(Icons.search),
          suffixIcon: _searchCtl.text.length <= 0
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: search,
                ),
          border: OutlineInputBorder(),
        ),
        onChanged: (val) {
          if (val.length >= 1) {
            _debouncer.run(() async {
              await c.fetchCategories(_searchCtl.text);
            });
          }
        },
        controller: _searchCtl,
      ),
    );
  }

  void search() {
    _searchCtl.clear();
    _searchFocus.unfocus();
    fetchCategories();
  }

  void goToAdd() async {
    var result = await Get.to(AddCategoryPage());
    if (result == true) {
      Get.snackbar(
        'Success!',
        'Category Added Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
      );
    }
  }
}
