import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_reader/core/api/api.dart';
import 'package:news_reader/core/model/Report.dart';
import 'package:news_reader/presentation/views/Identification/LogIn.dart';
import 'package:news_reader/presentation/views/detail/dataSearch.dart';
import 'package:news_reader/presentation/views/home/Home.dart';
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
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Home()));
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
    final List<bool> gouvernorats = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];

    // print(gouvernorats.length);

    final List<String> gouvernoratsName = [
      "Ariana",
      "Béja",
      "Ben Arous",
      "Bizerte",
      "Gabès",
      "Gafsa",
      "Jendouba",
      "Kairouan",
      "Kasserine",
      "Kébili",
      "Kef",
      "Mahdia",
      "Manouba",
      "Médenine",
      "Monastir",
      "Nabeul",
      "Sfax",
      "Sidi Bouzid",
      "Siliana",
      "Sousse",
      "Tataouine",
      "Tozeur",
      "Tunis",
      "Zaghouan",
    ];
    // print(gouvernoratsName.length);
    List<String> gouvernoratSelected = new List<String>();

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
              leading: Icon(Icons.do_not_disturb),
              title: new Text("Déconnexion"),
              onTap: () {
                _logout();
              }),
          new ListTile(
              leading: Icon(Icons.add),
              title: new Text("Ajouter un autre administrateur"),
              onTap: () {
                Navigator.pushNamed(context, "/signUp");
              }),
          new ListTile(
              leading: Icon(Icons.directions_subway),
              title: new Text("Trier par distance"),
              onTap: () {
                setState(() {
                  reportsTrue.sort((a, b) => a.distance.compareTo(b.distance));
                  reportsFalse.sort((a, b) => a.distance.compareTo(b.distance));
                });
              }),
          new ListTile(
              leading: Icon(Icons.date_range),
              title: new Text("Trier par date"),
              onTap: () {
                setState(() {
                  reportsTrue.sort((a, b) => b.time.compareTo(a.time));
                  reportsFalse.sort((a, b) => b.time.compareTo(a.time));
                });
              }),
          new ListTile(
              leading: Icon(Icons.date_range),
              title: new Text("Trier par type"),
              onTap: () {
                setState(() {
                  reportsTrue.sort((a, b) => b.type.compareTo(a.type));
                  reportsFalse.sort((a, b) => b.type.compareTo(a.type));
                });
              }),
          new ListTile(
              leading: Icon(Icons.date_range),
              title: new Text("Choisir le gouvernorat"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      // StatefulBuilder
                      builder: (context, setState) {
                        return SingleChildScrollView(
                          child: AlertDialog(
                            actions: <Widget>[
                              Container(
                                width: 400,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Les gouvernorats:",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[0],
                                      title: Text(gouvernoratsName[0]),
                                      onChanged: (value) {
                                        setState(() {
                                          // gouvernorats[0]=value;
                                          gouvernorats[0] = !gouvernorats[0];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[1],
                                      title: Text(gouvernoratsName[1]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[1] = !gouvernorats[1];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[2],
                                      title: Text(gouvernoratsName[2]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[2] = !gouvernorats[2];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[3],
                                      title: Text(gouvernoratsName[3]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[3] = !gouvernorats[3];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[4],
                                      title: Text(gouvernoratsName[4]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[4] = !gouvernorats[4];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[5],
                                      title: Text(gouvernoratsName[5]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[5] = !gouvernorats[5];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[6],
                                      title: Text(gouvernoratsName[6]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[6] = !gouvernorats[6];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[7],
                                      title: Text(gouvernoratsName[7]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[7] = !gouvernorats[7];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[8],
                                      title: Text(gouvernoratsName[8]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[8] = !gouvernorats[8];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[9],
                                      title: Text(gouvernoratsName[9]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[9] = !gouvernorats[9];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[10],
                                      title: Text(gouvernoratsName[10]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[10] = !gouvernorats[10];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[11],
                                      title: Text(gouvernoratsName[11]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[11] = !gouvernorats[11];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[12],
                                      title: Text(gouvernoratsName[12]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[12] = !gouvernorats[12];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[13],
                                      title: Text(gouvernoratsName[13]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[13] = !gouvernorats[13];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[14],
                                      title: Text(gouvernoratsName[14]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[14] = !gouvernorats[14];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[15],
                                      title: Text(gouvernoratsName[15]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[15] = !gouvernorats[15];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[16],
                                      title: Text(gouvernoratsName[16]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[16] = !gouvernorats[16];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[17],
                                      title: Text(gouvernoratsName[17]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[17] = !gouvernorats[17];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[18],
                                      title: Text(gouvernoratsName[18]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[18] = !gouvernorats[18];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[19],
                                      title: Text(gouvernoratsName[19]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[19] = !gouvernorats[19];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[20],
                                      title: Text(gouvernoratsName[20]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[20] = !gouvernorats[20];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[21],
                                      title: Text(gouvernoratsName[21]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[21] = !gouvernorats[21];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[22],
                                      title: Text(gouvernoratsName[22]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[22] = !gouvernorats[22];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      value: gouvernorats[23],
                                      title: Text(gouvernoratsName[23]),
                                      onChanged: (value) {
                                        setState(() {
                                          gouvernorats[23] = !gouvernorats[23];
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Material(
                                          elevation: 5.0,
                                          color: Colors.teal,
                                          child: MaterialButton(
                                            padding: EdgeInsets.fromLTRB(
                                                10.0, 5.0, 10.0, 5.0),
                                            onPressed: () {
                                              print(gouvernorats);
                                              // setState(() {
                                              for (int i = 0; i < 24; i++) {
                                                if (gouvernorats[i] == true) {
                                                  gouvernoratSelected
                                                      .add(gouvernoratsName[i]);
                                                }
                                              }
                                              Navigator.of(context).pop();
                                              // });
                                            },
                                            child: Text("Save",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                )),
                                          ),
                                        ),
                                        Material(
                                          elevation: 5.0,
                                          color: Colors.red,
                                          child: MaterialButton(
                                            padding: EdgeInsets.fromLTRB(
                                                10.0, 5.0, 10.0, 5.0),
                                            onPressed: () {
                                              setState(() {
                                                for (int i = 0; i < 24; i++) {
                                                  gouvernorats[i] = false;
                                                }
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            child: Text("Cancel",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                )),
                                          ),
                                        ),
                                        Material(
                                          elevation: 5.0,
                                          color: Colors.blue[900],
                                          child: MaterialButton(
                                            padding: EdgeInsets.fromLTRB(
                                                10.0, 5.0, 10.0, 5.0),
                                            onPressed: () {
                                              setState(() {
                                                for (int i = 0;
                                                    i < gouvernorats.length;
                                                    i++) {
                                                  gouvernorats[i] = true;
                                                }
                                              });
                                              // Navigator.of(context).pop();
                                            },
                                            child: Text("Select All",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                )),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              }),
        ])
      ]));
    }

    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Container(
        color: Colors.blueAccent,
        child: new ButtonBar(
          // buttonTextTheme:
          children: <Widget>[
            Text("Cliquez pour voir les rapports cachés",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Switch(
              value: value,
              activeColor: Colors.green,
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
        backgroundColor: Colors.blueAccent,
        title: Text('Les dépassements'),
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
      decoration: new BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.4, 0.9],
          colors: [
            Colors.teal,
            Color.fromRGBO(60, 157, 155, 1),
            Color(0xFFFF3F1A),
          ],
        ),
      ),
      child: AnimationLimiter(
        child: (value)
            ? ListView.builder(
                controller: _controller,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: reportsFalse.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = reportsFalse[index];

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 2500),
                    child: SlideAnimation(
                      horizontalOffset: -1000.0,
                      //  child: SlideAnimation(
                      child: Dismissible(
                        // Show a red background as the item is swiped away.
                        background: Container(
                          color: Colors.green,
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

                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Elément affiché avec succès")));
                        },
                        child: ReportRow(item),
                      ),
                    ),
                  );
                })
            : ListView.builder(
                controller: _controller,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: reportsTrue.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = reportsTrue[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 2500),
                    child: SlideAnimation(
                      horizontalOffset: -1000.0,
                      //  child: SlideAnimation(
                      child: Dismissible(
                        // Show a red background as the item is swiped away.
                        background: Container(
                          color: Colors.red,
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
                      ),
                    ),
                  );
                }),
      ),
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
