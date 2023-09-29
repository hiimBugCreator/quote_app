import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BaseRestfulAPI {
  final Connectivity _connectivity = Connectivity();

  static final BaseRestfulAPI _instance = BaseRestfulAPI._internal();

  late Dio dio;

  BaseRestfulAPI._internal() {
    dio = Dio();
    dio.options.baseUrl = "https://api.api-ninjas.com/v1/";
    dio.options.contentType = 'application/json';
    dio.options.headers = {
      'X-Api-Key': 'ngLbwarfovf8zjyHqnTyUg==JIsoASacKcPq3GV7'
    };
    dio.options.validateStatus = (statusCode) {
      switch (statusCode) {
        case 200:
        case 201:
        case 204:
        case 404:
          return true;
        case 400:
        case 401:
        case 403:
        case 422:
        case 500:
        default:
          return false;
      }
    };
  }

  factory BaseRestfulAPI() {
    return _instance;
  }

  Future<Response> httpPut(String url, {Map<String, dynamic>? body}) async {
    await _checkConnectivity();
    var response = await dio.put(url, queryParameters: body);
    return response;
  }

  Future<Response> httpGet(String url, {Map<String, dynamic>? body}) async {
    await _checkConnectivity();
    return await dio.get(url, queryParameters: body);
  }

  // Future<http.Response> httpGet(Uri url, {Map<String, String>? headers}) async {
  //   await _checkConnectivity(url);
  //   FHLog.info(text: 'httpGet REQ ${url.path}');
  //   var response = await http.get(url, headers: headers);
  //   FHLog.info(text: 'httpGet RESP ${url.path} ${response.statusCode}');
  //   FHLog.logForApiServices('httpGet', null, response);
  //   return _verifyResponse(response, headers);
  // }

  Future<void> _checkConnectivity() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.iOS) {
      var result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {}
    }
  }
}
