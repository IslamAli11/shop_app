 import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static  init(){

    dio=Dio(
      BaseOptions(
        baseUrl:  'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),

    );

  }

  static Future<Response>postData({
    String lang = 'en',
    String? token,
   required String url,
    Map<String , dynamic>?query,
    required Map<String , dynamic> data,

})async
  {
    dio.options.headers =
    {
       'lang' : lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };



    return await dio.post(
       url,
       queryParameters: query,
       data: data,

     );

  }



  static Future<Response>putData({
    String lang = 'en',
    String? token,
    required String url,
    Map<String , dynamic>?query,
    required Map<String , dynamic> data,

  })async
  {
    dio.options.headers =
    {
      'lang' : lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };



    return await dio.put(
      url,
      queryParameters: query,
      data: data,

    );

  }

  static Future<Response>getData({

    String? token,
    String lang = 'en',
    required String url,
    Map<String , dynamic>?query,


  })async
  {
    dio.options.headers =
    {
       'lang': lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };



    return await dio.get(

      url,

    );
  }



}