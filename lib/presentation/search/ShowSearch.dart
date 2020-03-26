import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_reader/core/api/api.dart';
import 'package:news_reader/core/model/Report.dart';
import 'package:news_reader/presentation/result/results.dart';
import 'package:news_reader/presentation/search/search.dart';
import 'package:news_reader/presentation/widgets/ReportRow.dart';

class ShowSearch extends StatefulWidget {
  Search search;
  ShowSearch(search) {
    this.search = search;
  }

  @override
  _ShowSearchState createState() => _ShowSearchState(this.search);
}

class _ShowSearchState extends State<ShowSearch> {
  _ShowSearchState(search) {
    this.search = search;
  }
  List<Report> results;
  Search search;
  int page;
  var _controller = ScrollController();

  void initState() {
    super.initState();
    results = new List<Report>();
    page = 2;
    getResults(1);
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels != 0) {
          getResults(page);
          page++;
        }
      }
    });
  }

  getResults(page) async {
    //requests to get the results
    //try {
    Response res = await CallApi()
        .getData(page, "/search?search=" + this.search.itemtoSearch);
    final Map<String, dynamic> parsed = res.data;

    setState(() {
      results += parsed['posts']['data']
          .map<Report>((k) => Report.fromJson(k))
          .toList();
      for (var i = 0; i < results.length; i++) {
        final Report report = results[i];
        report.setDistance(report.longitude, report.latitude);
      }
    });

    /*} catch (e, stacktrace) {
      print(stacktrace);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    print(search.itemtoSearch);
    return Center(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: results.length,
            controller: _controller,
            itemBuilder: (BuildContext context, int index) {
              final item = results[index];
              return ReportRow(item);
            }));
  }
}
