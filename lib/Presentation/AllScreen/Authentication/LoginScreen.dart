import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../AllWidgets/progressDialog.dart';
import '../../../Controllers/profile_controller.dart';
import '../../../Core/AppRoutes.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

import '../../../Core/Customization.dart';
import '../../../Data/Models/profile_model.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  int showpass = 0;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Column(
        children: [
          Container(height: MediaQuery.of(context).padding.top, color: Colors.white,),
          Container(
            height: Get.height - MediaQuery.of(context).padding.top,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/loginbg.png"),
                fit: BoxFit.cover,
                opacity: 0.4,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 120,),
                          Image.asset("assets/logo_round.png", height: 70,),
                          SizedBox(height: 60,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.0),
                              child: TextField(
                                controller: emailTextEditingController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.0,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.0),
                              child: TextField(
                                controller: passwordTextEditingController,
                                obscureText: showpass == 0 ? true : false,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon:
                                    showpass == 0 ? Icon(Icons.visibility, size: 25, color: Colors.grey,)
                                        : Icon(Icons.visibility, size: 25, color: primaryColor),
                                    onPressed: () {
                                      setState(() {
                                        showpass == 0 ? showpass = 1 : showpass = 0;
                                      });
                                    },
                                  ),
                                  labelText: "Password",
                                  labelStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.0,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          InkWell(
                            onTap: () async {
                              if (!emailTextEditingController.text.contains("@")) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "Invalid Email", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                                  ),
                                );
                              } else if (passwordTextEditingController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "Password Required!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                                  ),
                                );
                              } else {
                                await loginAndAuthenticateUser(context);
                              }
                              print("clicked Login button");
                            },
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration( color: primaryColor, borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          TextButton(
                            onPressed: (){
                              Get.toNamed(AppRoutes.FORGETSCREEN);
                            },
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.SIGNUPSCREEN);
                    print("clicked to go signup");
                  },
                  child: Container(
                    width: Get.width - 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: primaryColor, width: 1),
                      ),
                      child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(child: Text("Create new account", style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),)),
                  )),
                ),
                SizedBox(height: 45,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Authenticating, Please wait...");
        });

    final User? firebaseuser = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text)
        .catchError((errMsg) {
      print(errMsg.toString());
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Login Failed", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
        ),
      );
    }))
        .user;

    if (firebaseuser != null) {

      print("User is not null");
      try {
        ProfileModel profileModel =
        await ProfileModel.getProfileByUserId(uId: firebaseuser.uid);
        ProfileController.to.profile(profileModel);
      } on Exception catch (e) {
        print(e.toString());
      }
      Get.offAllNamed(AppRoutes.MAINSCREEN);
    } else {
      print("User is null");
    }
  }
}
