import 'dart:convert';
import 'dart:io';

import 'package:car_rental/app/shared/dio_contract.dart';
import 'package:dio/dio.dart';


class DioHandler implements DioContracts {
  DioHandler({required this.dio});

  final Dio dio;
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };

  final CancelToken _cancelToken = CancelToken();

  @override
  Future deleteData(
      {required String url,
      dynamic param,
      Map<String, dynamic>? header}) async {
        
    try {
      var res = await dio.delete(
        url,
        data: param,
        cancelToken: _cancelToken,
        options: Options(
          headers: header,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (res.statusCode == 200) {
        return res;
      } else if (res.statusCode == 401 || res.statusCode == 400) {
      } else if (res.data['message'] != null) {
        throw "${res.data['message']}";
      } else {
        throw "Error ${res.statusMessage}";
      }
    } on DioException catch (e) {
      throw dioErrorHandler(errorType: e.type);
    }
  }

  @override
  Future getData(
      {required String url,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? header}) async {
    try {
      // logger.e("URL : $url");
      var res = await dio.get(
        url,
        cancelToken: _cancelToken,
        queryParameters: queryParams,
        options: Options(
          headers: header ?? this.header,
          receiveTimeout: const Duration(seconds: 15),
          validateStatus: (status) {
            return status! < 505;
          },
        ),
      );
      // logger.e(res.statusCode);
      // logger.e(res);
      // print(header);
      // dikomen karena kemungkinan dipakai jika diperlukan untuk melakukan trace error
      // log(jsonEncode(url), name: "url");
      // log(jsonEncode(queryParams), name: "Paraams");
      // log(jsonEncode(header), name: "Header");
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res.data;
      } else if (res.statusCode == 401 || res.statusCode == 400) {
      } else {
        if (res.data != null) {
        } else {
          throw "Error ${res.statusMessage}";
        }
      }
    } on DioException catch (e) {
      throw dioErrorHandler(errorType: e.type);
    }
  }

  @override
  Future patchData(
      {required String url,
      String? param,
      Map<String, dynamic>? header}) async {
    try {
      var res = await dio.patch(
        url,
        data: param,
        cancelToken: _cancelToken,
        options: Options(
          headers: header,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res;
      } else if (res.statusCode == 401 || res.statusCode == 400) {
      } else {
        if (res.data != null) {
        } else {
          throw "Error ${res.statusMessage}";
        }
      }
    } on DioException catch (e) {
      throw dioErrorHandler(errorType: e.type);
    }
  }

  @override
  Future postData({
    required String url,
    dynamic param,
    Map<String, dynamic>? header,
    showDialogExpired = true,
  }) async {
    try {
      var res = await dio.post(
        url,
        cancelToken: _cancelToken,
        data: param,
        options: Options(
          headers: header,
          receiveTimeout: Duration(seconds: 10),
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res;
      } else if (res.statusCode == 401 || res.statusCode == 400 ||  res.statusCode == 404) {
        throw '''{
          "response_code": ${res.statusCode}
        }''';
      } else {
        if (res.data != null) {
        } else {
          throw "Error ${res.statusMessage}";
        }
      }
    } on DioException catch (e) {
        throw '''{
          "error":${jsonEncode(dioErrorHandler(errorType: e.type))},
          "response_code": ${0}
        }''';
    }
  }

  @override
  Future putData(
      {required String url,
      String? param,
      Map<String, dynamic>? header}) async {
    try {
      var res = await dio.put(
        url,
        data: param,
        cancelToken: _cancelToken,
        options: Options(
          headers: header,
          validateStatus: (status) {
            return status! <= 500;
          },
        ),
      );
      if (res.statusCode == 200) {
        return res.data;
      } else if (res.statusCode == 401 || res.statusCode == 400) {
        throw '''{
          "response_code": ${res.statusCode}
        }''';
      } else {
        if (res.data['error'] != null) {
          throw res.data['error'];
        } else if (res.data['message'] != null) {
          throw "${res.data['message']}";
        } else {
          throw "Error ${res.statusMessage}";
        }
      }
    } on DioException catch (e) {
      throw '''{
          "error":${jsonEncode(dioErrorHandler(errorType: e.type))},
          "response_code": ${0}
        }''';
     
    }
  }

  cancel() {
    _cancelToken.cancel('Cancelled');
  }

  String dioErrorHandler({required DioExceptionType errorType}) {
    String msg = "";
    switch (errorType) {
      case DioExceptionType.receiveTimeout:
        msg = "Gagal menerima data";
        break;
      case DioExceptionType.connectionTimeout:
        msg = "Koneksi tidak stabil";
        break;
      case DioExceptionType.sendTimeout:
        msg = "Gagal mengirim data";
        break;
      case DioExceptionType.connectionError:
        msg = "Koneksi Internet Terputus";
        break;
      default:
        msg = "Error Data";
    }
    return msg;
  }
}
