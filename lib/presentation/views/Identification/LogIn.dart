import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_reader/core/api/api.dart';
import 'package:news_reader/presentation/views/detail/ReportPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// import 'package:tutorial_project/Home/homeScreen.dart';
// import 'package:tutorial_project/SignUp/signUpScreen.dart';
// import 'package:tutorial_project/api/api.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  static String connectedEmail = "";
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _isLoading = false;

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScaffoldState scaffoldState;
  String email;
  String mdp;
  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Fermer',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            ///////////  background///////////
            new Container(
              color: Color(0xff2e4057),
              /*  decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.4, 0.9],
                  colors: [
                    /* Colors.teal,
                    Color.fromRGBO(60, 157, 155, 1),
                    Color(0xFFFF3F1A),*/
                    Color(0xfffcae1e),
                    Color(0xffbe5504),
                    Color(0xff813f0b),
                  ],
                ),
              ),*/
            ),

            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 140.0),
                child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 4.0,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /////////////  Email//////////////
                            TextFormField(
                              style: TextStyle(color: Color(0xFF000000)),
                              controller: mailController,
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.emailAddress,
                              autovalidate: true,
                              validator: (String value) {
                                if (value.length == 0) {
                                  return 'Ce champs est obligatoire';
                                }
                                return null;
                              },
                              onChanged: (String value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),

                            /////////////// password////////////////////
                            TextFormField(
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              autovalidate: true,
                              validator: (String value) {
                                if (value.length == 0) {
                                  return 'Ce champs est obligatoire';
                                }
                                return null; //aleh!
                              },
                              onChanged: (String value) {
                                setState(() {
                                  mdp = value;
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.grey,
                                ),
                                hintText: "Mot de passe",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            /////////////  LogIn Botton///////////////////
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      _isLoading
                                          ? 'Connexion...'
                                          : 'Se connecter',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  color: Color(0xff048ba8),
                                  disabledColor: Colors.grey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    if (!_isLoading) {
                                      if (email == null) {
                                        Alert(
                                          context: context,
                                          type: AlertType.error,
                                          title: "L'email est obligatoire",
                                          desc: "Merci de remplir le champ",
                                          buttons: [
                                            DialogButton(
                                                child: Text("Fermer"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromRGBO(
                                                          116, 116, 191, 1.0),
                                                      Color.fromRGBO(
                                                          52, 138, 199, 1.0)
                                                    ])),
                                          ],
                                        ).show();
                                      } else if (mdp == null) {
                                        Alert(
                                          context: context,
                                          type: AlertType.error,
                                          title:
                                              "Le mot de passe est obligatoire",
                                          desc: "Merci de remplir le champ",
                                          buttons: [
                                            DialogButton(
                                                child: Text("Fermer"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromRGBO(
                                                          116, 116, 191, 1.0),
                                                      Color.fromRGBO(
                                                          52, 138, 199, 1.0)
                                                    ])),
                                          ],
                                        ).show();
                                      } else {
                                        _login();
                                      }
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ////////////   new account///////////////
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           new MaterialPageRoute(
                    //               builder: (context) => SignUp()));
                    //     },
                    //     child: Text(
                    //       'Créer un nouveau compte',
                    //       textDirection: TextDirection.ltr,
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 15.0,
                    //         decoration: TextDecoration.none,
                    //         fontWeight: FontWeight.normal,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> data = new Map<String, dynamic>();
    data = {'email': mailController.text, 'password': passwordController.text};

    try {
      var res = await CallApi().postData(data, "/login");
      LogIn.connectedEmail = data['email'];
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => ReportPage()));
    } catch (e, stacktrace) {
      print(stacktrace);
      Alert(
        context: context,
        type: AlertType.error,
        title: "Email ou mot de passe incorrect",
        desc: "Veuillez réessayer !",
        buttons: [
          DialogButton(
              child: Text("Fermer"),
              onPressed: () {
                Navigator.pop(context);
              },
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0)
              ])),
        ],
      ).show();
    }
    // var body = json.decode(res.body);
    // if(body['success']){
    //   SharedPreferences localStorage = await SharedPreferences.getInstance();
    //   localStorage.setString('token', body['token']);
    //   localStorage.setString('user', json.encode(body['user']));
    //   Navigator.push(
    //     context,
    //     new MaterialPageRoute(
    //         builder: (context) => Home()));
    // }else{
    //   _showMsg(body['message']);
    // }

    setState(() {
      _isLoading = false;
    });
  }
}
