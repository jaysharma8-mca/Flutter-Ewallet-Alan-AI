import 'package:ewallet_hackathon/constants/Const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBarDeviceType extends StatelessWidget {
  const NavBarDeviceType({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return screenWidth == 1024 && screenHeight == 1366
        ? NavigationBarItemIpad(onPressed: onPressed, text: text)
        : screenWidth == 768 && screenHeight == 1024
            ? NavigationBarItemIpad(onPressed: onPressed, text: text)
            : NavigationBarItemDesktop(onPressed: onPressed, text: text);
  }
}

class NavigationBarItemDesktop extends StatelessWidget {
  const NavigationBarItemDesktop({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    return Container(
      child: InkWell(
        mouseCursor: MaterialStateMouseCursor.clickable,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onPressed, // needed  //extracted the () => using ctrl+alt+v
        child: Ink(
          child: Text(
            text, //extracted the text using ctrl+alt+v
            style: GoogleFonts.patrickHand(
              textStyle: TextStyle(
                fontSize: width * 0.017,
                fontWeight: FontWeight.bold,
                //color: kDefaultFontColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationBarItemIpad extends StatelessWidget {
  const NavigationBarItemIpad({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    return Container(
      child: InkWell(
        mouseCursor: MaterialStateMouseCursor.clickable,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onPressed, // needed  //extracted the () => using ctrl+alt+v
        child: Ink(
          child: Text(
            text, //extracted the text using ctrl+alt+v
            style: GoogleFonts.patrickHand(
              textStyle: TextStyle(
                fontSize: width * 0.027,
                fontWeight: FontWeight.bold,
                color: kDefaultFontColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
