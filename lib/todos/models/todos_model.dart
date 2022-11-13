import 'package:todo/todos/models/todo_model.dart';

class TodosModel {
  List<TodoModel>? todos;
  int? totalDocs;
  int? offset;
  int? limit;
  int? totalPages;
  int? page;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;

  TodosModel({
    this.todos,
    this.totalDocs,
    this.offset,
    this.limit,
    this.totalPages,
    this.page,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
  });

  factory TodosModel.fromJson(Map<String, dynamic> json) {
    return TodosModel(
      todos: json["docs"] == null || json["docs"] == []
          ? null
          : List<TodoModel>.from(
              json["docs"].map((x) => TodoModel.fromJson(x))),
      totalDocs: json["totalDocs"],
      offset: json["offset"],
      limit: json["limit"],
      totalPages: json["totalPages"],
      page: json["page"],
      pagingCounter: json["pagingCounter"],
      hasPrevPage: json["hasPrevPage"],
      hasNextPage: json["hasNextPage"],
    );
  }
}
