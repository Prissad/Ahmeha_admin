import 'package:flutter/material.dart';
import 'package:news_reader/core/model/Report.dart';
import 'package:news_reader/presentation/widgets/ReportRow.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Report> reports;
  @override
  void initState() {
    super.initState();
    reports = new List<Report>();
    addReports();
  }

  void addReports() {
    reports.add(new Report(
        100.3,
        20.5,
        "manzah",
        "resto",
        "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
        "20:30",
        true));
    reports.add(new Report(100.3, 20.5, "marsa", "cafe",
        "https://tinypng.com/images/social/website.jpg", "01:30", true));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Reports',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: makeBody(context),
    ));
  }

  Widget makeBody(BuildContext context) {
    return Container(
        color: Colors.black87,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: reports.length,
          itemBuilder: (BuildContext context, int index) =>
              ReportRow(reports[index]),
        ));
  }
}
