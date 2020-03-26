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

  Search({this.itemtoSearch});
  void setItem(String item) {
    this.itemtoSearch = item;
  }
}
