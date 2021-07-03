import 'dart:convert';

import 'package:alan_voice/alan_voice.dart';
import 'package:ewallet_hackathon/views/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Failed10Transactions extends StatefulWidget {
  const Failed10Transactions({Key key}) : super(key: key);

  @override
  _Failed10TransactionsState createState() => _Failed10TransactionsState();
}

class _Failed10TransactionsState extends State<Failed10Transactions> {
  List failedTransactions = [];

  @override
  void initState() {
    super.initState();
    AlanVoice.removeButton();
    fetchFailedTransaction();
  }

  fetchFailedTransaction() async {
    var response = await http.get(Uri.https("jaysharma8.000webhostapp.com",
        "getLast10BankUserFailedTransactions.php"));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['transactions'];
      if (mounted) {
        setState(() {
          failedTransactions = jsonData;
          print(failedTransactions);
        });
      }
    } else {
      failedTransactions = [];
      print("Loading");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setVisuals("first");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashBoard()),
            (Route<dynamic> route) => false);
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffffac30),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              setVisuals("first");
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashBoard()),
                  (Route<dynamic> route) => false);
              return;
            },
          ),
          title: Text("Failed 10 Failed Transactions"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("A/C Number"),
                            Text(
                              "640998382762892",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Available Balance"),
                            Text(
                              "₹ 52000",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Available Balance*"),
                            Text(
                              "52000",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Link Fixed Deposit Bal"),
                            Text(
                              "₹ 0.00",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Note: Transactions conducted on a non-banking day will have the transaction date as the next working day",
                      style: TextStyle(
                        color: Color(0xfff59d08),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Expanded(
              child: failedTransactions.length != 0
                  ? getSuccessTransaction()
                  : Container(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text("Loading Transactions..."),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSuccessTransaction() {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: failedTransactions.length,
        itemBuilder: (context, index) {
          return getCard(failedTransactions[index]);
        });
  }

  Widget getCard(index) {
    var date = index['date'];
    var destination = index['destination'];
    var transAmt = index['transAmt'];
    var reason = index['reason'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          title: Row(
            children: [
              Divider(
                color: Colors.amber,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      destination.toString(),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(width: 1.0),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          transAmt.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          reason.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setVisuals(String screen) {
    var visual = "{\"screen\":\"$screen\"}";
    AlanVoice.setVisualState(visual);
  }
}
