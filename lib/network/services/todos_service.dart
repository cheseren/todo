import 'package:dio/dio.dart';
import '../../todos/models/todo_model.dart';
import '../../todos/models/todos_model.dart';
import '../dio_client.dart';

class TodosService {
  final dioClient = DioClient();

// UserApi({required this.dioClient});

  Future<TodoModel> addOneApi(TodoModel todoModel) async {
    try {
      // print(quantity);
      final response = await dioClient.post(
        "/todo",
        data: todoModel.toJson(),
        options: Options(headers: {"x-access-token": "token"}),
      );
      // print(response.data);
      return TodoModel.fromJson(response.data);
    } on DioError catch (e) {
      // print(e);
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response!.data);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        throw Exception(e.response!.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
        throw Exception(e.message);
      }
    }
  }

  Future<TodosModel> fetchManyApi({
    int? offset,
    String? name,
    String? manufacturer,
    String? category,
    bool? top,
    bool? published,
    String? composition,
  }) async {
    try {
      final response = await dioClient.get(
        '/todos',
        // options: Options(headers: {"x-access-token": "token"}),
        // queryParameters: {
        //   "name": name,
        //   'offset': offset.toString(),
        //   "manufacturer": manufacturer,
        //   "category": category,
        //   "published": published,
        //   "top": top,
        //   "composition": composition,
        // }
      );
      // print(response);
      TodosModel model = TodosModel.fromJson(response.data);
      // print(model.hasNextPage);
      return model;
    } on DioError catch (e) {
      // print(e);
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response!.data);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        throw Exception(e.response!.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
        throw Exception(e.message);
      }
    }
  }

  Future<TodoModel> fetchOneApi(String? id) async {
    // print(id);
    try {
      var res = await dioClient.get("/todo/$id");
      // print(res);
      return TodoModel.fromJson(res.data);
    } on DioError catch (e) {
      // print(e);
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response!.data);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        throw Exception(e.response!);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
        throw Exception(e.message);
      }
    }
  }

  // Future<TodoModel> clearCartApi({String? customerId}) async {
  //   try {
  //     final response = await dioClient.post(
  //       "/todo",
  //       data: {"customerId": customerId},
  //       options: Options(headers: {"x-access-token": "token"}),
  //     );
  //     // print(response.data);
  //     return TodoModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     // print(e);
  //     // The request was made and the server responded with a status code
  //     // that falls out of the range of 2xx and is also not 304.
  //     if (e.response != null) {
  //       // print(e.response!.data);
  //       // print(e.response!.headers);
  //       // print(e.response!.requestOptions);
  //       throw Exception(e.response!.data);
  //     } else {
  //       // Something happened in setting up or sending the request that triggered an Error
  //       // print(e.requestOptions);
  //       // print(e.message);
  //       throw Exception(e.message);
  //     }
  //   }
  // }

  Future<TodoModel> updateOneApi(
      TodoModel? todoModel, String? id) async {
    try {
      // print(todoModel!.toJson());
      var response = await dioClient.put(
        "/todo/$id",
        data: todoModel!.toJson(),
      );
      print(response.data);
      return TodoModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

   Future<void> deleteOneApi(String id) async {
    try {
      await dioClient.delete('/todo/$id');
      // print(res);
    } on DioError catch (e) {
      // print(e);
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response!.data);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        throw Exception(e.response!.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
        throw Exception(e.message);
      }
    }
  }
}
