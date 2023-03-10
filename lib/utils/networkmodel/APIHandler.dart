import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
enum MethodType { POST, GET, PUT, DELETE }
const Duration timeoutDuration = const Duration(seconds: 60);
class APIHandler {
  // static Map<String, String> defaultHeaders = {
  //   "Content-Type": "application/json",
  //   'Accept-Encoding':'*/*'
  //  };

  static Dio dio = Dio();

  // POST method
  static Future<dynamic> post({
    dynamic requestBody,
    @required BuildContext? context,
    String ?url,
    Map<String, String> additionalHeaders = const {},
  }) async {
    return await _hitApi(
      context: context,
      url: url,
      methodType: MethodType.POST,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,

    );
  }

  // GET method
  static Future<dynamic> get({
    @required String ?url,
    @required BuildContext ?context,
    dynamic requestBody,
    Map<String, String> additionalHeaders = const {},
  }) async {
    return await _hitApi(
      context: context,
      url: url,
      methodType: MethodType.GET,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
    );
  }

  // GET method
  static Future<dynamic> delete({
    @required String ?url,
    @required BuildContext ?context,
    Map<String, String> additionalHeaders = const {},
  }) async {
    return await _hitApi(
      context: context,
      url: url,
      methodType: MethodType.DELETE,
      additionalHeaders: additionalHeaders,
    );
  }

  // PUT method
  static Future<dynamic> put({
    @required dynamic requestBody,
    @required BuildContext ?context,
    @required String ?url,
    Map<String, String> additionalHeaders = const {},
  }) async {
    return await _hitApi(
      context: context,
      url: url,
      methodType: MethodType.PUT,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
    );
  }

  // Generic HTTP method

  static Future<dynamic> _hitApi({
    @required BuildContext ?context,
    @required MethodType? methodType,
    @required String ?url,
    dynamic requestBody, Map<String, String> additionalHeaders = const {},}) async {
    Completer<dynamic> completer = new Completer<dynamic>();
    try {
      Map<String, String> headers = {
        'authorization': AppConstants.auth
      };
      headers.addAll(additionalHeaders);

      var response;

      switch (methodType) {
        case MethodType.POST:
          response = await dio
              .post(
                url!,
                options: Options(
                  headers: headers,
                ),
            data: requestBody,
              )
              .timeout(timeoutDuration);

          break;
        case MethodType.GET:
          response = await dio
              .get(
                url!,
                options: Options(
                  headers: headers,
                ),
               queryParameters: requestBody

              )
              .timeout(timeoutDuration);
          break;
        case MethodType.PUT:
          response = await dio
              .put(
                url!,
                data: json.encode(requestBody),
                options: Options(
                  headers: headers,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case MethodType.DELETE:
          response = await dio
              .delete(
                url!,
                options: Options(
                  headers: headers,
                ),
              )
              .timeout(timeoutDuration);
          break;
      }

      // print("url: ${url}");
      // //print("api handler requestbody: $requestBody");
      // //print("api handler responsebody: ${ json.encode(response.data)}");
      // //print("api handler response code: ${response?.statusCode}");


      completer.complete(response.data);

    } on DioError catch (e) {
      //print("dio cath ${e.message}");
      //print("error ${e.response?.statusCode}");
      //print("messag ${e.response?.data}");
      //print("messag ${e.response}");
      //print("code ${e.response?.statusCode}");

    }
    catch (e) {
      //print("errroraaa ${e.toString()}");
    }
    return completer.future;
  }

}
