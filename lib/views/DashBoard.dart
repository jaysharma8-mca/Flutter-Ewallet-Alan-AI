import 'dart:convert';

import 'package:alan_voice/alan_voice.dart';
import 'package:ewallet_hackathon/navigations/Navigations.dart';
import 'package:ewallet_hackathon/razorPay/RazorPay.dart';
import 'package:ewallet_hackathon/successTransactions/SuccessTransactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:http/http.dart' as http;

import '../navDrawer/CustomDrawer.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {
  FSBStatus drawerStatus;
  List users = [];
  List failedTransactions = [];
  String balanceAmt;
  bool error, sending, success;
  String msg;
  String transDate;
  int transAmt;
  bool _isDialogShowing = false;

  String phpUrl =
      "https://jaysharma8.000webhostapp.com/getBankUserFailedTransactionForParticularDate.php";

  @override
  void initState() {
    super.initState();
    setupAlanVoice();
    fetchUser();
    setVisuals("first");
    error = false;
    sending = false;
    success = false;
    msg = "";
  }

  setupAlanVoice() {
    AlanVoice.addButton(
      "cf5e5707f0cb663630fb2385e6de925f2e956eca572e1d8b807a3e2338fdd0dc/stage",
      buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT,
    );
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  _handleCommand(Map<String, dynamic> response) {
    switch (response["command"]) {
      case "info":
        break;
      case "statement":
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SuccessTransactions()),
          );
          setVisuals("second");
        }
        break;
      case "failed":
        if (mounted) {
          openFailedTransactionPage(context);
          setVisuals("third");
        }
        break;
      case "failed5":
        if (mounted) {
          openFailed5TransactionPage(context);
          setVisuals("third");
        }
        break;
      case "failed10":
        if (mounted) {
          openFailed10TransactionPage(context);
          setVisuals("third");
        }
        break;
      case "show_data":
        if (mounted) {
          transDate = response["id"];
          if (transDate.contains("th") |
              transDate.contains("st") |
              transDate.contains("rd") |
              transDate.contains("nd") |
              transDate.contains("of")) {
            transDate = transDate.replaceAll("th", "");
            transDate = transDate.replaceAll("st", "");
            transDate = transDate.replaceAll("rd", "");
            transDate = transDate.replaceAll("nd", "");
            transDate = transDate.replaceAll("of", "");
            transDate = transDate.replaceAll("  ", " ");
            //Fluttertoast.showToast(msg: transDate);
            //print(transDate);
            sendData(transDate);
          }
          /*else if (transDate.contains("st") | transDate.contains("of")) {
            transDate = transDate.replaceAll("st", "");
            transDate = transDate.replaceAll("of", "");
            Fluttertoast.showToast(msg: transDate);
            sendData(transDate);
          } else if (transDate.contains("rd") | transDate.contains("of")) {
            transDate = transDate.replaceAll("rd", "");
            transDate = transDate.replaceAll("of", "");
            Fluttertoast.showToast(msg: transDate);
            sendData(transDate);
          } else if (transDate.contains("nd") | transDate.contains("of")) {
            transDate = transDate.replaceAll("nd", "");
            transDate = transDate.replaceAll("of", "");
            Fluttertoast.showToast(msg: transDate);
            sendData(transDate);
          }*/
        }
        break;
      case "dialog":
        if (mounted) {
          if (_isDialogShowing == true) {
            Navigator.of(context).maybePop();
          }
        }
        break;
      case "balance":
        break;
      case "money":
        break;
      case "send_money":
        if (mounted) {
          //transAmt = response["id"];
          //Fluttertoast.showToast(msg: response["id"]);
          convStrToNum(response["id"]);
        }
        break;
      default:
        print("Command was ${response["command"]}");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        height: 30.0,
        width: 30.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Color(0xfffcc900).withOpacity(0.4),
            child: Container(
              margin: EdgeInsets.all(17),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/images/menu.png'),
                ),
              ),
            ),
            onPressed: () {
              setState(
                () {
                  drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                      ? FSBStatus.FSB_CLOSE
                      : FSBStatus.FSB_OPEN;
                },
              );
            },
          ),
        ),
      ),
      body: FoldableSidebarBuilder(
        //drawerBackgroundColor: Colors.deepOrange,
        drawer: CustomDrawer(
          closeDrawer: () {
            setState(() {
              drawerStatus = FSBStatus.FSB_CLOSE;
            });
          },
        ),
        screenContents: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('asset/images/logo.png'),
                        )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "eWallet",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'ubuntu',
                            fontSize: 25),
                      )
                    ],
                  ),
                  if (users.length != 0)
                    Text(
                      users[0]['name'].toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  else
                    Container(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Account Overview",
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'avenir'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xfff1f3f6),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            users.length != 0
                                ? Text(
                                    "₹ " + users[0]['balance'].toString(),
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                : CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                            SizedBox(
                              height: 5,
                            ),
                            users.length != 0
                                ? Text(
                                    "Current Balance",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                : Text(
                                    "Loading...",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                          ],
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffffac30),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Color(0xffffac30),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: openStatementPage,
                          child: Text(
                            "Statement",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          color: Color(0xffffac30),
                          height: 20,
                          width: 1.5,
                        ),
                        Text(
                          "Debit Cards",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          color: Color(0xffffac30),
                          height: 20,
                          width: 1.5,
                        ),
                        Text(
                          "Services",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Send Money",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'avenir'),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('asset/images/scanqr.png'))),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: [
                    InkWell(
                      //onTap: openPaymentPage,
                      child: Container(
                        height: 70,
                        width: 70,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffffac30),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ),
                    ),
                    avatarWidget("avatar1", "Mike"),
                    avatarWidget("avatar2", "Joseph"),
                    avatarWidget("avatar3", "Ashley"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Services',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'avenir'),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    child: Icon(Icons.dialpad),
                  )
                ],
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: 0.7,
                  physics: BouncingScrollPhysics(),
                  children: [
                    serviceWidget("sendMoney", "Send\nMoney"),
                    serviceWidget("receiveMoney", "Receive\nMoney"),
                    serviceWidget("phone", "Mobile\nRecharge"),
                    serviceWidget("electricity", "Electricity\nBill"),
                    serviceWidget("tag", "Cashback\nOffer"),
                    serviceWidget("movie", "Movie\nTicket"),
                    serviceWidget("flight", "Flight\nTicket"),
                    serviceWidget("more", "More\n"),
                  ],
                ),
              )
            ],
          ),
        ),
        status: drawerStatus,
      ),
    );
  }

  Column serviceWidget(String img, String name) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
                color: Color(0xfff1f3f6),
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('asset/images/$img.png'))),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'avenir',
            fontSize: 14.sp,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Container avatarWidget(String img, String name) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      height: 100.h,
      width: 120.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          color: Color(0xfff1f3f6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('asset/images/$img.png'),
                    fit: BoxFit.contain),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                )),
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  fetchUser() async {
    var response = await http
        .get(Uri.https("jaysharma8.000webhostapp.com", "getBankUserInfo.php"));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['userInfo'];
      if (mounted) {
        setState(() {
          users = jsonData;
        });
      }
    } else {
      users = [];
      print("Loading");
    }
  }

  Future<int> convStrToNum(String str) async {
    var oneTen = <String, num>{
      'one': 1,
      'two': 2,
      'three': 3,
      'four': 4,
      'five': 5,
      'six': 6,
      'seven': 7,
      'eight': 8,
      'nine': 9,
      'ten': 10,
      'two hundred': 200,
    };
    if (oneTen.keys.contains(str)) {
      if (oneTen[str] < 52000) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RazorPay(oneTen[str])),
        );
        setVisuals("fourth");
      }
    }
    return oneTen[str];
  }

  Future<void> sendData(String transactionDate) async {
    var response = await http.post(Uri.parse(phpUrl), body: {
      "date": transactionDate,
    }); //sending post request with header data

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['transactions'];
      if (mounted) {
        setState(() {
          failedTransactions = jsonData;
          for (dynamic user in failedTransactions) {
            _asyncConfirmDialog(
              context,
              user["transAmt"],
              user["reason"],
              user["destination"],
              user["date"],
            );
          }
        });
      }
    } else {
      failedTransactions = [];
      Fluttertoast.showToast(msg: "No Data Found");
    }
  }

  Future _asyncConfirmDialog(BuildContext context, String transAmt,
      String reason, String destination, String date) async {
    _isDialogShowing = true;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'Failed Transaction',
              style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.date_range, size: 22),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          date,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(Icons.monetization_on, size: 22),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          transAmt,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(Icons.description, size: 22),
                        SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: Text(
                            destination,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(Icons.error, size: 22),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          reason,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).maybePop();
                    _isDialogShowing = false;
                  })
            ],
          );
        });
  }

  void openStatementPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessTransactions()),
    );
    setVisuals("second");
  }
}
