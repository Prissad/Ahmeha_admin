import 'dart:convert';

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
      //controller.zoom = 22;
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

    CircleAvatar reportImage(url) {
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

    final reportCard = new GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 60.0, right: 16.0),
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.4, 0.9],
            colors: [
              /*Color(0xFF650D1B),
              Color(0xFF650D1B),
              Color(0xFF650D1B),*/
              Color(0xFF008FBB),
              Color(0xFF008FBB),
              Color(0xFF008FBB),
              //Color(0xFF00AFE0),
            ],
          ),
          //color: /*Colors.teal*/ Color(0xFFBB86FC),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(6.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: Colors.black,
                blurRadius: 10.0,
                offset: new Offset(10.0, 10.0))
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
              Row(
                children: <Widget>[
                  Container(
                    width: devicewidth * 0.55,
                    //   height: deviceheight * 0.055,
                    child: Text(
                      'Type : ' + report.type,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: devicewidth * 0.55,
                    //   height: deviceheight * 0.055,
                    child: Text(
                      (report.description != null)
                          ? report.description
                          : 'pas de description',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                  )
                ],
              ),
              new Spacer(),
              new Container(
                  color: const Color(0xFF00C6FF),
                  width: 36.0,
                  height: 1.0,
                  margin: const EdgeInsets.symmetric(vertical: 1.0)),
              new Row(
                children: <Widget>[
                  new Icon(Icons.access_time,
                      size: 14.0, color: Colors.white70),
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
                          size: 25.0, color: Colors.red[300]),
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
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
                elevation: 16,
                child: Container(
                  height: deviceheight * 0.5,
                  width: devicewidth * 0.75,
                  decoration: new BoxDecoration(
                    color: /*Color(0xFF70012b)*/ Color(0xFFcf6679),
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(3.0),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                          color: Colors.black,
                          blurRadius: 5.0,
                          offset: new Offset(10.0, 15.0))
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: new BoxDecoration(
                              color: /*Color(0xff941242)*/ Color(0xFFcf6679),
                              shape: BoxShape.rectangle,
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            height: deviceheight * 0.1,
                            width: devicewidth * 0.65,
                            margin: const EdgeInsets.all(10),
                            child: Center(
                                child: LookupCoordinate(
                                    report.latitude, report.longitude)),
                          )
                        ],
                      ),
                      new Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              color: const Color(0xFFb00020),
                              width: devicewidth * 0.75 - 40,
                              height: 1.0,
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20)),
                        ],
                      ),
                      //new Spacer(),
                      Row(
                        children: <Widget>[
                          Container(
                              height: deviceheight * 0.3,
                              width: devicewidth * 0.65,
                              margin: const EdgeInsets.all(10),
                              decoration: new BoxDecoration(
                                color: /*Color(0xff941242)*/ Color(0xFFcf6679),
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(6.0),
                              ),
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Text(
                                    'Type : ' +
                                        report.type +
                                        '\nDistance : ' +
                                        ((report.distance != null)
                                            ? (report.distance / 1000)
                                                    .round()
                                                    .toString() +
                                                ' km'
                                            : "la distance n'a pas pu être calculée") +
                                        '\nDescription : ' +
                                        ((report.description != null)
                                            ? report.description
                                            : 'pas de description'),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 30,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ));
          },
        );
      },
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
