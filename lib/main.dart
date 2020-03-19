import 'package:flutter/material.dart';
import 'presentation/views/detail/ReportPage.dart';
import 'presentation/views/home/Home.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/': (context) => Home(),
        '/Reports': (context) => ReportPage(),
      },
      initialRoute: '/',
    ),
  );
}
