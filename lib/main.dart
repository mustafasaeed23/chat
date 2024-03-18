
import 'dart:io';

import 'package:chat_app/Add_Room/new_add_room.dart';
import 'package:chat_app/Home/home_screen.dart';
import 'package:chat_app/Register/register_screen.dart';
import 'package:chat_app/chat/chat_screen.dart';
import 'package:chat_app/login/login_screen.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid ?
  await Firebase.initializeApp(
    options: const  FirebaseOptions(
      apiKey: "AIzaSyBO9Ae1VfCrXDCZULor5lUWAzlqxfPdcXc",
      appId: "1:1023409132498:android:ccd2c71a1c07bfafdb6e0b",
      messagingSenderId: "1023409132498",
      projectId: "chat-app-8275e",
    ),
  )
  :
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
      child: MyApp()),);
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      routes: {
        RegisterScreen.routeName : (context) => RegisterScreen(),
        LoginScreen.routeName : (context) => LoginScreen(),
        HomeScreen.routeName : (context) => HomeScreen(),
        AddRoom.routeName : (context) => AddRoom(),
        ChatScreen.routeName :(context) => ChatScreen(),
      },
      initialRoute: userProvider.firebaseUser == null ?
      LoginScreen.routeName
          :
      HomeScreen.routeName,
    );
  }
}
