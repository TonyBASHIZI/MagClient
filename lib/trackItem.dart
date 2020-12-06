import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:MagClient/CustomAppBar.dart';
import 'package:MagClient/CustomShapeClipper.dart';
import 'package:MagClient/main.dart';
import 'package:MagClient/utils/config.dart';

import 'package:http/http.dart' as http;

class TrackItemPage extends StatefulWidget {
  final List coli;
  final int index;
  TrackItemPage({this.coli, this.index});
  @override
  _TrackItemPageState createState() => _TrackItemPageState();
}

class _TrackItemPageState extends State<TrackItemPage> {
  @override
  void initState() {
    super.initState();
    _getColi();
  }

  List<Widget> _listItems = new List<Widget>();
  List responseData = new List();

  _getColi() async {
    setState(() {
      responseData.clear();
      _listItems.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 20,
          ),
          Text(
            "Loading...",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ));
    });
    await http
        .get(BaseUrl.getColi +
            "&idColi=" +
            widget.coli[widget.index]["code"].toString().trim())
        .then((response) {
      if (!(json.decode(response.body) is String)) {
        setState(() {
          responseData = json.decode(response.body);
          _listItems.clear();
        });
        for (var i = 0; i < responseData.length; i++) {
          setState(() {
            _listItems.add(SingleItemTrack(
              coli: responseData,
              index: i,
            ));
            // _listItems.add(FlightCard());
          });
        }
        // print("added items:" + _listItems.length.toString());
      } else {
        print(response.body);
        setState(() {
          _listItems.clear();
          _listItems.add(Container(
            child: Container(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(Icons.delete_sweep, size: 70, color: Colors.grey),
                  Text("No data found",
                      style: TextStyle(color: Colors.grey, fontSize: 16))
                ],
              ),
            ),
          ));
        });
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(253, 205, 107, 1),
        title: Text(
          widget.coli[widget.index]['description'].toString(),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/cause-5.jpg"),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              )),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          // color: Color.fromRGBO(0, 0, 0, 0.5),
                          gradient: LinearGradient(
                        colors: [
                          Colors.black54,
                          Colors.black12,
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "ID: ${widget.coli[widget.index]['code'].toString()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            widget.coli[widget.index]['description'].toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Entre: ${widget.coli[widget.index]['savedDate'].toString()}",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white60),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        color: Colors.black26,
                        blurRadius: 1)
                  ]),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.category, color: Colors.grey),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Categorie",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                          "${widget.coli[widget.index]['categorie'].toString()}",
                          style: TextStyle(fontWeight: FontWeight.w500))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.person, color: Colors.grey),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Destinataire",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                          "${widget.coli[widget.index]['nomClient'].toString()}",
                          style: TextStyle(fontWeight: FontWeight.w500))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.straighten, color: Colors.grey),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Etat",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Text("${widget.coli[widget.index]['etat'].toString()}",
                          style: TextStyle(fontWeight: FontWeight.w500))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(230,230,230,1),
                borderRadius: BorderRadius.circular(5)
              ),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(
                  "Tracking",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                )),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: _listItems,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SingleItemTrack extends StatelessWidget {
  final List coli;
  final int index;
  SingleItemTrack({this.coli, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${coli[index]['dateTransact'].toString()}",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Etat : ${coli[index]['statut'].toString()}",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
          ),
          Text(
            "Vers : ${coli[index]['nextRelais'] != null ? coli[index]['nextRelais'].toString() : ''}",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black),
          ),
          Divider(
            height: 2,
            // color: Colors.grey,
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}

class FlightDetailChip extends StatelessWidget {
  final IconData iconData;
  final String label;
  FlightDetailChip(this.iconData, this.label);
  final Color chipBackgroundColor = Color(0xFFF6F6F6);
  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(label),
      labelStyle: TextStyle(color: Colors.black, fontSize: 14.0),
      backgroundColor: chipBackgroundColor,
      avatar: Icon(
        iconData,
        size: 14.0,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}
