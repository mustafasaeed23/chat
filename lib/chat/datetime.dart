import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YourWidget extends StatelessWidget {
  final DateTime dateTime;

  YourWidget({required this.dateTime});

  @override
  Widget build(BuildContext context) {
    // Format the time using intl package
    String formattedTime = DateFormat.jm().format(dateTime);

    return Text(
      formattedTime,
      style: TextStyle(color: Colors.black),
    );
  }
}