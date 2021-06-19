import 'dart:convert' as convert;

import 'package:todo/todo/models/todo_model.dart';
import 'package:todo/todo/models/todo_res_model.dart';

import '../../network_handler.dart';


class TodoService {
  NetworkHandler _networkHandler = NetworkHandler();

  Future fetchTodos({
    String? queryString,
    int? limit,
    int? offset,
  }) async {
    final response = await _networkHandler.get('/todos',
        {
          "queryString": queryString,
          "limit": limit,
          "offset": offset,

        });
    if (response.statusCode == 200) {
       var jsonResponse = convert.jsonDecode(response.body);
      var data = jsonResponse['data'];
      return TodoResponseModel.fromJson(data);
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      var message = jsonResponse["message"];
      throw Exception(
        'Failed perfom function' +
            'status code:${response.statusCode}' +
            message.toString(),
      );
    }
  }

  Future<TodoModel> fetchTodoById(String id) async {
    var response =
        await _networkHandler.get('/todos/$id', {});
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var data = jsonResponse["doc"];

      TodoModel model = TodoModel.fromJson(data);
      return model;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      var message = jsonResponse["message"];
      throw Exception(
        'Failed perfom function' +
            'status code:${response.statusCode}' +
            message.toString(),
      );
    }
  }

  Future<String> updateTodo({required String? id,required TodoModel? todoModel}) async {
    final response = await _networkHandler.patch("/todos/$id", todoModel!.toJson());
    // print(id);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var message = jsonResponse["message"];
      return message;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      var message = jsonResponse["message"];
      throw Exception(
        'Failed perfom function' +
            'status code:${response.statusCode}' +
            message.toString(),
      );
    }
  }

  Future<String> addTodo(TodoModel todoModel) async {
    final response = await _networkHandler.post("/todos", todoModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(response.body);
      var message = jsonResponse["message"];
      return message.toString();
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      var message = jsonResponse["message"];
      throw Exception(
        'Failed perfom function' +
            'status code:${response.statusCode}' +
            message.toString(),
      );
    }
  }
}
