import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class NetworkHandler {
    bool isRemote = false;
  // LOCAL
  // String localBaseUrl = '192.168.43.210:4000';
    static const String baseUrl = "192.168.0.105:4000";


  //  REMOTE
  final String remoteBaseUrl = 'app.patseki.co.ke';

  getUrl({
    required bool isRemote,
    required String uri,
    required Map<String, dynamic> params,
  }) {
    return isRemote == true
        ? Uri.https(remoteBaseUrl, uri, params)
        : Uri.http(baseUrl, uri, params);
  }

  var log = Logger();
   Future get(String uri, Map<String, dynamic> params) async {
    var url = getUrl(isRemote: isRemote, uri: uri, params: params);
    // print(params);
    // /user/register
    var response = await http.get(
      url,
      headers: {
                "Content-type": "application/json",
      },
    );
    print(response.body);
    // log.d(response.body);
    // print(token);
    return response;
  }

   Future<http.Response> post(String uri, Map<String, dynamic> body) async {
    var url = getUrl(isRemote: isRemote, uri: uri, params: {});
    // log.d(body);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
    log.d(response.body);
    return response;
  }

  Future<http.Response> update(String uri, Map<String, dynamic> body) async {
    var url = getUrl(isRemote: isRemote, uri: uri, params: {});
    log.d(body);
    var response = await http.put(
      url,
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> delete(String uri, Map<String, dynamic> body) async {
    var url = getUrl(isRemote: isRemote, uri: uri, params: {});
    log.d(body);
    var response = await http.delete(
      url,
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
    return response;
  }

  
}