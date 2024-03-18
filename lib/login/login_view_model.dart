
import 'package:chat_app/Database/database_utlis.dart';
import 'package:chat_app/firebase_erros(utils).dart';
import 'package:chat_app/login/login_navigtor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class LoginViewModel extends ChangeNotifier{

late  LoginNavigtor navigtor ;


  void loginFireBaseAuth(String email , String password) async{
    try {
      // show loading
      navigtor.showLoading();

      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      // hide loading
      navigtor.hideLoading();
      var userObject = await DatabaseUtills.getUser(result.user?.uid ?? '');
      // show message
      navigtor.showMessage('Login Successfully');
      navigtor.navigateToHome(userObject!);
      var user = userObject;
      navigtor.navigateToHome(user);
      // navigtor.navigateToHome();
      //  retrieve user data
      //   if(userObject == null){
      //     navigtor.hideLoading();
      //     navigtor.showMessage("Register failed, please try again");
      //   }else{
      //     navigtor.navigateToHome(userObject);
      //   }



    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.userNotFound) {
        // hide loading
        navigtor.hideLoading();
        // show message
        navigtor.showMessage('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == FirebaseErrors.wrongPassword) {
        // hide loading
        navigtor.hideLoading();
        // show message
        navigtor.showMessage('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
  }
}