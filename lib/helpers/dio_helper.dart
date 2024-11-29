import 'package:dio/dio.dart';

class DioHelper {
  static Dio? _dio;
  DioHelper._(); // make private constructor

  static void init() {
    // i want to start it at begaining of program , in main
    _dio = Dio(BaseOptions(
            baseUrl: 'http://localhost:8080/GP/',
            receiveTimeout: Duration(seconds: 60))
        //heraders written here
        );
  }

  static Future<Response> getData(
      {required String path, Map<String, dynamic>? queryparameters}) async {
    final response = _dio!.get(path, queryParameters: queryparameters);
    return response;
  }

  static Future<Response> postData(
      {required String path,
      Map<String, dynamic>? queryparameters,
      Map<String, dynamic>? body}) async {
    final response =
        _dio!.post(path, queryParameters: queryparameters, data: body);
    return response;
  }
}
// this dio helper is for helper instructions only 