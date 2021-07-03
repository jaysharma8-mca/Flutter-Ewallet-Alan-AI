import 'package:alan_voice/alan_voice.dart';
import 'package:ewallet_hackathon/views/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPay extends StatefulWidget {
  final int transAmt; //if you have multiple values add here
  RazorPay(this.transAmt, {Key key}) : super(key: key);

  @override
  _RazorPayState createState() => _RazorPayState();
}

class _RazorPayState extends State<RazorPay> {
  Razorpay _razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setupAlanVoice();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_gnuhMvMzYH12iN",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "EWallet",
      "description": "Payment",
      "prefill": {
        "contact": "7972372641",
        "email": "jaysharma155.cmpicamca15@gmail.com"
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }

  setupAlanVoice() {
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  _handleCommand(Map<String, dynamic> response) {
    switch (response["command"]) {
      case "pay":
        if (mounted) {
          openCheckout();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffffac30),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => DashBoard()),
                (Route<dynamic> route) => false);
          },
        ),
        title: Text("Payment Gateways"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController
                ..text = widget.transAmt.toString(),
              decoration: InputDecoration(
                hintText: "Amount to pay",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                openCheckout();
              },
              child: Text("Pay Now"),
              style: ElevatedButton.styleFrom(
                primary: Color(0xffffac30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setVisuals(String screen) {
    var visual = "{\"screen\":\"$screen\"}";
    AlanVoice.setVisualState(visual);
  }
}
