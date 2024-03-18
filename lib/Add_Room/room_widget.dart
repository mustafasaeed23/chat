
import 'package:chat_app/chat/chat_screen.dart';
import 'package:flutter/material.dart';

import '../model/room.dart';

class RoomWidget extends StatelessWidget {
 Room room ;

 RoomWidget({required this.room});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
         Navigator.of(context).pushNamed(ChatScreen.routeName , arguments: room);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow:
          [
            BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
            spreadRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset('assets/images/${room.categoryId}.png',
                height: MediaQuery.of(context).size.height / 10 ,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 12,),
              Text(room.roomTitle, style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

            ],
          ),
        ),
      ),
    );
  }
}
