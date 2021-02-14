import 'dart:convert';

import 'package:MagClient/track.dart';
import 'package:MagClient/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

import 'CustomShapeClipper.dart';

class services extends StatelessWidget {
  init() async {
    pref = await SharedPreferences.getInstance();
  }

  SharedPreferences pref;
  Future getBalance() async {
    var url = BaseUrl.getBalance;
    var response = await http.get(url);

    return jsonDecode(response.body);
  }

  List data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Mag services",
        ),
        elevation: 0.0,
        centerTitle: true,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
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
              height: 10.0,
            ),
            Container(
                padding: const EdgeInsets.all(15),
                height: 410.0,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(5),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.black45,
                              blurRadius: 3),
                        ],
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Mag Tech",
                            style: TextStyle(fontSize: 20, color: Colors.green),
                          ),
                          Icon(
                            Icons.laptop_mac,
                            size: 80,
                          ),
                          Text(
                            'Stations services & Carsh',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.black45,
                              blurRadius: 3),
                        ],
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Mag Travel",
                            style: TextStyle(fontSize: 20, color: Colors.green),
                          ),
                          Icon(
                            Icons.card_travel,
                            size: 80,
                          ),
                          Text(
                            'Achat & reservation billet de voyage',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Track()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Colors.black45,
                                blurRadius: 3),
                          ],
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Mag Courrier",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.green),
                            ),
                            Icon(
                              Icons.mail,
                              size: 80,
                            ),
                            Text(
                              'Recever & envoyer des courriers',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.black45,
                              blurRadius: 3),
                        ],
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Mag Security",
                            style: TextStyle(fontSize: 20, color: Colors.green),
                          ),
                          Icon(
                            Icons.security,
                            size: 80,
                          ),
                          Text(
                            'Securité numerique & physique',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ],
                ))
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
                            " Mangango groupe",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            height: 20.0,
                          ),
                          Text(
                            "vous offre plusieurs services",
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
                          Icons.local_laundry_service,
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
