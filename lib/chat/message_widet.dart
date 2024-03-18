import 'package:chat_app/model/Messages.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Messages messages;

  MessageWidget({required this.messages});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.user?.id == messages.senderId
        ? SendMessage(messages: messages)
        : RecieveMessage(messages: messages);
    return Container();
  }
}

class SendMessage extends StatelessWidget {
  Messages messages;
  DateTime dateTime = DateTime.now();

  SendMessage({required this.messages});

  Widget build(BuildContext context) {
    String formattedTime = DateFormat.jm().format(dateTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
          child: Text(
            messages.content,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            color: Colors.blue,
          ),
        ),
        Text(DateFormat.jms().format(dateTime),

    // formattedTime = messages.dateTime.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

class RecieveMessage extends StatelessWidget {
  Messages messages;
  DateTime dateTime = DateTime.now();

  RecieveMessage({required this.messages});

  Widget build(BuildContext context) {
    String formattedTime = DateFormat.jms().format(dateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
          child: Text(
            messages.content,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            color: Colors.blueGrey,
          ),
        ),
        Text(DateFormat.jms().format(dateTime),
          // formattedTime = messages.dateTime.toString(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

