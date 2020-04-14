import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  Dio dio;
  final String _url =
      /*'http://10.0.2.2:8000/api';*/ /*'http://192.168.1.4:8000/api';*/
      'http://51.178.54.128:2020/api';

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

  getDataDeleg(id, page, apiUrl) async {
    var fullUrl = _url + apiUrl;
    dio = new Dio();
    return await dio.get(Uri.encodeFull(fullUrl),
        queryParameters: {"id": id, "page": page});
  }

  getDelegations(gouv, apiUrl) async {
    var fullUrl = _url + apiUrl;
    dio = new Dio();
    return await dio
        .get(Uri.encodeFull(fullUrl), queryParameters: {"gouv": gouv});
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
