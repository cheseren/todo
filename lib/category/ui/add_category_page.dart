import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/widgets/busyWidget.dart';

import '../controllers/add_category_controller.dart';

class AddCategoryPage extends StatefulWidget {
  final String? categoryId;

  const AddCategoryPage({Key? key, this.categoryId}) : super(key: key);
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategoryPage> {
  final c = Get.put(AddCategoryController());
  final _formKey = GlobalKey<FormState>();

  final _titleCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (widget.categoryId != null) {
        fetchCategoryById();
      }
    });
  }

  @override
  void dispose() {
    _titleCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: widget.categoryId != null
                ? Text(
                    "Edit Category",
                    style: TextStyle(color: Colors.white),
                  )
                : Text(
                    "Add Category",
                    style: TextStyle(color: Colors.white),
                  ),
            actions: [
              Obx(
                () => TextButton(
                  onPressed: send,
                  child: c.busy.value == false
                      ? Text(
                          "Send",
                          style: TextStyle(color: Colors.white),
                        )
                      : CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                ),
              )
            ],
          ),
          body: Obx(() => Container(
              child: c.busy.value == false
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _titleInput(),
                          ],
                        ),
                      ),
                    )
                  : BusyWidget()))),
    );
  }

  Widget _titleInput() {
    return TextFormField(
      controller: _titleCtl,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) return "Category name can not be empty";
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: "Category Name",
        helperText: "Category Name can't be empty",
      ),
      textCapitalization: TextCapitalization.words,
    );
  }

  Future createCatgory({required String? categoryId}) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      c.categoryModel.value.title = _titleCtl.text.trim();
      categoryId == null
          ? await c.addCategory()
          : await c.updateCategory(
              categoryId: categoryId,
            );

      if (c.updated.value == true) {
        Get.back(result: true);
      } else {
                Get.back(result: true);

      }
      // if (controller.added.value == true) {
      //   Get.back(result: true);
      // }
    }
  }

  Future fetchCategoryById() async {
    await c.fetchCategoryById(categoryId: widget.categoryId);
    _titleCtl.text = c.categoryModel.value.title!;
  }

  void send() async {
    if (c.busy.value == false) {
      await createCatgory(categoryId: widget.categoryId);
    }
  }
}
