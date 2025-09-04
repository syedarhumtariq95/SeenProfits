import 'dart:developer' as developer;
import 'package:dio/dio.dart';

enum RequestType { get, post, delete, patch, put }

enum HttpContentType {
  applicationJson(key: 'application/json');

  final String key;

  const HttpContentType({required this.key});
}

class APIService {
  final String baseUrl;
  final Dio _dio;

  APIService({required this.baseUrl})
    : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<APIResponseGeneric> apiCall({
    required String urlExt,
    bool useBaseUrl = true,
    required RequestType type,
    Map<String, dynamic>? queryParameters,
    HttpContentType contentType = HttpContentType.applicationJson,
    dynamic body,
  }) async {
    try {
      final header = _getHeader(contentType: contentType, urlExt: urlExt);
      final String fullUrl = useBaseUrl ? baseUrl + urlExt : urlExt;

      developer.log('$urlExt [${type.name}]');

      Response response;
      switch (type) {
        case RequestType.get:
          response = await _dio.get(
            fullUrl,
            queryParameters: queryParameters,
            options: Options(headers: header),
          );
          break;
        case RequestType.post:
          response = await _dio.post(
            fullUrl,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: header),
          );
          break;
        case RequestType.delete:
          response = await _dio.delete(
            fullUrl,
            queryParameters: queryParameters,
            options: Options(headers: header),
          );
          break;
        case RequestType.patch:
          response = await _dio.patch(
            fullUrl,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: header),
          );
          break;
        case RequestType.put:
          response = await _dio.put(
            fullUrl,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: header),
          );
          break;
      }

      return _responseHandler(response, urlExt);
    } catch (e) {
      return APIResponseGeneric(
        message: e.toString(),
        success: false,
        statusCode: -1,
      );
    }
  }

  APIResponseGeneric _responseHandler(Response response, String urlExt) {
    if (response.statusCode == 401) {
      // Handle unauthorized
    }

    final data = response.data;

    if (data != null && data['status'] == true) {
      return APIResponseGeneric(
        data: data['data'],
        message: data['message'] ?? '',
        statusCode: response.statusCode ?? 0,
        success: true,
      );
    } else {
      return APIResponseGeneric(
        message: data?['message'] ?? 'Unknown error',
        success: false,
        statusCode: response.statusCode ?? 0,
      );
    }
  }

  Map<String, String> _getHeader({
    HttpContentType contentType = HttpContentType.applicationJson,
    required String urlExt,
  }) {
    final header = {'Content-Type': contentType.key};
    header['Authorization'] = ''; // Add token if needed
    return header;
  }
}

class APIResponseGeneric {
  final dynamic data;
  final bool success;
  final String message;
  final int statusCode;

  const APIResponseGeneric({
    this.data,
    this.success = false,
    required this.message,
    required this.statusCode,
  });
}
