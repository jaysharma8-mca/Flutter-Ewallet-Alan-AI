import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'NavBarDeviceType.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.40,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var item in kNavigationItems) //navigationItems)
              NavBarDeviceType(
                onPressed: () {
                  if (item.text == "Home") {
                    Fluttertoast.showToast(msg: "Home");
                  } else if (item.text == "Profile") {
                    Fluttertoast.showToast(msg: "Profile");
                  } else if (item.text == "Transactions") {
                    Fluttertoast.showToast(msg: "Transactions");
                  } else if (item.text == "Stats") {
                    Fluttertoast.showToast(msg: "Stats");
                  } else if (item.text == "Settings") {
                    Fluttertoast.showToast(msg: "Settings");
                  } else if (item.text == "Help") {
                    Fluttertoast.showToast(msg: "Help");
                  } else if (item.text == "Logout") {
                    Fluttertoast.showToast(msg: "Logout");
                  }
                },
                text: item.text,
              )
          ],
        ),
      ),
    );
  }
}

class NavigationItem {
  final String text;
  NavigationItem(this.text);
}

final kNavigationItems = [
  NavigationItem('Home'),
  NavigationItem('Profile'),
  NavigationItem('Transactions'),
  NavigationItem('Stats'),
  NavigationItem('Settings'),
  NavigationItem('Help'),
  NavigationItem('Logout'),
];
