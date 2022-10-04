import 'dart:async';
import 'dart:io';

import 'package:cinerv/src/exception/exception.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.themoviedb.org/3/",
      headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMjYwOGRjY2YwNjMxNWY2MDBiMDM5MzU5M2Y3NTRhYSIsInN1YiI6IjYzMmYwNDE1N2VjZDI4MDA3YmEzODk1ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._SwRjx6ZhDTrdteVSYJn8G0eq8G11iBbnVZIc7aQS44",
      },
    ),
  );

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != null) {
        final statusCode = response.statusCode;
        if (statusCode! >= 200 && statusCode < 300) {
          return response.data;
        }
        throw ApiException.fromCode(statusCode);
      }
      throw ApiException(message: response.data.toString());
    } on DioError catch (error) {
      if (error.message.toLowerCase().contains('socket')) {
        throw const ApiException(message: "No Internet Connection");
      }
      if (error.response?.statusCode != null) {
        throw ApiException.fromCode(error.response!.statusCode!);
      }
      throw ApiException(message: error.message);
    } on SocketException {
      throw const ApiException(message: "No Internet Connection");
    } on TimeoutException {
      throw const ApiException(message: "Server Not Responding");
    } catch (error) {
      throw ApiException(message: error.toString());
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != null) {
        final statusCode = response.statusCode;
        if (statusCode! >= 200 && statusCode < 300) {
          return response.data;
        }
        throw ApiException.fromCode(statusCode);
      }
      throw ApiException(message: response.data.toString());
    } on DioError catch (error) {
      if (error.message.toLowerCase().contains('socket')) {
        throw const ApiException(message: "No Internet Connection");
      }
      if (error.response?.statusCode != null) {
        throw ApiException.fromCode(error.response!.statusCode!);
      }
      throw ApiException(message: error.message);
    } on SocketException {
      throw const ApiException(message: "No Internet Connection");
    } on TimeoutException {
      throw const ApiException(message: "Server Not Responding");
    } catch (error) {
      throw ApiException(message: error.toString());
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != null) {
        final statusCode = response.statusCode;
        if (statusCode! >= 200 && statusCode < 300) {
          return response.data;
        }
        throw ApiException.fromCode(statusCode);
      }
      throw ApiException(message: response.data.toString());
    } on DioError catch (error) {
      if (error.message.toLowerCase().contains('socket')) {
        throw const ApiException(message: "No Internet Connection");
      }
      if (error.response?.statusCode != null) {
        throw ApiException.fromCode(error.response!.statusCode!);
      }
      throw ApiException(message: error.message);
    } on SocketException {
      throw const ApiException(message: "No Internet Connection");
    } on TimeoutException {
      throw const ApiException(message: "Server Not Responding");
    } catch (error) {
      throw ApiException(message: error.toString());
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (response.statusCode != null) {
        final statusCode = response.statusCode;
        if (statusCode! >= 200 && statusCode < 300) {
          return response.data;
        }
        throw ApiException.fromCode(statusCode);
      }
      throw ApiException(message: response.data.toString());
    } on DioError catch (error) {
      if (error.message.toLowerCase().contains('socket')) {
        throw const ApiException(message: "No Internet Connection");
      }
      if (error.response?.statusCode != null) {
        throw ApiException.fromCode(error.response!.statusCode!);
      }
      throw ApiException(message: error.message);
    } on SocketException {
      throw const ApiException(message: "No Internet Connection");
    } on TimeoutException {
      throw const ApiException(message: "Server Not Responding");
    } catch (error) {
      throw ApiException(message: error.toString());
    }
  }
}
