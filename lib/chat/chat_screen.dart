import 'package:chat_app/Database/database_utlis.dart';
import 'package:chat_app/chat/chat_navigator.dart';
import 'package:chat_app/chat/chat_screen_view_model.dart';
import 'package:chat_app/chat/message_widet.dart';
import 'package:chat_app/model/Messages.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utils.dart' as Utils;

import '../Add_Room/new_add_room.dart';
import '../model/room.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  ChatScreenViewModel viewModel = ChatScreenViewModel();
  String messageContent = '' ;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var provider = Provider.of<UserProvider>(context);

    viewModel.room = args ;
    viewModel.currentUser = provider.user! ;
    viewModel.listenForUpdateRoomMessages();

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image.asset(
            "assets/images/main_background.png",
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                args.roomTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){

                    },
                      child: Icon(Icons.more_vert)),
                ),
              ],
            ),

            body: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 7,
                    spreadRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text("Today" , style: TextStyle(fontSize: 18),),
                  SizedBox(height: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(viewModel.currentUser.userName,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),

                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Messages>>(
                        stream: viewModel.streamMessages ,
                        builder: (context , asyncSnapShot){
                          if(asyncSnapShot.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator(),
                            );
                          }else if(asyncSnapShot.hasError){
                            return Text(asyncSnapShot.error.toString());
                          }else{

                            var messagesList = asyncSnapShot.data?.docs.map((doc) => doc.data()).toList() ?? [];
                            return ListView.builder(
                                itemBuilder: (context,index){
                            return MessageWidget(messages: messagesList[index]);
                                },
                                itemCount: messagesList.length,
                            );
                          }
                        },
                      ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller ,
                          onChanged: (text) {
                            messageContent = text;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(4),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                            ),
                            hintText: "Type a Message",
                          ),
                        ),
                      ),
                      SizedBox(width: 10 ,),
                      ElevatedButton(
                        onPressed: () {
                        viewModel.sendMessage(messageContent);
                        },
                        child: Row(
                          children: [
                            Text("Send"),
                            SizedBox(width: 10 ,),
                            Icon(Icons.send_rounded),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void showMessage(String message) {
  Utils.showMessage(context,
      message,
      "OK",
    (context) => Navigator.pop(context),
  );
  }

  @override
  void clearMessage() {
    controller.clear();
  }
}
