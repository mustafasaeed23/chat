
import 'dart:async';

import 'package:chat_app/Home/home_screen.dart';
import 'package:chat_app/Register/register_screen.dart';
import 'package:chat_app/login/login_navigtor.dart';
import 'package:chat_app/login/login_view_model.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/utils.dart' as Utils;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
 static const String routeName = 'login' ;


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigtor {
  String email = '';

  String password = '';

  var formkey = GlobalKey<FormState>();

  LoginViewModel viewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.navigtor = this ;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
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
            title: Text("Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                    ),
                    onChanged: (text) {
                      email = text;
                    },
                    validator: (text) {
                      final bool emailValid =
                      RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text!);

                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return " Enter your Email ";
                      }
                      if (!emailValid) {
                        return "Please Enter valid email";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                    onChanged: (text) {
                      password = text;
                    },
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return "Enter Password";
                      }
                      if (text.length < 6) {
                        return " Password must be 6 chars";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20,),

                  ElevatedButton(onPressed: () {
                    validateform();
                  },
                      child: Text("Login")),
                  SizedBox(height: 20,),

                  TextButton(onPressed: (){
                    Navigator.of(context).pushNamed(RegisterScreen.routeName);

                  },
                    child: Text("Don't Have an Account",
                    style: TextStyle(),),),


                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void validateform() {
    if(formkey.currentState?.validate() == true){
      // login
      viewModel.loginFireBaseAuth(email, password);
    }
  }

  @override
  void hideLoading() {
  Utils.hideLoading(context);
  }

  @override
  void showLoading() {
  Utils.showLoading(context, 'Loading');
  }

  @override
  void showMessage(String message) {
  Utils.showMessage(context,
      message,
      'OK', (context){
  Navigator.pop(context);
      });
  }

  @override
  void navigateToHome(MyUser user) {
    var userProvider = Provider.of<UserProvider>(context , listen: false);
    userProvider.user = user;
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    }
}
