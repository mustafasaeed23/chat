import 'dart:async';

import 'package:chat_app/Add_Room/add_room_navigtor.dart';
import 'package:chat_app/Add_Room/add_room_view_model.dart';
import 'package:chat_app/model/Category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utils.dart' as Utils;

import '../model/Category.dart';
import '../model/Category.dart';
import '../model/Category.dart';
import '../model/Category.dart';

class AddRoom extends StatefulWidget{
 static const String routeName = 'room';
  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomNavigtor {
   addRoomViewModel viewModel = addRoomViewModel();
  String roomTitle = '' ;
  String roomDescription = '' ;
  var formKey = GlobalKey<FormState>();
  var categoryList = Category.getCategory();
  Category? selectedItem ;


   @override
  void initState() {
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              centerTitle: true,
            ),
           body: Container(
             margin: EdgeInsets.symmetric(horizontal: 12, vertical: 32),
             padding: EdgeInsets.all(12),
             width: double.infinity,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(18),
               color: Colors.white,
               boxShadow: [
                 BoxShadow(
                   color: Colors.grey.withOpacity(0.5),
                   spreadRadius: 5,
                   blurRadius: 7,
                   offset: Offset(0, 3), // changes position of shadow
                 ),
               ],
             ),
             child: Form(
               key: formKey,
               child: Center(
                 child: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       SizedBox(height: 10,),
                       Text("Create New Room" ,
                         textAlign: TextAlign.center,
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 18,
                           color: Colors.black,
                         ),

                       ),
                       SizedBox(height: 10,),
                       Image.asset("assets/images/group.png"),
                       SizedBox(height: 10,),

                       TextFormField(
                         onChanged: (text){
                           roomTitle = text ;
                         },
                         validator: (text){
                           if(text == null || text.trim().isEmpty){
                             return "Please Enter Title for Room";
                           }
                         },
                         decoration: InputDecoration(
                           hintText: "Enter Room Title",
                         ),
                       ),
                       SizedBox(height: 10,),

                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: DropdownButton<Category>(
                           borderRadius: BorderRadius.circular(10),
                           hint: Text('Select your Category') ,
                           autofocus: true,
                           isExpanded: true,
                           value: selectedItem,
                             items: categoryList.map((category)
                             => DropdownMenuItem<Category>(
                               value: category,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(category.title),
                                     Image.asset(category.imagePath),
                                   ],
                                 ),
                             )).toList(),
                             onChanged: (newCategory){
                             if(newCategory == null) return ;
                             selectedItem = newCategory ;
                             setState(() {

                             });
                             } ,
                         ),
                       ),
                       SizedBox(height: 10,),
                       TextFormField(
                         onChanged: (text){
                           roomDescription = text ;
                         },
                         validator: (text){
                           if(text == null || text.trim().isEmpty){
                             return "Please Enter Desc for Room";
                           }
                         },
                         decoration: InputDecoration(
                           hintText: "Enter Room Description",
                         ),
                         maxLines: 4,
                         minLines: 4,
                       ),
                       SizedBox(height: 20,),
                       ElevatedButton(onPressed: () {
                         valditeForm();
                           },
                            child: Text('Add Room'),
                       ),

                     ],
                   ),
                 ),
               ),
             ),
           ),
          ),
        ],
      ),
    );
  }

  void valditeForm() {
     if(formKey.currentState?.validate() == true){
       // add room
    viewModel.addRoom(roomTitle, roomDescription, selectedItem?.id ?? '');
     }
  }

  @override
  void hideLoading() {
     Utils.hideLoading(context);
  }

  @override
  void navigateToHome() {
     Timer(Duration(seconds: 2), () {
       Navigator.pop(context);

     });
  }

  @override
  void showLoading() {
  Utils.showLoading(context, 'loading...');
  }

  @override
  void showMessage(String message) {
  Utils.showMessage(
      context,
      message,
      "OK",
    (context) => Navigator.pop(context),
  );
  }
}
