import 'package:flutter/material.dart';
import 'package:news_reader/presentation/views/Inscription/SignUp.dart';
import 'presentation/views/Identification/LogIn.dart';
import 'presentation/views/detail/ReportPage.dart';
import 'presentation/views/home/Home.dart';

void main() {
  runApp(
    MaterialApp(
      home: new MyApp(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        //'/': (context) => Home(),
        '/Reports': (context) => ReportPage(),
        '/signUp': (context) => SignUp(),
        '/logIn': (context) => LogIn(),
      },
      //initialRoute: '/',
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/wash.gif",
              gaplessPlayback: true,
            )));
  }
}
