import 'dart:convert';

import 'package:MagClient/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

import 'CustomShapeClipper.dart';

class balance extends StatelessWidget {
  init() async {
    pref = await SharedPreferences.getInstance();
  }

  SharedPreferences pref;
  Future getBalance() async {
    var url = BaseUrl.getBalance;
    var response = await http.get(url);

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Balance carte",
        ),
        elevation: 0.0,
        centerTitle: true,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            FlightListTopPart(),
            SizedBox(
              height: 20.0,
            ),
            formExpedier(),
          ],
        ),
      ),
    );
  }
}

class FlightListTopPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [firstColor, secondColor]),
            ),
            height: 160.0,
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              elevation: 10.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Balance compte MagTech",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            height: 20.0,
                          ),
                          Text(
                            "Gagnez de l'argent en utilisant nos services",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.import_export,
                          color: Colors.black,
                          size: 24.0,
                        )),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class formExpedier extends StatelessWidget {
  init() async {
    pref = await SharedPreferences.getInstance();
  }

  SharedPreferences pref;
  final pwdController = TextEditingController();
  final matController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // pwdController.dispose();
    init();
    bool isSaving = false;
    dialog() => showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: Container(
                  height: 120,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.black45,
                          blurRadius: 3)
                    ],
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green,
                  ),
                  child: new Text(
                    "Matricule ${pref.getString("mat")} solde du compte est de \n 00 fc ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )),
              actions: <Widget>[
                isSaving == false
                    ? Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Colors.black45,
                                blurRadius: 2)
                          ],
                        ),
                        child: new FlatButton(
                          child: new Text(
                            "Fermer",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            // matController.dispose();
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    : CircularProgressIndicator(),
              ],
            );
          },
        );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0), color: Colors.black45, blurRadius: 3)
              ],
              color: Colors.white,
            ),
            child: TextField(
              controller: matController,
              style: dropDownMenuItemStyle,
              obscureText: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                icon: Icon(Icons.text_fields),
                labelText: "Matricule du compte",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                suffixIcon: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  child: InkWell(
                    onTap: () async {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             FlightListingScreen())
                      //             );
                    },
                    child: Icon(
                      Icons.credit_card,
                      color: Colors.black,
                    ),
                  ),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.black45,
                      blurRadius: 3)
                ],
                color: Colors.white),
            child: TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.security),
                  labelText: "Mot de passe",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0)),
              controller: pwdController,
              style: dropDownMenuItemStyle,
              cursorColor: appTheme.primaryColor,
              keyboardType: TextInputType.text,
              obscureText: true,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 55, 0, 0),
            width: 500,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.black45,
                      blurRadius: 3)
                ],
                color: Colors.green),
            child: FlatButton(
              onPressed: () {
                pref.setString("mat", matController.text);
                dialog();
              },
              child: Text("Soumettre",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          )
        ],
      ),
    );
  }
}
