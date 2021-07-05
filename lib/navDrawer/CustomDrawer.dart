import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constants/Const.dart';

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return ResponsiveBuilder(builder: (context, size) {
      if (size.isMobile)
        return Container(
          color: Colors.white,
          width: mediaQuery.size.width * 0.60,
          height: mediaQuery.size.height,
          child: Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey.withAlpha(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "asset/images/avatar4.png",
                        width: 150,
                        height: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Cyber Knights",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  )),
              ListTile(
                onTap: () {
                  showToast(context, "Tapped Home");
                },
                leading: Icon(Icons.home),
                title: Text(
                  "Home",
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  showToast(context, "Tapped Profile");
                },
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  showToast(context, "Tapped Accounts");
                },
                leading: Icon(Icons.account_balance),
                title: Text("Accounts"),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  showToast(context, "Tapped Transactions");
                },
                leading: Icon(Icons.account_balance_wallet_outlined),
                title: Text("Transactions"),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  showToast(context, "Tapped Stats");
                },
                leading: Icon(Icons.stacked_bar_chart),
                title: Text("Stats"),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  showToast(context, "Tapped Settings");
                },
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  showToast(context, "Tapped Help");
                },
                leading: Icon(Icons.help),
                title: Text("Help"),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  showToast(context, "Tapped Log Out");
                },
                leading: Icon(Icons.exit_to_app),
                title: Text("Log Out"),
              ),
            ],
          ),
        );
      return Container(
        color: Colors.white,
        width: mediaQuery.size.width * 0.60,
        height: mediaQuery.size.height,
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey.withAlpha(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "asset/images/avatar4.png",
                      width: 150,
                      height: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Cyber Knights",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                )),
            ListTile(
              onTap: () {
                showToast(context, "Tapped Home");
              },
              leading: Icon(Icons.home),
              title: Text(
                "Home",
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                showToast(context, "Tapped Profile");
              },
              leading: Icon(Icons.person),
              title: Text("Profile"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                showToast(context, "Tapped Accounts");
              },
              leading: Icon(Icons.account_balance),
              title: Text("Accounts"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                showToast(context, "Tapped Transactions");
              },
              leading: Icon(Icons.account_balance_wallet_outlined),
              title: Text("Transactions"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                showToast(context, "Tapped Stats");
              },
              leading: Icon(Icons.stacked_bar_chart),
              title: Text("Stats"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                showToast(context, "Tapped Settings");
              },
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                showToast(context, "Tapped Help");
              },
              leading: Icon(Icons.help),
              title: Text("Help"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                showToast(context, "Tapped Log Out");
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("Log Out"),
            ),
          ],
        ),
      );
    });
  }
}
