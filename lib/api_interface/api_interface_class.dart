import 'dart:convert';
import 'package:dio/dio.dart';
import '../constant/constant.dart';

class ApiInterface {
  final dio = Dio();

  Future<dynamic> getAllProducts() async {
    try {
      Map<String, String> headers = {
        "X-RapidAPI-Key": "c5d925f7c7msh8f7a174a2ae5433p156d46jsnd8df6a271465",
        "X-RapidAPI-Host": "asos2.p.rapidapi.com"
      };

      var response = await dio.get('${Constant.apiUrl}', options: Options(headers: headers));
      Map<String, dynamic> data = {'body': response.data, 'statusCode': response.statusCode};
      return data;
    } catch (e) {
      return 0;
    }
  }
}
