import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news_reader/presentation/views/Identification/LogIn.dart';
import 'package:news_reader/presentation/views/detail/ReportPage.dart';

class AnimatedButton extends StatefulWidget {
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) async {
    _controller.reverse();

    final data = await testConnected();
    if (data != "") {
      LogIn.connectedEmail = data;
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => ReportPage()));
    } else {
      LogIn.connectedEmail = "";
      Navigator.pushNamed(context, "/logIn");
    }

    //Navigator.pushNamed(context, "/logIn");
  }

  Future<String> testConnected() async {
    var storage = FlutterSecureStorage();
    var jwt = await storage.read(key: "connected");
    if (jwt == null) return (Future.value(""));
    var mail = await storage.read(key: "mail");
    return (Future.value(mail));
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(
        scale: _scale,
        child: _animatedButtonUI,
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Color(0x80000000),
                blurRadius: 30.0,
                offset: Offset(0.0, 30.0),
              ),
            ],
            //color: Color(0xff1f4887),
            gradient: RadialGradient(colors: [
              Color(0xff1f4887),
              Color(0xff7bbdd1),
            ], focal: Alignment.center, radius: 2.1, tileMode: TileMode.clamp)
            /* LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Colors.red[800],
              Colors.indigo[400],
              //  Colors.teal,
              /*Color.fromRGBO(60, 157, 155, 1),
              Color(0xFFFF3F1A),*/
              // Colors.white,
              // Colors.grey,
            ],
          ),*/
            ),
        child: Center(
          child: Text(
            'Commençons !',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
}
