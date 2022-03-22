import 'dart:async';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_getx_template/store/store.dart';
import 'package:flutter_getx_template/utils/utils.dart';
import 'package:flutter_getx_template/config/config.dart';
import 'package:get/get.dart' hide FormData;

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  late final Dio dio;
  final cancelToken = CancelToken();

  HttpUtil._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions(
      baseUrl: SERVER_API_URL,
      connectTimeout: 10000,
      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      headers: {},

      /// 请求的Content-Type，默认值是'application/json; charset=utf-8'.
      /// 如果您想以'application/x-www-form-urlencoded'格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'application/json; charset=utf-8',

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      /// 默认值是 `JSON`, 当响应头中content-type为'application/json'时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    );
    dio = Dio(options);
    // Cookie管理
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
        // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
        // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
        // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
        // 这样请求将被中止并触发异常，上层catchError会被调用。
      },
      onResponse: (response, handler) {
        return handler.next(response);
        // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
        // 这样请求将被中止并触发异常，上层catchError会被调用。
      },
      onError: (DioError e, handler) {
        Loading.dismiss();
        print(e.response?.data);
        HttpError err = createHttpError(e);
        handleError(err);
        return handler.next(e);
        // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
        // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
      },
    ));
  }

  // 错误处理
  void handleError(HttpError err) {
    print('请求错误: error.code ==> ${err.code}, error.message ==> ${err.message}');
    switch (err.code) {
      case 401:
        UserStore.instance.logout();
        showToast(msg: err.message);
        break;
      default:
        showToast(msg: '未知错误');
    }
  }

  // 错误信息
  HttpError createHttpError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return HttpError(code: -1, message: '请求取消');
      case DioErrorType.connectTimeout:
        return HttpError(code: -1, message: '连接超时');
      case DioErrorType.sendTimeout:
        return HttpError(code: -1, message: '请求超时');
      case DioErrorType.receiveTimeout:
        return HttpError(code: -1, message: '响应超时');
      case DioErrorType.cancel:
        return HttpError(code: -1, message: '请求取消');
      case DioErrorType.response:
        try {
          int errCode =
          error.response != null ? error.response!.statusCode! : -1;
          switch (errCode) {
            case 400:
              return HttpError(code: errCode, message: '请求语法错误');
            case 401:
              return HttpError(code: errCode, message: '没有权限');
            case 403:
              return HttpError(code: errCode, message: '服务器拒绝执行');
            case 404:
              return HttpError(code: errCode, message: '无法连接服务器');
            case 405:
              return HttpError(code: errCode, message: '请求方法被禁止');
            case 500:
              return HttpError(code: errCode, message: '服务器内部错误');
            case 502:
              return HttpError(code: errCode, message: '无效的请求');
            case 503:
              return HttpError(code: errCode, message: '服务器挂了');
            case 505:
              return HttpError(code: errCode, message: '不支持HTTP协议请求');
            default:
              return HttpError(
                code: errCode,
                message: error.response != null
                    ? error.response!.statusMessage!
                    : '',
              );
          }
        } on Exception catch (_) {
          return HttpError(code: -1, message: '未知错误');
        }
      default:
        return HttpError(code: -1, message: error.message);
    }
  }

  /*
   * 取消请求
   * 同一个cancel token 可以用于多个请求，当一个cancelToken取消时，所有使用该cancelToken的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel('cancelled');
  }

  /// 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    if (Get.isRegistered<UserStore>() && UserStore.instance.hasToken) {
      headers['Authorization'] = 'Bearer ${UserStore.instance.accessToken}';
    }
    return headers;
  }

  /// refresh 是否下拉刷新 默认 false
  /// noCache 是否不缓存 默认 true
  /// list 是否列表 默认 false
  /// cacheKey 缓存key
  /// cacheDisk 是否磁盘缓存
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        bool refresh = false,
        bool noCache = !CACHE_ENABLE,
        bool list = false,
        String cacheKey = '',
        bool cacheDisk = false,
      }) async {
    Options requestOptions = options ?? Options();
    if (requestOptions.extra == null) {
      requestOptions.extra = Map();
    }
    requestOptions.extra!.addAll({
      'refresh': refresh,
      'noCache': noCache,
      'list': list,
      'cacheKey': cacheKey,
      'cacheDisk': cacheDisk,
    });
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    final response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future<dynamic> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future<dynamic> put(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future<dynamic> patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future<dynamic> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future<dynamic> postForm(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(
      path,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future<dynamic> postStream(
      String path, {
        dynamic data,
        int dataLength = 0,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    requestOptions.headers!.addAll({
      Headers.contentLengthHeader: dataLength.toString(),
    });
    var response = await dio.post(
      path,
      data: Stream.fromIterable(data.map((e) => [e])),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}

// 错误格式
class HttpError implements Exception {
  int code;
  String message;

  HttpError({required this.code, required this.message});

  String toString() {
    return message.isEmpty ? 'Exception' : 'Exception: code $code, $message';
  }
}
