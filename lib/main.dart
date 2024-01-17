
import 'package:chat_app/Register/register_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RegisterScreen.routeName : (context) => RegisterScreen(),
      },
      initialRoute: RegisterScreen.routeName,
    );
  }
}
