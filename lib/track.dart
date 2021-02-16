import 'dart:convert';

import 'package:MagClient/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

import 'CustomShapeClipper.dart';

class Track extends StatefulWidget {
  @override
  _TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {
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
          "Mag courrier tracking",
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
            GestureDetector(
                onTap: () async {
                  final response = await http.post(BaseUrl.url + 'get_data.php',
                      body: {'transaction': 'getcolis', 'cardID': '+243973697114'});
                  // print(response.body);
                  List res = jsonDecode(response.body);
                  setState(() {
                    if (res.isNotEmpty) {
                      data = jsonDecode(response.body);
                    }
                  });
                },
                child: FlightListTopPart()),
            SizedBox(
              height: 10.0,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: data.length > 0 ? data.length : 1,
                itemBuilder: (context, int index) {
                  return data.length > 0
                      ? Container(
                         decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.black,
                              blurRadius: 4)
                        ],
                      ),
                          width: double.maxFinite,
                          height: 150,
                          // color: Colors.white,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "CODE COLI : ${data[index]['id']}\n DESCRIPTION : ${data[index]['designation']} \n EXP : ${data[index]['exp']} \n DEST : ${data[index]['dest']} \n Tel DEST : ${data[index]['tel']} \n VILLE SORTIE : ${data[index]['sortie']} \n VILLE ARRIVEE : ${data[index]['entree']}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Container(
                          width: double.maxFinite,
                          height: 200,
                          color: Colors.white54,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Veuillez saisir CODE du coli ou Numero de telephone sur le champs au dessus pour avoir les informations sur le coli!",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                })
          ],
        ),
      ),
    );
  }
}

class FlightListTopPart extends StatefulWidget {
  @override
  _FlightListTopPartState createState() => _FlightListTopPartState();
}

class _FlightListTopPartState extends State<FlightListTopPart> {
  final textController = TextEditingController();
  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
     List data = [];
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
                          
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.black,
                              blurRadius: 3)
                        ],
                            ),
                            child: isSaving == false
                ? FlatButton(onPressed: null, 
                            child: Text("Soumettre",
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                            
                            ): Center(child: CircularProgressIndicator()),
                          ),
                          Divider(
                            color: Colors.grey,
                            height: 20.0,
                          ),
                          TextField(
              controller: textController,
              style: dropDownMenuItemStyle,
              obscureText: false,
              textAlign: TextAlign.center,

              decoration: InputDecoration(
                icon: Icon(Icons.text_fields),
                labelText: "Tapez ici le code",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                suffixIcon: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                    
                  ),
                  child: InkWell(
                  
                          onTap: () async {
                      final response = await http.post(BaseUrl.url + 'get_data.php',
                      body: {'transaction': 'getcolis', 'cardID': '${textController.toString().trim()}'});
                  // print(response.body);
                  List res = jsonDecode(response.body);
                  setState(() {
                    if (res.isNotEmpty) {
                      data = jsonDecode(response.body);
                    }
                  });
                    },
                          child: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.black,
                      ),    
                  ),
                ),
                // border: InputBorder.none,
              ),
            ),
                        ],
                      ),
                    ),
                  
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
