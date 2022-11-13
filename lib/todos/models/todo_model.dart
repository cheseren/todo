import '../../category/models/category_model.dart';

class TodoModel {
  String? name;
  String? description;
  String? done;
  CategoryModel? categoryId;
  String? category;
  String? id;

  TodoModel({
    this.id,
    this.name,
    this.description,
    this.categoryId,
    this.category,
    this.done,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
      name: json["name"],
      id: json["_id"],
      description: json["description"],
      done: json["done"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "done": done,
        "categoryId": category,
      };
}
