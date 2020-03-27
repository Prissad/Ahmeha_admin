import 'package:flutter/material.dart';
import 'package:news_reader/presentation/views/home/animation.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirmer?'),
            content: new Text("Désirez-vous quitter l'application"),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Non'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Oui'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
            child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: makeBody(context),
        )));
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

    return Container(
        decoration: new BoxDecoration(
          image: backgroundImage,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(height: 150),
                    Container(
                      child: new Text(
                        "Billkamcha",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new Text(
                      "Covid-19",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: deviceHeight * 0.1),
                    Center(
                      child: AnimatedButton(),
                    ),
                  ]),
              SizedBox(height: deviceHeight * 0.2),
              Container(
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
            ]));

    // return Stack(
    //   children: <Widget>[
    //     Container(

    //       decoration: new BoxDecoration(
    //         image: backgroundImage,
    //       ),
    //       child:
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //      Center(
    //             child: AnimatedButton()
    //             ),
    //               ],
    //     Positioned(
    //       top: deviceHeight * 0.6,
    //       child: Container(
    //         width: deviceWidth,
    //         color: Color.fromRGBO(255, 255, 255, 0.8),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: <Widget>[
    //             new Image.asset(
    //               "assets/ministere.png",
    //               width: deviceWidth * 0.15,
    //               height: deviceHeight * 0.15,
    //             ),
    //             new Image.asset(
    //               "assets/junior2.png",
    //               width: deviceWidth * 0.15,
    //               height: deviceHeight * 0.15,
    //             ),
    //             new Image.asset(
    //               "assets/logo.png",
    //               width: deviceWidth * 0.15,
    //               height: deviceHeight * 0.15,
    //             ),
    //             new Image.asset(
    //               "assets/obs.png",
    //               width: deviceWidth * 0.15,
    //               height: deviceHeight * 0.15,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),

    //   ],
    // );
  }
}
