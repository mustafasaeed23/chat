import 'package:chat_app/Add_Room/add_room_navigtor.dart';
import 'package:chat_app/Database/database_utlis.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

class addRoomViewModel extends ChangeNotifier{
 late AddRoomNavigtor navigtor ;

 void addRoom(String roomTitle , String roomDescription , String categoryId) async{

  Room room = Room(
      roomId: "",
      roomTitle: roomTitle,
      roomDesc: roomDescription,
      categoryId: categoryId);
  try {
   navigtor.showLoading();
   var createdRoom = await DatabaseUtills.addRoomToFireStore(room);
   navigtor.hideLoading();
   navigtor.showMessage('Room was created successfully');
   navigtor.navigateToHome();

  }catch(e){
    navigtor.hideLoading();
    navigtor.showMessage(e.toString());
  }
 }

}