// import 'package:dio/dio.dart';
// import 'package:mcc_admin/customer/models/customer_model.dart';

// import '../../../customer/models/customers_model.dart';
// import '../dio_client.dart';

// class CustomerService {
//   final dioClient = DioClient();

// // UserApi({required this.dioClient});

//   Future<CustomerModel> addOneApi(CustomerModel model) async {
//     try {
//       final response = await dioClient.post(
//         "/customer",
//         data: model.toJson(),
//         options: Options(headers: {"x-access-token": "token"}),
//       );
//       // print(response.data);
//       return CustomerModel.fromJson(response.data);
//     } on DioError catch (e) {
//       // print(e);
//       // The request was made and the server responded with a status code
//       // that falls out of the range of 2xx and is also not 304.
//       if (e.response != null) {
//         // print(e.response!.data);
//         // print(e.response!.headers);
//         // print(e.response!.requestOptions);
//         throw Exception(e.response!.data);
//       } else {
//         // Something happened in setting up or sending the request that triggered an Error
//         // print(e.requestOptions);
//         // print(e.message);
//         throw Exception(e.message);
//       }
//     }
//   }

//   Future<CustomersModel> fetchManyApi({
//     int? offset,
//     String? name,
//     String? manufacturer,
//     String? category,
//     bool? top,
//     bool? published,
//     String? composition,
//   }) async {
//     try {
//       final response = await dioClient.get(
//         '/customers',
//         // options: Options(headers: {"x-access-token": "token"}),
//         queryParameters: {
//           "firstName": name,
//         //   'offset': offset.toString(),
//         //   "manufacturer": manufacturer,
//         //   "category": category,
//         //   "published": published,
//         //   "top": top,
//         //   "composition": composition,
//         }
//       );
//       // print(response);
//       CustomersModel model = CustomersModel.fromJson(response.data);
//       // print(model.hasNextPage);
//       return model;
//     } on DioError catch (e) {
//       // print(e);
//       // The request was made and the server responded with a status code
//       // that falls out of the range of 2xx and is also not 304.
//       if (e.response != null) {
//         // print(e.response!.data);
//         // print(e.response!.headers);
//         // print(e.response!.requestOptions);
//         throw Exception(e.response!.data['message']);
//       } else {
//         // Something happened in setting up or sending the request that triggered an Error
//         // print(e.requestOptions);
//         // print(e.message);
//         throw Exception(e.message);
//       }
//     }
//   }

//   Future<CustomerModel> fetchOneApi(String id) async {
//     try {
//       var res = await dioClient.get("/customer/$id");
//       // print(res);
//       return CustomerModel.fromJson(res.data);
//     } on DioError catch (e) {
//       // print(e);
//       // The request was made and the server responded with a status code
//       // that falls out of the range of 2xx and is also not 304.
//       if (e.response != null) {
//         // print(e.response!.data);
//         // print(e.response!.headers);
//         // print(e.response!.requestOptions);
//         throw Exception(e.response!.data['message']);
//       } else {
//         // Something happened in setting up or sending the request that triggered an Error
//         // print(e.requestOptions);
//         // print(e.message);
//         throw Exception(e.message);
//       }
//     }
//   }

//   Future<Response> updateOneApi(int id, String name, String job) async {
//     try {
//       final Response response = await dioClient.put(
//         "/customer/$id",
//         data: {
//           'name': name,
//           'job': job,
//         },
//       );
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Future<void> deleteOneApi(String id) async {
//   //   try {
//   //     await dioClient.delete('/product/$id');
//   //   } catch (e) {
//   //     rethrow;
//   //   }
//   // }

//    Future<void> deleteOneApi(String id) async {
//     try {
      
//       await dioClient.delete('/customer/$id');
//       // print(res);
//     } on DioError catch (e) {
//       // print(e);
//       // The request was made and the server responded with a status code
//       // that falls out of the range of 2xx and is also not 304.
//       if (e.response != null) {
//         // print(e.response!.data);
//         // print(e.response!.headers);
//         // print(e.response!.requestOptions);
//         throw Exception(e.response!.data['message']);
//       } else {
//         // Something happened in setting up or sending the request that triggered an Error
//         // print(e.requestOptions);
//         // print(e.message);
//         throw Exception(e.message);
//       }
//     }
//   }
// }
