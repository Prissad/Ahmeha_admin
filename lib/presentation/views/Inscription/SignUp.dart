import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _isLoading;
  String selectedIndexGouv;
  String selectedIndexDeleg;
  List<String> gouvernoratsName;
  List<String> delegationsName;
  List<DropdownMenuItem<String>> delegationsList;
  bool first;
  Pattern pattern;
  RegExp regex;

  @override
  void initState() {
    first = true;
    _isLoading = false;
    pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    regex = new RegExp(pattern);
    gouvernoratsName = [
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
    //selectedIndexGouv = gouvernoratsName[0];
    delegationsName = new List<String>();
    delegationsList = new List<DropdownMenuItem<String>>();
    //addDelegations(selectedIndexGouv);
    //selectedIndexDeleg = delegationsName[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            /////////////  background/////////////
            new Container(
              color: Color(0xff2e4057),
              /*decoration: new BoxDecoration(
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
              ),*/
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

                          children: (first)
                              ? <Widget>[
                                  /////////////// CIN ////////////
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
                                      if (value.length != 8)
                                        return 'Un numéro de CIN doit être composé de 8 chiffres';
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
                                      if (!regex.hasMatch(value)) {
                                        return 'Entrer un email valide';
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
                                      if (value.length != 8)
                                        return 'Un numéro de téléphone doit être composé de 8 chiffres';
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

                                  ///
                                  Container(
                                    height: 20,
                                  ),
                                  //////////////// Gouvernorat //////////////
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'Gouvernorat :',
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )),
                                  DropdownButton<String>(
                                    elevation: 16,
                                    hint: Text("Gouvernorat"),
                                    isExpanded: true,
                                    value: (selectedIndexGouv != null)
                                        ? selectedIndexGouv
                                        : null,
                                    items: gouvernoratsName
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value, child: Text(value));
                                    }).toList(),
                                    onChanged: (String value) => setState(() {
                                      addDelegations(value);
                                      selectedIndexGouv = value;
                                      selectedIndexDeleg = null;
                                      /*SystemChannels.textInput
                                    .invokeMethod('TextInput.show');
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');*/

                                      //selectedIndexDeleg = delegationsName[0];
                                    }),
                                  ),
                                  /////////////// Next Button ////////////
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: FlatButton(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8,
                                                bottom: 8,
                                                left: 10,
                                                right: 10),
                                            child: Text(
                                              'Suivant',
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
                                                  new BorderRadius.circular(
                                                      20.0)),
                                          onPressed: () {
                                            setState(() {
                                              first = false;
                                            });
                                          })),
                                ]
                              ///////////////////////////////////////Page 2!!! /////////////////////////////////////////////////////
                              : <Widget>[
                                  ///
                                  Container(
                                    height: 40,
                                  ),
                                  //////////////// Delegation //////////////
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Délégation :',
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )),
                                  DropdownButton<String>(
                                    disabledHint:
                                        Text("Veuillez choisir un gouvernorat"),
                                    hint: Text("Délégation"),
                                    isExpanded: true,
                                    value: (selectedIndexDeleg != null)
                                        ? selectedIndexDeleg
                                        : null,
                                    items: delegationsList,
                                    autofocus: true,
                                    onChanged: (String value) {
                                      setState(() {
                                        selectedIndexDeleg = value;
                                      });
                                    },
                                  ),

                                  ///
                                  Container(
                                    height: 30,
                                  ),

                                  /////////////// Back + SignUp Buttons ////////////
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(children: <Widget>[
                                      FlatButton(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8,
                                                bottom: 8,
                                                left: 10,
                                                right: 10),
                                            child: Text(
                                              'Précédent',
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
                                                  new BorderRadius.circular(
                                                      20.0)),
                                          onPressed: () {
                                            setState(() {
                                              first = true;
                                            });
                                          }),
                                      FlatButton(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8,
                                                bottom: 8,
                                                left: 10,
                                                right: 10),
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
                                          color: Color(0xff048ba8),
                                          disabledColor: Colors.grey,
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      20.0)),
                                          onPressed: () {
                                            if (!_isLoading) {
                                              if (cin == null ||
                                                  cin.length != 8) {
                                                Alert(
                                                  context: context,
                                                  type: AlertType.error,
                                                  title:
                                                      "Le CIN est obligatoire",
                                                  desc:
                                                      "Merci de saisir une valeur valide",
                                                  buttons: [
                                                    DialogButton(
                                                        child: Text("Fermer"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Color.fromRGBO(
                                                                  116,
                                                                  116,
                                                                  191,
                                                                  1.0),
                                                              Color.fromRGBO(52,
                                                                  138, 199, 1.0)
                                                            ])),
                                                  ],
                                                ).show();
                                              } else if (nom == null) {
                                                Alert(
                                                  context: context,
                                                  type: AlertType.error,
                                                  title:
                                                      "Le nom est obligatoire",
                                                  desc:
                                                      "Merci de remplir le champ",
                                                  buttons: [
                                                    DialogButton(
                                                        child: Text("Fermer"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Color.fromRGBO(
                                                                  116,
                                                                  116,
                                                                  191,
                                                                  1.0),
                                                              Color.fromRGBO(52,
                                                                  138, 199, 1.0)
                                                            ])),
                                                  ],
                                                ).show();
                                              } else if (email == null ||
                                                  !regex.hasMatch(email)) {
                                                Alert(
                                                  context: context,
                                                  type: AlertType.error,
                                                  title:
                                                      "L'email est obligatoire",
                                                  desc:
                                                      "Merci de saisir une adresse mail valide",
                                                  buttons: [
                                                    DialogButton(
                                                        child: Text("Fermer"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Color.fromRGBO(
                                                                  116,
                                                                  116,
                                                                  191,
                                                                  1.0),
                                                              Color.fromRGBO(52,
                                                                  138, 199, 1.0)
                                                            ])),
                                                  ],
                                                ).show();
                                              } else if (mdp == null) {
                                                Alert(
                                                  context: context,
                                                  type: AlertType.error,
                                                  title:
                                                      "Le mot de passe est obligatoire",
                                                  desc:
                                                      "Merci de remplir le champ",
                                                  buttons: [
                                                    DialogButton(
                                                        child: Text("Fermer"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Color.fromRGBO(
                                                                  116,
                                                                  116,
                                                                  191,
                                                                  1.0),
                                                              Color.fromRGBO(52,
                                                                  138, 199, 1.0)
                                                            ])),
                                                  ],
                                                ).show();
                                              } else if (numb == null ||
                                                  numb.length != 8) {
                                                Alert(
                                                  context: context,
                                                  type: AlertType.error,
                                                  title:
                                                      "Le numéro de téléphone est obligatoire",
                                                  desc:
                                                      "Merci de saisir un numéro de téléphone valide",
                                                  buttons: [
                                                    DialogButton(
                                                        child: Text("Fermer"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Color.fromRGBO(
                                                                  116,
                                                                  116,
                                                                  191,
                                                                  1.0),
                                                              Color.fromRGBO(52,
                                                                  138, 199, 1.0)
                                                            ])),
                                                  ],
                                                ).show();
                                              } else if (selectedIndexGouv ==
                                                  null) {
                                                Alert(
                                                  context: context,
                                                  type: AlertType.error,
                                                  title:
                                                      "Le gouvernorat est obligatoire",
                                                  desc:
                                                      "Merci de saisir le champ",
                                                  buttons: [
                                                    DialogButton(
                                                        child: Text("Fermer"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Color.fromRGBO(
                                                                  116,
                                                                  116,
                                                                  191,
                                                                  1.0),
                                                              Color.fromRGBO(52,
                                                                  138, 199, 1.0)
                                                            ])),
                                                  ],
                                                ).show();
                                              } else if (selectedIndexDeleg ==
                                                  null) {
                                                Alert(
                                                  context: context,
                                                  type: AlertType.error,
                                                  title:
                                                      "Le gouvernorat est obligatoire",
                                                  desc:
                                                      "Merci de saisir le champ",
                                                  buttons: [
                                                    DialogButton(
                                                        child: Text("Fermer"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Color.fromRGBO(
                                                                  116,
                                                                  116,
                                                                  191,
                                                                  1.0),
                                                              Color.fromRGBO(52,
                                                                  138, 199, 1.0)
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
                                    ]),
                                  )
                                ],
                          /////////////////////
                        ),
                      ),
                    ),
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
      'gouv': selectedIndexGouv,
      'deleg': selectedIndexDeleg,
    };

    try {
      var res = await CallApi().postData(data, "/signup");
    } catch (e) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Une erreur est survenue lors de la création de compte",
        desc: "Merci de réessayer",
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

    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ReportPage()));
    //}

    setState(() {
      _isLoading = false;
    });
  }

  void addDelegations(gouv) async {
    Response res = await CallApi().getDelegations(gouv, "/getdeleg");
    final List<dynamic> parsed = res.data;
    if (delegationsName.length > 0) {
      delegationsName.clear();
    }
    for (var i = 0; i < parsed.length; i++) {
      delegationsName.add(parsed[i]['name']);
    }
    delegationsList =
        delegationsName.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(value: value, child: Text(value));
    }).toList();
  }
}
