
import 'package:json_annotation/json_annotation.dart';
import 'package:todo/todo/models/todo_model.dart';

part 'todo_res_model.g.dart';

@JsonSerializable()
class TodoResponseModel {
  bool? hasNextPage;
  List<TodoModel>? docs;
  TodoResponseModel({
    this.hasNextPage,
    this.docs,
  });

  factory TodoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TodoResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoResponseModelToJson(this);
}
