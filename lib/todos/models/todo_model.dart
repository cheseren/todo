import '../../category/models/category_model.dart';

class TodoModel {
  String? name;
  String? description;
  String? done;
  CategoryModel? categoryId;
  String? id;

  TodoModel({
    this.id,
    this.name,
    this.description,
    this.categoryId,
    this.done,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        name: json["name"],
        id: json["_id"],
        description: json["description"],
        done: json["done"],
        categoryId: json["categoryId"] == null
            ? null
            : CategoryModel.fromJson(
                json["categoryId"],
              ),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "done": done,
        "categoryId": categoryId == null ? null : categoryId!.toJson(),
      };
}
