import 'package:ewallet_hackathon/failedTransactions/FailedTransactions.dart';
import 'package:ewallet_hackathon/successTransactions/SuccessTransactions.dart';
import 'package:ewallet_hackathon/views/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'views/HomePage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Wallet Hackathon',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
        ),
        home: HomePage(),
        routes: {
          '/dashBoard': (context) => DashBoard(),
          '/successTransactionPage': (context) => SuccessTransactions(),
          '/failedTransactionPage': (context) => FailedTransactions(),
        },
      ),
      designSize: const Size(360, 640),
    );
  }
}
