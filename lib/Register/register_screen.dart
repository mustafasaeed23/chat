import 'dart:async';

import 'package:chat_app/Home/home_screen.dart';
import 'package:chat_app/Register/register_navigtor.dart';
import 'package:chat_app/Register/register_view_model.dart';
import 'package:chat_app/firebase_erros(utils).dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utils.dart' as Utils;

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigtor {
  

  String firstName = '';

  String lastName = '';

  String userName = '';

  String email = '';

  String password = '';

  var formkey = GlobalKey<FormState>();

  RegisterViewModel viewModel = RegisterViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.navigtor = this ;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
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
              title: Text("Create Account",
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
                        labelText: "First Name",
                      ),
                      onChanged: (text) {
                        firstName = text;
                      },
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return "Enter First Name ";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Last Name",
                      ),
                      onChanged: (text) {
                        lastName = text;
                      },
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return "Enter last Name ";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "User Name",
                      ),
                      onChanged: (text) {
                        userName = text;
                      },
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return "Enter User Name ";
                        }
                        return null;
                      },
                    ),
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
                        child: Text("Create Account")),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateform() async {
    if (formkey.currentState?.validate() == true) {
      // register
      viewModel.registerFireBaseAuth(email, password , firstName, lastName, userName);

    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context , 'loading...');

  }

  @override
  void showMesaage(String message) {
  Utils.showMessage(context, message, 'OK', (context){
    Navigator.pop(context);
    });
   }

  @override
  void navigateToHome(MyUser user) {
    var providerUser = Provider.of<UserProvider>(context, listen: false);
    providerUser.user = user;
    Timer(Duration(seconds: 5),(){
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    });
  }


}

