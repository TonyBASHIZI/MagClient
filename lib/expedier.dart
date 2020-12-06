import 'package:flutter/material.dart';
import 'main.dart';

import 'CustomShapeClipper.dart';

class expedier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar( 
        backgroundColor: Color.fromRGBO(253, 205, 107, 1),
        
        title: Text(
          "Expedier",
         
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
            SizedBox(height: 20.0,),
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
            decoration: BoxDecoration(gradient: LinearGradient(
              colors: [firstColor, secondColor]
              ),
              ),
              height: 160.0,
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                           Text("Estimer prix",
                       style: TextStyle(
                         fontSize: 16.0,
                       ),
                       ),
                       Divider(color: Colors.grey,height: 20.0,),
                       Text("de l'expedition", 
                       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                       ),
                         ],
                       ),
                     ),
                     Spacer(),
                     Expanded(
                       flex: 1,
                       child: Icon(Icons.import_export, color: Colors.black, size: 24.0,)),
                   ],
                 ),
              ) ,
            ),
          ],
        )
      ],

    );
  }
}
class formExpedier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin :EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
      
        children: <Widget>[
        
          TextField(       
              controller: TextEditingController(
                  text: "Pays",
                     
              ),
               style: dropDownMenuItemStyle,
               cursorColor: appTheme.primaryColor,
          ),
          TextField(       
              controller: TextEditingController(
                  text: "Ville",
                     
              ),
              
               style: dropDownMenuItemStyle,
               cursorColor: appTheme.primaryColor,
          ),
          TextField(       
              controller: TextEditingController(
                  text: "Categorie coli",
                     
              ),
               style: dropDownMenuItemStyle,
               cursorColor: appTheme.primaryColor,
          ),
        ],
      ),
    );
  }
}