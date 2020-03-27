import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_reader/core/api/api.dart';
import 'package:news_reader/core/model/Report.dart';
import 'package:news_reader/presentation/views/Identification/LogIn.dart';
import 'package:news_reader/presentation/views/detail/dataSearch.dart';
import 'package:news_reader/presentation/widgets/ReportRow.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Report> reports;
  List<Report> reportsTrue;
  List<Report> reportsFalse;
  int page;
  bool value = false;
  var _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    page = 2;
    reports = new List<Report>();
    reportsTrue = new List<Report>();
    reportsFalse = new List<Report>();
    addReports(1);
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels != 0) {
          addReports(page);
          page++;
        }
      }
    });
  }

  void _logout() async {
    /*try {
      var res = await CallApi().postData([], "/logout");
      print(res);*/
    FocusScope.of(context).unfocus();
    Navigator.of(context).popUntil((route) => route.isFirst);
    /*} catch (e, stacktrace) {
      print(stacktrace);
    }*/
  }

  void addReports(page) async {
    // try {
    Response res = await CallApi().getData(page, "/posts");
    final Map<String, dynamic> parsed = res.data;

    reports =
        parsed['posts']['data'].map<Report>((k) => Report.fromJson(k)).toList();
    setState(() {
      for (var i = 0; i < reports.length; i++) {
        final Report report = reports[i];
        report.setDistance(report.longitude, report.latitude);
        if (report.affichage == true) {
          reportsTrue.add(report);
        } else {
          reportsFalse.add(report);
        }
      }
    });
    /*} catch (e, stacktrace) {
      print(stacktrace);
    }*/
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      reports.clear();
      reportsTrue.clear();
      reportsFalse.clear();
      page = 2;
      addReports(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    Drawer sideNav() {
      return Drawer(
          child: Stack(children: <Widget>[
        //first child be the blur background
        BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0), //this is dependent on the import statment above
            child: Container(
                decoration:
                    BoxDecoration(color: Colors.grey.withOpacity(0.5)))),
        ListView(padding: EdgeInsets.zero, children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("Bonjour"),
            accountEmail: new Text(LogIn.connectedEmail),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image:
                    new ExactAssetImage('assets/images/admin_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.account_circle,
                color: Colors.blueGrey,
                size: 70,
              ),
            ),
          ),
          new ListTile(
              leading: Icon(
                Icons.power_settings_new,
                size: 40,
              ),
              title: new Text(
                "Déconnexion",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                _logout();
              }),
          new ListTile(
              leading: Icon(
                Icons.group_add,
                size: 40,
              ),
              title: new Text(
                "Ajouter un administrateur",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pushNamed(context, "/signUp");
              }),
          new ListTile(
              leading: Icon(
                Icons.directions_run,
                size: 40,
              ),
              title: new Text(
                "Trier par distance",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                setState(() {
                  reportsTrue.sort((a, b) => a.distance.compareTo(b.distance));
                  reportsFalse.sort((a, b) => a.distance.compareTo(b.distance));
                });
              }),
          new ListTile(
              leading: Icon(
                Icons.date_range,
                size: 40,
              ),
              title: new Text(
                "Trier par date",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                setState(() {
                  reportsTrue.sort((a, b) => b.time.compareTo(a.time));
                  reportsFalse.sort((a, b) => b.time.compareTo(a.time));
                });
              }),
          new ListTile(
              leading: Icon(
                Icons.send,
                size: 40,
              ),
              title: new Text(
                "Trier par type",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                setState(() {
                  reportsTrue.sort((a, b) => b.type.compareTo(a.type));
                  reportsFalse.sort((a, b) => b.type.compareTo(a.type));
                });
              }),
          //gouvernorats here
        ])
      ]));
    }

    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Container(
        color: Color(0xFF242A38),
        child: new ButtonBar(
          // buttonTextTheme:
          children: <Widget>[
            Text("Cliquez pour voir les rapports cachés",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Switch(
              value: value,
              activeColor: Colors.green[200],
              onChanged: (bool e) {
                if (e) {
                  setState(() {
                    value = true;
                  });
                } else {
                  setState(() {
                    value = false;
                  });
                }
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF242A38),
        //iconTheme: new IconThemeData(color: Colors.black),
        title: Text(
          'Les dépassements',
          //style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Recherche',
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
      ),
      drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: sideNav()),
      body: RefreshIndicator(
        child: makeBody(context),
        onRefresh: refreshList,
      ),
    ));
  }

  Widget makeBody(BuildContext context) {
    return Container(
      /*decoration: new BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.4, 0.9],
          colors: 
          [            Colors.teal,
            Color.fromRGBO(60, 157, 155, 1),
            Color(0xFFFF3F1A),          ]
            ,
        ),
      ),*/
      color: Color(0xFF4E586E),
      child: (value)
          ? ListView.builder(
              controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: reportsFalse.length,
              itemBuilder: (BuildContext context, int index) {
                final item = reportsFalse[index];

                return Dismissible(
                  // Show a red background as the item is swiped away.
                  background: Container(
                    color: Colors.green[200],
                  ),
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    if (this.mounted) {
                      _putAffichage(item);
                      setState(() {
                        reportsTrue.add(item);
                        reportsFalse.removeAt(index);
                      });
                    }

                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Elément affiché avec succès")));
                  },
                  child: ReportRow(item),
                );
              })
          : /*AnimationLimiter(
              child:*/
          ListView.builder(
              controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: reportsTrue.length,
              itemBuilder: (BuildContext context, int index) {
                final item = reportsTrue[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1500),
                  delay: const Duration(milliseconds: 0),
                  child: FadeInAnimation(
                    //horizontalOffset: -1000.0,
                    child: ScaleAnimation(
                        child: Dismissible(
                      // Show a red background as the item is swiped away.
                      background: Container(
                        color: Colors.red[300],
                      ),
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        if (this.mounted) {
                          _putAffichage(item);
                          setState(() {
                            reportsFalse.add(item);
                            reportsTrue.removeAt(index);
                          });
                        }

                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Elément masqué avec succès")));
                      },
                      child: ReportRow(item),
                    )),
                  ),
                );
              }),
      //),
    );
  }

  void _putAffichage(item) async {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data = {'id': item.id, 'affichage': item.affichage};
    try {
      await CallApi().putData(data, "/edit");
    } catch (e, stacktrace) {
      print(stacktrace);
    }
  }
}
