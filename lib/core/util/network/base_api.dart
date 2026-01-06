import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api_constant/api_constant.dart';

/// Base API class for handling HTTP requests using Dio
@lazySingleton
class ApiBase {
  late final Dio _dio;

  ApiBase() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl, // Burası ApiConstants'tan gelmeli
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {

          // --- GÜNCELLEME ---
          // İstek atılan tam URL'yi birleştir
          final String fullUrl = options.baseUrl + options.path;
          log('REQUEST[${options.method}] => URL: $fullUrl');
          // --- GÜNCELLEME BİTİŞ ---

          // (Opsiyonel: İsterseniz eski 'PATH' logunu silebilirsiniz)
          // log('REQUEST[${options.method}] => PATH: ${options.path}');

          if (options.data is FormData) {
            final formData = options.data as FormData;
            log('\nFORM DATA FIELDS:');
            for (var field in formData.fields) {
              log('${field.key}: ${field.value}');
            }

            log('\nFORM DATA FILES:');
            for (var file in formData.files) {
              log('Field: ${file.key}');
              log('Filename: ${file.value.filename}');
              if (file.value.contentType != null) {
                log('Content-Type: ${file.value.contentType}');
              }
              log('Length: ${file.value.length} bytes');
            }
          } else {
            log('REQUEST DATA: ${options.data}');
          }

          log('REQUEST HEADERS: ${options.headers}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          log('RESPONSE DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
          log('ERROR DATA: ${e.response?.data}');
          log('ERROR MESSAGE: ${e.message}');
          log('ERROR TYPE: ${e.type}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(String path, {
    Map<String, dynamic>? queryParameters,
    String? auth,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            if (auth != null) 'Authorization':'Bearer $auth',
          },
        ),
      );
      return _handleResponse(response);
    } catch (e) {
      log('Error in get request: $e');
      if (e is DioException) {
        log('DioError type: ${e.type}');
        log('DioError message: ${e.message}');
        log('DioError response: ${e.response}');
      }
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, {
    dynamic data,
    String? token,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: options?.copyWith(
          headers: {
            ...?options.headers,
            if (token != null) 'Authorization': 'Bearer $token', // Standardize edilmiş format
          },
        ) ??
            Options(
              headers: {
                if (token != null) 'Authorization': 'Bearer $token', // Aynı format kullanılmalı
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              },
            ),
      );
      return _handleResponse(response);
    } catch (e) {
      log('Error in post request: $e');
      if (e is DioException) {
        log('DioError type: ${e.type}');
        log('DioError message: ${e.message}');
        log('DioError response: ${e.response}');
      }
      throw _handleError(e);
    }
  }

  Future<Response> put(String path, {
    dynamic data,
    String? token,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        options: options?.copyWith(
          headers: {
            ...?options.headers,
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ) ??
            Options(
              headers: {
                if (token != null) 'Authorization': 'Bearer $token',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              },
            ),
      );
      return _handleResponse(response);
    } catch (e) {
      log('Error in put request: $e');
      throw _handleError(e);
    }
  }

  Future<Response> patch(String path, {
    dynamic data,
    String? auth,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        options: Options(
          headers: {
            if (auth != null) 'Authorization': auth, // Not: Bu genelde 'Authorization': 'Bearer $auth' olmalı
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      return _handleResponse(response);
    } catch (e) {
      log('Error in patch request: $e');
      if (e is DioException) {
        log('DioError type: ${e.type}');
        log('DioError message: ${e.message}');
        log('DioError response: ${e.response}');
      }
      throw _handleError(e);
    }
  }

  Future<Response> delete(String path, {String? auth}) async {
    try {
      final response = await _dio.delete(
        path,
        options: Options(
          headers: {
            if (auth != null) 'Authorization': auth, // Not: Bu genelde 'Authorization': 'Bearer $auth' olmalı
            'Content-Type': 'application/json',
          },
        ),
      );
      return _handleResponse(response);
    } catch (e) {
      log('Error in delete request: $e');
      throw _handleError(e);
    }
  }

  Response _handleResponse(Response response) {
    log('Handling response with status code: ${response.statusCode}');
    log('Response data: ${response.data}');

    switch (response.statusCode) {
      case 200:
      case 201:
        return response; // ✅ Sadece başarılı durumlar return edilsin

      case 400:
      // ✅ 400 hatalarında exception throw et
        final message = response.data is Map<String, dynamic>
            ? response.data['message'] ?? 'Geçersiz istek'
            : 'Geçersiz istek';
        throw Exception(message);

      case 401:
        throw Exception('Bu işlem için lütfen giriş yapınız');

      case 403:
        throw Exception('Erişim yasak');

      case 404:
        throw Exception('Kaynak bulunamadı');

      case 409:
        final message = response.data is Map<String, dynamic>
            ? response.data['message'] ?? 'Bu email adresi zaten kullanımda'
            : 'Çakışma hatası';
        throw Exception(message);

      case 422:
      // Validation errors
        final message = response.data is Map<String, dynamic>
            ? response.data['message'] ?? 'Doğrulama hatası'
            : 'Doğrulama hatası';
        throw Exception(message);

      case 429:
        throw Exception('Çok fazla istek. Lütfen bekleyiniz');

      case 500:
      case 502:
      case 503:
        throw Exception('Sunucu hatası. Lütfen daha sonra tekrar deneyiniz');

      default:
        throw Exception('Beklenmeyen bir hata oluştu (${response.statusCode})');
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception('Bağlantı zaman aşımı. İnternet bağlantınızı kontrol ediniz');

        case DioExceptionType.badResponse:
        // Response hatalarını _handleResponse method'u zaten handle ediyor
        // Bu durumda error'un response'ını kontrol et
          if (error.response?.data is Map<String, dynamic>) {
            final message = error.response?.data['message'];
            if (message != null) {
              return Exception(message);
            }
          }
          return Exception('Sunucu hatası: ${error.response?.statusCode}');

        case DioExceptionType.cancel:
          return Exception('İstek iptal edildi');

        case DioExceptionType.connectionError:
          return Exception('İnternet bağlantınızı kontrol ediniz');

        default:
          return Exception('Ağ hatası: ${error.message ?? 'Bilinmeyen hata'}');
      }
    }

    // Exception zaten geliyorsa direkt döndür
    if (error is Exception) {
      return error;
    }

    return Exception('Beklenmeyen hata: $error');
  }
}