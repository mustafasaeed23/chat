import 'package:chat_app/Add_Room/new_add_room.dart';
import 'package:chat_app/Add_Room/room_widget.dart';
import 'package:chat_app/Database/database_utlis.dart';
import 'package:chat_app/Home/home_navigtor.dart';
import 'package:chat_app/Home/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/room.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeNavigtor {
  HomeViewModel viewModel = HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigtor = this ;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel ,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image.asset("assets/images/main_background.png",
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text("Chat App",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
               Navigator.of(context).pushNamed(AddRoom.routeName);
              },
              child: Icon(Icons.add ,),

            ),
            body: StreamBuilder<QuerySnapshot<Room>>(
              stream: DatabaseUtills.getRooms(),
              builder: (context , asyncsnapshot){
                if(asyncsnapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(color: Colors.blue,),
                  );
                }else if (asyncsnapshot.hasError){
                  return Text(asyncsnapshot.error.toString());
                }else {
                  // has data
                  var roomsList = asyncsnapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
                  return GridView.builder(
                    itemCount: roomsList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                       mainAxisSpacing: 8,
                       crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context,index){
                      return RoomWidget(room: roomsList[index]);
                      }
                  );

                }
              },

            ),
          ),
        ],
      ),
    );
  }
}
