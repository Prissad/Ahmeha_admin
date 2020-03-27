import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  Dio dio;
  final String _url = 'http://51.178.54.128:2020/api';

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    setHeaders();
    return await dio.post(Uri.encodeFull(fullUrl), data: json.encode(data));
  }

  getData(page, apiUrl) async {
    var fullUrl = _url + apiUrl;
    dio = new Dio();
    return await dio
        .get(Uri.encodeFull(fullUrl), queryParameters: {"page": page});
  }

  getDataAll(apiUrl) async {
    var fullUrl = _url + apiUrl;
    dio = new Dio();
    return await dio.get(Uri.encodeFull(fullUrl));
  }

  putData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    setHeaders();
    return await dio.put(Uri.encodeFull(fullUrl), data: json.encode(data));
  }

  setHeaders() {
    dio = new Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['accept'] = 'application/json';
  }

  /*_getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }*/
}
