
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData ({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  })async
  {
    dio.options.headers={
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization':'${token}',
    };
    return await dio.get(url,queryParameters: query);
  }
  static Future<Response> postData({
    required String url,
    required Map data,
    String? token,
  })async
  {
    dio.options.headers={
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization':'${token}',
    };
    return await dio.post(url, data: data);
  }
  static Future<Response> putData({
    required String token,
    required Map <String, dynamic>data,
    required String url,
  })
  async{
    dio.options.headers={
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization':'${token}',
    };
    return await dio.put(url,data: data);
  }
}