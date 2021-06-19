import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  String? todoId, name, description;
  num? dateCreated, dateAccomplished;
  TodoModel({
    this.todoId,
    this.name,
    this.description,
    this.dateCreated,
    this.dateAccomplished,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
