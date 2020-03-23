import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Billkamcha",
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: makeBody(context),
    ));
  }

  Widget makeBody(BuildContext context) {
    DecorationImage backgroundImage = new DecorationImage(
      image: new ExactAssetImage('assets/images/corona.jpg'),
      colorFilter: new ColorFilter.mode(
          Color(0xFFFF3F1A).withOpacity(0.2), BlendMode.color),
      fit: BoxFit.cover,
    );

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          // width: devicewidth,
          // height: deviceheight,
          // color: Colors.black87,
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: <Widget>[
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>[
          //         Image.asset(
          //           'assets/images/home_image.png',
          //           width: devicewidth,
          //         ),
          //       ],
          //     ),
          decoration: new BoxDecoration(
            image: backgroundImage,
          ),
          child:
              // Column(
              //     children: <Widget>[
              Container(
            decoration: new BoxDecoration(
                //   gradient: new LinearGradient(
                // colors: <Color>[
                //   const Color.fromRGBO(162, 146, 199, 0.8),
                //   const Color.fromRGBO(51, 51, 63, 0.9),
                // ],
                // stops: [0.2, 1.0],
                // begin: const FractionalOffset(0.0, 0.0),
                // end: const FractionalOffset(0.0, 1.0),
                ),
          ),
          // ),
        ),
        Positioned(
          top: deviceHeight * 0.2,
          left: deviceWidth * 0.35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                color: Colors.grey[300],
                onPressed: () {
                  Navigator.pushNamed(context, '/signUp');
                },
                child: Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: deviceHeight * 0.6,
          child: Container(
            width: deviceWidth,
            color: Color.fromRGBO(255, 255, 255, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Image.asset(
                  "assets/ministere.png",
                  width: deviceWidth * 0.15,
                  height: deviceHeight * 0.15,
                ),
                new Image.asset(
                  "assets/junior2.png",
                  width: deviceWidth * 0.15,
                  height: deviceHeight * 0.15,
                ),
                new Image.asset(
                  "assets/logo.png",
                  width: deviceWidth * 0.15,
                  height: deviceHeight * 0.15,
                ),
                new Image.asset(
                  "assets/obs.png",
                  width: deviceWidth * 0.15,
                  height: deviceHeight * 0.15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
