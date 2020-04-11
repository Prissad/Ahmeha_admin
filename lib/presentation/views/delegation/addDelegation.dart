import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news_reader/core/api/api.dart';
import 'package:news_reader/presentation/views/detail/ReportPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddDelegation extends StatefulWidget {
  @override
  _AddDelegationState createState() => _AddDelegationState();
}

class _AddDelegationState extends State<AddDelegation> {
  bool _isLoading;

  TextEditingController gouvController = TextEditingController();
  TextEditingController delegController = TextEditingController();
  ScaffoldState scaffoldState;
  String deleg;
  String selectedIndexGouv;
  List<String> gouvernoratsName;

  @override
  void initState() {
    _isLoading = false;
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
    selectedIndexGouv = null;
    super.initState();
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
                            /////////////  gouvernorat //////////////
                            DropdownButton<String>(
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
                                selectedIndexGouv = value;
                              }),
                            ),

                            /////////////// delegation ////////////////////
                            TextFormField(
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              controller: delegController,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              autovalidate: true,
                              validator: (String value) {
                                if (value.length == 0) {
                                  return 'Ce champs est obligatoire';
                                }
                                return null; //aleh!
                              },
                              onChanged: (String value) {
                                setState(() {
                                  deleg = value;
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.perm_device_information,
                                  color: Colors.grey,
                                ),
                                hintText: "Délégation",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            /////////////  Submit Botton///////////////////
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      _isLoading ? 'Envoi...' : 'Envoyer',
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
                                      if (selectedIndexGouv == null) {
                                        Alert(
                                          context: context,
                                          type: AlertType.error,
                                          title:
                                              "Le choix du gouvernorat est obligatoire",
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
                                      } else if (deleg == null) {
                                        Alert(
                                          context: context,
                                          type: AlertType.error,
                                          title:
                                              "Le nom de la délégation est obligatoire",
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
                                        ajoutDelegation();
                                      }
                                    }
                                  }),
                            ),
                          ],
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
    ));
  }

  void ajoutDelegation() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> data = new Map<String, dynamic>();
    data = {'gouv': selectedIndexGouv, 'name': delegController.text};

    try {
      var res = await CallApi().postData(data, "/deleg");
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => ReportPage()));
    } catch (e, stacktrace) {
      print(stacktrace);
      Alert(
        context: context,
        type: AlertType.error,
        title: "Un problème est survenu lors de l'ajout",
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

    setState(() {
      _isLoading = false;
    });
  }
}
