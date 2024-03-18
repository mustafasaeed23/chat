import 'package:chat_app/Database/database_utlis.dart';
import 'package:chat_app/chat/chat_navigator.dart';
import 'package:chat_app/model/Messages.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreenViewModel extends  ChangeNotifier{
  late ChatNavigator navigator ;
  late MyUser currentUser ;
  late Room room ;
  late Stream<QuerySnapshot<Messages>> streamMessages ;
  
  void sendMessage(String content) async{
    Messages messages = Messages(
        roomId: room.roomId,
        content: content,
        senderId: currentUser.id,
        senderName: currentUser.userName,
        dateTime: DateTime.now().millisecondsSinceEpoch,
    );
    try {
      var result = await DatabaseUtills.insertMessage(messages);
      // clear message
      navigator.clearMessage();
    }catch(error){
     navigator.showMessage(error.toString());
    }
  }

  void listenForUpdateRoomMessages(){
   streamMessages =  DatabaseUtills.getMessagesFromFireStore(room.roomId);
  }
}