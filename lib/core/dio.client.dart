import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient(String apiKey) {
    _dio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';
    _dio.options.headers = {'x-api-key': apiKey, 'Accept': 'application/json'};
  }

  Dio get dio => _dio;
}
