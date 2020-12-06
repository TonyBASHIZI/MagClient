import 'package:flutter/material.dart';
import 'package:MagClient/relais_list.dart';
import 'flight_list.dart';
import 'main.dart';

class CustomAppBar extends StatelessWidget {

 final List<BottomNavigationBarItem> bottomBarItems = [];
final bottomNavigationBarItemStyle = TextStyle(fontStyle: FontStyle.normal, color:  Colors.black);

   CustomAppBar(){

    bottomBarItems.add(
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.location_on, 
            color: Colors.green,), 
          icon: Icon(
            Icons.location_city, 
            color: Colors.black,),
          title: Text("Home", 
          style: bottomNavigationBarItemStyle,),

        ),
    );
    bottomBarItems.add(
        BottomNavigationBarItem(
          icon: Icon(Icons.notification_important, color: Colors.black,),
          title: Text("Notification", 
          style: bottomNavigationBarItemStyle,),

        ),
    );
    bottomBarItems.add(
        BottomNavigationBarItem(
          title: Text("Exporer",
          style: bottomNavigationBarItemStyle,),
          
          icon: Material(
           
          child: 
          InkWell( 
            onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => relaisList()));
              },
           child: Icon(Icons.local_offer, color: Colors.black,)
            
            ),  
          
          )
          
          

        ),
    );
    bottomBarItems.add(
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_mail, color: Colors.black,),
          title: Text("Contact", 
          style: bottomNavigationBarItemStyle,),

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

