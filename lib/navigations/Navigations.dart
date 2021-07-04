import 'package:alan_voice/alan_voice.dart';
import 'package:ewallet_hackathon/failedTransactions/Failed10Transactions.dart';
import 'package:ewallet_hackathon/failedTransactions/Failed5Transactions.dart';
import 'package:ewallet_hackathon/failedTransactions/FailedTransactions.dart';
import 'package:ewallet_hackathon/successTransactions/SuccessTransactions.dart';
import 'package:flutter/material.dart';

void setVisuals(String screen) {
  var visual = "{\"screen\":\"$screen\"}";
  AlanVoice.setVisualState(visual);
}

void openFailedTransactionPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FailedTransactions()),
  );
  setVisuals("third");
}

void openFailed5TransactionPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Failed5Transactions()),
  );
  setVisuals("third");
}

void openFailed10TransactionPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Failed10Transactions()),
  );
  setVisuals("third");
}

void openStatementPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SuccessTransactions()),
  );
  setVisuals("second");
}
