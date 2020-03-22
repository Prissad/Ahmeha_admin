import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map/map.dart';
import 'package:news_reader/core/data/geolocation/LookupCoordinate.dart';
import 'package:news_reader/core/model/Report.dart';
import 'package:latlng/latlng.dart';

import 'package:timeago/timeago.dart';

class ReportRow extends StatelessWidget {
  final Report report;

  ReportRow(this.report);

  @override
  Widget build(BuildContext context) {
    final controller = MapController(
      location: LatLng(report.latitude, report.longitude),
      zoom: 22,
    );
    void _incrementCounter() {
      controller.location = LatLng(report.latitude, report.longitude);
      controller.zoom = 22;
    }

    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;
    String publishTime(var time) {
      try {
        return timeAgo(DateTime.parse(report.time));
      } catch (Exception) {
        return "a day ago";
      }
    }

    CircleAvatar reportImage(var url) {
      try {
        return new CircleAvatar(
          backgroundImage: new NetworkImage(url),
        );
      } catch (Exception) {
        return new CircleAvatar(
          child: new Icon(Icons.photo),
        );
      }
    }

    final reportThumbnail = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 16.0),
      child: GestureDetector(
          child: Container(
              child: reportImage(report.urlToImage),
              width: 100.0,
              height: 100.0,
              padding: const EdgeInsets.all(1.0),
              // border width
              decoration: new BoxDecoration(
                color: Colors.white, // border color
                shape: BoxShape.circle,
              )),
          //   onTapDown: ,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    elevation: 16, child: Image.network(report.urlToImage));
              },
            );
          }),
    );

    final reportCard = new Container(
      margin: const EdgeInsets.only(left: 60.0, right: 16.0),
      decoration: new BoxDecoration(
        color: Colors.teal,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(6.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0))
        ],
      ),
      child: new Container(
        margin: const EdgeInsets.only(
            top: 8.0, left: 68.0, right: 4.0, bottom: 8.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: devicewidth * 0.5,
                      child:
                          LookupCoordinate(report.latitude, report.longitude),
                    )
                  ],
                ),
                /*new Spacer(),
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: new Icon(Icons.clear,
                          size: 20.0, color: Colors.white70),
                    ),
                  ],
                ),*/
              ],
            ),
            new Spacer(),
            new Container(
                color: const Color(0xFF00C6FF),
                width: 36.0,
                height: 1.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0)),
            new Row(
              children: <Widget>[
                new Icon(Icons.access_time, size: 14.0, color: Colors.white70),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: new Text(
                    publishTime(report.time),
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                new Spacer(),
                GestureDetector(
                    child: Icon(Icons.location_on,
                        size: 30.0, color: Colors.red[300]),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              elevation: 16,
                              child: Container(
                                height: deviceheight,
                                width: devicewidth,
                                child: Scaffold(
                                  body: Map(controller: controller),
                                  floatingActionButton: FloatingActionButton(
                                    onPressed: _incrementCounter,
                                    tooltip: 'Location',
                                    child: Icon(Icons.location_searching),
                                  ),
                                ),
                              ));
                        },
                      );
                    }),
              ],
            )
          ],
        ),
      ),
    );

    return Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Stack(
        children: <Widget>[
          reportCard,
          reportThumbnail,
        ],
      ),
    );
  }
}
