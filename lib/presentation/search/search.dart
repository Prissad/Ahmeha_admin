import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_reader/core/api/api.dart';
import 'package:news_reader/core/model/Report.dart';
import 'package:news_reader/presentation/views/Identification/LogIn.dart';
import 'package:news_reader/presentation/views/home/Home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:tutorial_project/Home/homeScreen.dart';
// import 'package:tutorial_project/Login/loginScreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tutorial_project/api/api.dart';

class Search {
  String itemtoSearch;
  List<Report> results = new List<Report>();

  Search({this.itemtoSearch});
  void setItem(String item) {
    this.itemtoSearch = item;
  }

  getResults(page) async {
    //requests to get the results
    Response res =
        await CallApi().getData(page, "/search?search=" + this.itemtoSearch);
    final Map<String, dynamic> parsed = res.data;

    results =
        parsed['posts']['data'].map<Report>((k) => Report.fromJson(k)).toList();

    return (results);
  }
}
