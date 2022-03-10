import 'package:json_annotation/json_annotation.dart';

import 'category_model.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  String? name;
  String? description;
  String? done;
  CategoryModel? category;
  @JsonKey(name: '_id')
  String? id;
  TodoModel({this.id, this.name, this.description, this.category, this.done});

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
