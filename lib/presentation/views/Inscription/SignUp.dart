import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_reader/core/api/api.dart';
import 'package:news_reader/presentation/views/detail/ReportPage.dart';
import 'package:news_reader/presentation/views/home/Home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// import 'package:tutorial_project/Home/homeScreen.dart';
// import 'package:tutorial_project/Login/loginScreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tutorial_project/api/api.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String cin;
  String nom;
  String email;
  String mdp;
  String numb;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            /////////////  background/////////////
            new Container(
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
            ),

            Positioned(
              // top:deviceHeight*0.1,
              // right: deviceWidth*0.005,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
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
                            /////////////// ID////////////
                            TextFormField(
                              style: TextStyle(color: Color(0xFF000000)),
                              controller: idController,
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.number,
                              autovalidate: true,
                              validator: (String value) {
                                if (value.length == 0) {
                                  return 'Ce champs est obligatoire';
                                }
                                return null;
                              },
                              onChanged: (String value) {
                                setState(() {
                                  cin = value;
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.card_membership,
                                  color: Colors.grey,
                                ),
                                hintText: "CIN",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            /////////Name////////
                            TextFormField(
                              style: TextStyle(color: Color(0xFF000000)),
                              controller: nameController,
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              autovalidate: true,
                              validator: (String value) {
                                if (value.length == 0) {
                                  return 'Ce champs est obligatoire';
                                }
                                return null;
                              },
                              onChanged: (String value) {
                                setState(() {
                                  nom = value;
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                hintText: "Nom",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),

                            /////////////// Email ////////////
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
                                  Icons.mail,
                                  color: Colors.grey,
                                ),
                                hintText: "Email ",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),

                            /////////////// password ////////////
                            TextFormField(
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              autovalidate: true,
                              validator: (String value) {
                                if (value.length == 0) {
                                  return 'Ce champs est obligatoire';
                                }
                                return null;
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
                            ///////Numero de telephone/////
                            TextFormField(
                              style: TextStyle(color: Color(0xFF000000)),
                              controller: phoneController,
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.phone,
                              autovalidate: true,
                              validator: (String value) {
                                if (value.length == 0) {
                                  return 'Ce champs est obligatoire';
                                }
                                return null;
                              },
                              onChanged: (String value) {
                                setState(() {
                                  numb = value;
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mobile_screen_share,
                                  color: Colors.grey,
                                ),
                                hintText: "Numéro de téléphone",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),

                            /////////////// SignUp Button ////////////
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      _isLoading
                                          ? 'Creation en cours...'
                                          : 'Créer un compte',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  color: Colors.red,
                                  disabledColor: Colors.grey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    if (!_isLoading) {
                                      if (cin == null) {
                                        Alert(
                                          context: context,
                                          type: AlertType.error,
                                          title: "Le CIN est obligatoire",
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
                                      } else if (nom == null) {
                                        Alert(
                                          context: context,
                                          type: AlertType.error,
                                          title: "Le nom est obligatoire",
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
                                      } else if (email == null) {
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
                                      } else if (numb == null) {
                                        Alert(
                                          context: context,
                                          type: AlertType.error,
                                          title:
                                              "Le numéro de téléphone est obligatoire",
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
                                        // Future.delayed(
                                        //   const Duration(milliseconds: 500), () {
                                        _handleLogin();
                                        // }
                                        // );
                                      }
                                      ;
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /////////////// already have an account ////////////
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           new MaterialPageRoute(
                    //               builder: (context) => LogIn()));
                    //     },
                    //     child: Text(
                    //       'Avez-vous deja un compte?',
                    //       textDirection: TextDirection.ltr,
                    //       style: TextStyle(
                    //         fontStyle: FontStyle.italic,
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
    );
  }

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> data = new Map<String, dynamic>();
    data = {
      'email': mailController.text,
      'name': nameController.text,
      'phone': phoneController.text,
      'cin': idController.text,
      'password': passwordController.text,
    };

    try {
      var res = await CallApi().postData(data, "/signup");
    } catch (e) {}
    /*var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));*/

    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ReportPage()));
    //}

    setState(() {
      _isLoading = false;
    });
  }
}
