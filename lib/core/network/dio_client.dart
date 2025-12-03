import 'package:dio/dio.dart';

class DioClient{
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com",
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  DioClient(){
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }
}

final dioClient = DioClient();