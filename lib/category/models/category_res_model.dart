
import 'category_model.dart';

class CategoryResModel {
  bool? hasNextPage;
  List<CategoryModel>? docs;
  CategoryResModel({
    this.hasNextPage,
    this.docs,
  });

  factory CategoryResModel.fromJson(Map<String, dynamic> json) {
    return CategoryResModel(
      docs: json["docs"] == null || json["docs"] == []
          ? null
          : List<CategoryModel>.from(
              json["docs"].map((x) => CategoryModel.fromJson(x))),
      hasNextPage: json["hasNextPage"],
    );
  }
}
