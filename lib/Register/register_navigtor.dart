
import 'package:chat_app/model/my_user.dart';

abstract class RegisterNavigtor{
  void showLoading ();   // abstract method or function
  void hideLoading() ;
  void showMesaage(String message) ;
  void navigateToHome(MyUser user);
}