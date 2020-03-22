import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_reader/core/model/Report.dart';
import 'package:news_reader/presentation/widgets/ReportRow.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Report> reports;
  List<Report> reportsTrue;
  List<Report> reportsFalse;
  @override
  void initState() {
    super.initState();
    reports = new List<Report>();
    reportsTrue = new List<Report>();
    reportsFalse = new List<Report>();
    addReports();
    for (var i = 0; i < reports.length; i++) {
      final Report report = reports[i];
      if (report.affichage == true) {
        reportsTrue.add(report);
      } else {
        reportsFalse.add(report);
      }
    }
  }

  void addReports() {
    reports.add(new Report(
        8.793253,
        36.566389,
        "resto",
        "https://scontent.ftun7-1.fna.fbcdn.net/v/t1.15752-9/89925838_489363825280104_1717714553048924160_n.png?_nc_cat=110&_nc_sid=b96e70&_nc_ohc=FM15CjRP85UAX_hPoAX&_nc_ht=scontent.ftun7-1.fna&oh=7dd9d964fa2570859a74b85e04c6a11e&oe=5E9B7050",
        "00:48:04.901462",
        true));
    reports.add(new Report(
        10.340294,
        36.729070,
        "cafe",
        "https://shamelesspopery.com/media/2014/01/Bebada2-247x450.jpg",
        "01:30",
        true));
    reports.add(new Report(
        9.867040,
        37.274560,
        "cafe",
        "https://media-cdn.tripadvisor.com/media/photo-s/0a/ec/c5/ab/taken-with-cell-phone.jpg",
        "01:30",
        true));
    reports.add(new Report(8.835415, 35.168926, "cafe",
        "https://i.redd.it/ku0gu5avkj911.jpg", "01:30", true));
    reports.add(new Report(
        10.422828,
        32.910221,
        "cafe",
        "https://scontent.ftun7-1.fna.fbcdn.net/v/t1.15752-9/89714805_243938279979275_2983177111482662912_n.jpg?_nc_cat=110&_nc_sid=b96e70&_nc_ohc=1-Ny_hjFphsAX-7RuvX&_nc_ht=scontent.ftun7-1.fna&oh=10150086f59d5a8c31ac964a2ef4d51b&oe=5E9AF4B1",
        "01:30",
        true));
    reports.add(new Report(
        10.422828,
        32.910221,
        "cafe",
        "https://scontent.ftun7-1.fna.fbcdn.net/v/t1.15752-9/89714805_243938279979275_2983177111482662912_n.jpg?_nc_cat=110&_nc_sid=b96e70&_nc_ohc=1-Ny_hjFphsAX-7RuvX&_nc_ht=scontent.ftun7-1.fna&oh=10150086f59d5a8c31ac964a2ef4d51b&oe=5E9AF4B1",
        "01:30",
        true));
    reports.add(new Report(
        10.422828,
        32.910221,
        "cafe",
        "https://scontent.ftun7-1.fna.fbcdn.net/v/t1.15752-9/89714805_243938279979275_2983177111482662912_n.jpg?_nc_cat=110&_nc_sid=b96e70&_nc_ohc=1-Ny_hjFphsAX-7RuvX&_nc_ht=scontent.ftun7-1.fna&oh=10150086f59d5a8c31ac964a2ef4d51b&oe=5E9AF4B1",
        "01:30",
        true));
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
        backgroundColor: Color(0xFF75DAAD),
      ),
      body: makeBody(context),
    ));
  }

  Widget makeBody(BuildContext context) {
    return Container(
        color: /*Color(0xFF7A4D1D)*/ Colors.black87,
        child: AnimationLimiter(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: reportsTrue.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = reportsTrue[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1500),
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
                          setState(() {
                            reportsFalse.add(item);
                            reportsTrue.removeAt(index);
                          });

                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Elément masqué avec succès")));
                        },
                        child: ReportRow(item),
                      ),
                      // ),
                    ),
                  );
                })));
  }
}
