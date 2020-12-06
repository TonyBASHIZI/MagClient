import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:MagClient/CustomAppBar.dart';
import 'package:MagClient/CustomShapeClipper.dart';
import 'package:MagClient/main.dart';
import 'package:MagClient/utils/config.dart';

import 'package:http/http.dart' as http;

import 'package:MagClient/trackItem.dart';

final Color discountBackgroungColor = Color(0xFFFF0000);
final Color flishBorderColor = Color(0xFFEF772C);
final Color chipBackgroundColor = Color(0xFFF6F6F6);

class FlightListingScreen extends StatefulWidget {
  @override
  _FlightListingScreenState createState() => _FlightListingScreenState();
}

class _FlightListingScreenState extends State<FlightListingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(253, 205, 107, 1),
        title: Text(
          "Seach Result",
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
            FlightListTopPart(),
            SizedBox(
              height: 20.0,
            ),
            FlishListBottomPart(),
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
                            "Nord-Kivu",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            height: 20.0,
                          ),
                          Text(
                            "RDC Goma City",
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

class FlishListBottomPart extends StatefulWidget {
  @override
  _FlishListBottomPartState createState() => _FlishListBottomPartState();
}

class _FlishListBottomPartState extends State<FlishListBottomPart> {
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
    await http.get(BaseUrl.getColi + "&clientID=1").then((response) {
      if (!(json.decode(response.body) is String)) {
        setState(() {
          responseData = json.decode(response.body);
          _listItems.clear();
        });
        for (var i = 0; i < responseData.length; i++) {
          setState(() {
            _listItems.add(FlightCardNew(
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
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "List tracking for this month",
              style: dropDownMenuItemStyle,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Column(
            children: _listItems,
          )
        ],
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Colors.black12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Code colis : SD-E-34-66-12',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      )
                    ],
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: -8.0,
                    children: <Widget>[
                      FlightDetailChip(Icons.calendar_today, 'June 2020'),
                      FlightDetailChip(Icons.flight_takeoff, 'Relais Ndosho'),
                      FlightDetailChip(Icons.flight_takeoff, 'Etat : Triage'),
                      FlightDetailChip(Icons.star, 'RDCongo Nord-kivu'),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlightCardNew extends StatelessWidget {
  final List coli;
  final int index;
  FlightCardNew({this.coli, this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    TrackItemPage(coli: coli, index: index)));
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
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
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "ID: ${coli[index]['code'].toString()}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      coli[index]['description'].toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Categorie: ${coli[index]['categorie'].toString()}",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                    Text(
                      "Pour: ${coli[index]['nomClient'].toString()}",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Etat: ${coli[index]['etat'].toString()}",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                    Text(
                      "Entre: ${coli[index]['savedDate'].toString()}",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlightDetailChip extends StatelessWidget {
  final IconData iconData;
  final String label;
  FlightDetailChip(this.iconData, this.label);
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
