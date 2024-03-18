import 'package:chat_app/Database/database_utlis.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  MyUser? user ;
  User? firebaseUser ;


  UserProvider(){
    firebaseUser = FirebaseAuth.instance.currentUser ;
    intitUser();
  }

  void intitUser() async {
    if(firebaseUser != null){
      user =  await DatabaseUtills.getUser(firebaseUser?.uid ?? '' );
    }
  }

}