import 'package:dio/dio.dart';

class RemoteDataSource {
  static Dio dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
          receiveDataWhenStatusError: true,
          headers: {'Content-Type': 'application/json'}),
    );
  }

  Future getData({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(url, queryParameters: queryParameters);
  }
}
