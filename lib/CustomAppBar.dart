import 'package:MagClient/balance.dart';
import 'package:flutter/material.dart';
import 'package:MagClient/partenaire.dart';
import 'services.dart';
import 'main.dart';

class CustomAppBar extends StatelessWidget {
   BuildContext context;
  final List<BottomNavigationBarItem> bottomBarItems = [];
  final bottomNavigationBarItemStyle =
      TextStyle(fontStyle: FontStyle.normal, color: Colors.black);

  CustomAppBar(BuildContext context) {
    this.context = context;
    bottomBarItems.add(
      BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.location_on,
          color: Colors.green,
        ),
        icon: Icon(
          Icons.location_city,
          color: Colors.black,
        ),
        title: Text(
          "Home",
          style: bottomNavigationBarItemStyle,
        ),
      ),
    );
    bottomBarItems.add(
      BottomNavigationBarItem(
         title: Text(
          "Services",
          style: bottomNavigationBarItemStyle,
        ),
         icon: Material(
            child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => services()));
                },
                child: Icon(
                  Icons.local_laundry_service,
                  color: Colors.black,
                )),
          ),
       
      ),
    );
    bottomBarItems.add(
      BottomNavigationBarItem(
          title: Text(
            "Explore",
            style: bottomNavigationBarItemStyle,
          ),
          icon: Material(
            child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => partenaire()));
                },
                child: Icon(
                  Icons.local_offer,
                  color: Colors.black,
                )),
          )),
    );
    bottomBarItems.add(
      BottomNavigationBarItem(
        title: Text(
          "Compte",
          style: bottomNavigationBarItemStyle,
        ),
        icon: Material(
            child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => balance()));
                },
                child: Icon(
                  Icons.account_balance,
                  color: Colors.black,
                )),
          )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      child: BottomNavigationBar(
        items: bottomBarItems,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
