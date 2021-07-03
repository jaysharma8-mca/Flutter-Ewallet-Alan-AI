import 'dart:convert';

import 'package:alan_voice/alan_voice.dart';
import 'package:ewallet_hackathon/failedTransactions/Failed10Transactions.dart';
import 'package:ewallet_hackathon/failedTransactions/Failed5Transactions.dart';
import 'package:ewallet_hackathon/failedTransactions/FailedTransactions.dart';
import 'package:ewallet_hackathon/views/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuccessTransactions extends StatefulWidget {
  const SuccessTransactions({Key key}) : super(key: key);

  @override
  _SuccessTransactionsState createState() => _SuccessTransactionsState();
}

class _SuccessTransactionsState extends State<SuccessTransactions> {
  List successTransactions = [];

  @override
  void initState() {
    super.initState();
    setupAlanVoice();
    fetchSuccessTransactions();
  }

  setupAlanVoice() {
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  _handleCommand(Map<String, dynamic> response) {
    switch (response["command"]) {
      case "failed":
        if (mounted) {
          openFailedTransactionPage();
          setVisuals("third");
        }
        break;
      case "failed5":
        if (mounted) {
          openFailed5TransactionPage();
          setVisuals("third");
        }
        break;
      case "failed10":
        if (mounted) {
          openFailed10TransactionPage();
          setVisuals("third");
        }
        break;
      case "dashboard":
        if (mounted) {
          Navigator.of(context).maybePop();
          setVisuals("first");
        }
        break;
      default:
        print("Command was ${response["command"]}");
        break;
    }
  }

  fetchSuccessTransactions() async {
    var response = await http.get(Uri.https(
        "jaysharma8.000webhostapp.com", "getBankUserTransactions.php"));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['transactions'];
      if (mounted) {
        setState(() {
          successTransactions = jsonData;
        });
      }
    } else {
      successTransactions = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
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
              Navigator.of(context).maybePop();
              setVisuals("first");
            },
          ),
          title: Text("Success Transactions"),
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
              child: successTransactions.length != 0
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
        itemCount: successTransactions.length,
        itemBuilder: (context, index) {
          return getCard(successTransactions[index]);
        });
  }

  Widget getCard(index) {
    var date = index['date'];
    var destination = index['destination'];
    var transAmt = index['transAmt'];
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
              //VerticalDivider(width: 1.0),
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      transAmt.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openFailedTransactionPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FailedTransactions()),
    );
    setVisuals("third");
  }

  void openFailed5TransactionPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Failed5Transactions()),
    );
    setVisuals("third");
  }

  void openFailed10TransactionPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Failed10Transactions()),
    );
    setVisuals("third");
  }

  void setVisuals(String screen) {
    var visual = "{\"screen\":\"$screen\"}";
    AlanVoice.setVisualState(visual);
  }
}
