import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  Dio dio;
  final String _url = 'http://10.0.2.2:8000/api';

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    setHeaders();
    return await dio.post(Uri.encodeFull(fullUrl), data: json.encode(data));
  }

  getData(data, apiUrl) async {}

  setHeaders() {
    dio = new Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['accept'] = 'application/json';
  }

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
}
