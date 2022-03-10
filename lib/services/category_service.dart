import 'dart:convert' as convert;


import 'package:todo/models/category_model.dart';
import 'package:todo/models/category_res_model.dart';

import '../utils/network_handler.dart';

class CategoryService {
  NetworkHandler _networkHandler = NetworkHandler();

  Future<CategoryResModel> fetchCategories({int? offset, String? queryString}) async {
    final response =
        await _networkHandler.get('/categories',{"title": queryString, "offset": offset.toString()});
    if (response.statusCode == 200) {
       var jsonResponse = convert.jsonDecode(response.body);
      var data = jsonResponse['data'];
      return CategoryResModel.fromJson(data);
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

  Future<String> addCategory(CategoryModel categoryModel) async {
    final response = await _networkHandler
        .post("/categories", categoryModel.toJson())
        .timeout(Duration(seconds: 20));
    if (response.statusCode == 201) {
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

  Future<CategoryModel> updateCategory(
      {String? id, CategoryModel? categoryModel}) async {
    final response = await _networkHandler.update("/categories/$id", categoryModel!.toJson());
    print(id);
    if (response.statusCode == 200) {
      return CategoryModel.fromJson(convert.jsonDecode(response.body));
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

  Future<CategoryModel> fetchCategoryById(String id) async {
    var response = await _networkHandler.get('/categories/$id',{});
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
            var data = jsonResponse["result"];

      CategoryModel model = CategoryModel.fromJson(data);
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
}
