import 'package:dio/dio.dart';
import '../../category/models/categories_model.dart';
import '../../category/models/category_model.dart';
import '../dio_client.dart';

class CategoryService {
  final dioClient = DioClient();

// UserApi({required this.dioClient});

  Future<CategoryModel> addOneApi(CategoryModel productModel) async {
    try {
      final response = await dioClient.post(
        "/category",
        data: productModel.toJson(),
        options: Options(headers: {"x-access-token": "token"}),
      );
      // print(response.data);
      return CategoryModel.fromJson(response.data);
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

  Future<CategoriesModel> fetchManyApi({
    int? offset,
    String? productName,
    String? manufacturer,
    String? category,
    bool? top,
    bool? published,
    String? composition,
  }) async {
    try {
      final response = await dioClient.get('/categories',
          // options: Options(headers: {"x-access-token": "token"}),
          queryParameters: {
            "productName": productName,
            // 'offset': offset.toString(),
          });
      // print(response);
      CategoriesModel model = CategoriesModel.fromJson(response.data);
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

  Future<CategoryModel> fetchOneApi(String id) async {
    try {
      var res = await dioClient.get("/category/$id");
      // print(res);
      return CategoryModel.fromJson(res.data);
    } on DioError catch (e) {
      // print(e);
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response!.data);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        // throw Exception(e.response!.data['message']);
        // print({e.response!.data});
        throw Exception(e.response!.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
        throw Exception(e.message);
      }
    }
  }

  Future<CategoryModel> updateOneApi(
      CategoryModel productModel, String? id) async {
    try {
      // print(id);
      var response = await dioClient.put(
        "/category/$id",
        data: productModel.toJson(),
      );
      print(response.data);
      return CategoryModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> deleteOneApi(String id) async {
  //   try {
  //     await dioClient.delete('/product/$id');
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> deleteOneApi(String id) async {
    try {
      await dioClient.delete('/category/$id');
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
