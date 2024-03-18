
import 'package:chat_app/Database/database_utlis.dart';
import 'package:chat_app/Register/register_navigtor.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase_erros(utils).dart';

// provider
class RegisterViewModel extends ChangeNotifier{
  late RegisterNavigtor navigtor ;

  void registerFireBaseAuth( String email , String password , String firstName, String lasName,
      String userName) async {
  try {
    // show loading
    navigtor.showLoading();

  final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
  );
   // save data
    var user = MyUser(
        id: result.user?.uid ?? '',
        firstName: firstName,
        lastName: lasName,
        userName: userName,
        email: email);
    var dataUser = await DatabaseUtills.registerUser(user);
    // hide loading
    navigtor.hideLoading();
  // show message
    navigtor.showMesaage('Register Successfully');
    navigtor.navigateToHome(user);

  } on FirebaseAuthException catch (e) {
  if (e.code == FirebaseErrors.weakPassword) {
    // hide loading
    navigtor.hideLoading();
    // show message
    navigtor.showMesaage('The password provided is too weak');
  print('The password provided is too weak.');
  } else if (e.code == FirebaseErrors.emailAlreadyInUse) {
    // hide loading
    navigtor.hideLoading();
    //show message
    navigtor.showMesaage('The account already exists for that email');
  // print('The account already exists for that email.');
  }
  } catch (e) {
    //hide loading
    navigtor.hideLoading();
    // show message
    navigtor.showMesaage('Something went wrong');
  print(e);
  }

}
}
