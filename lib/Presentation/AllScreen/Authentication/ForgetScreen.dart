import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Core/AppRoutes.dart';
import 'package:flutter/services.dart';

import '../../../Core/Customization.dart';

class ForgetScreen extends StatefulWidget {

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  TextEditingController emailTextEditingController = TextEditingController();

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
                Padding(
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
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      InkWell(
                        onTap: (){
                          if (!emailTextEditingController.text.contains("@")) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Invalid Email", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                              ),
                            );
                          }
                          else {
                            FirebaseAuth.instance.sendPasswordResetEmail(email: emailTextEditingController.text);
                            Get.offAllNamed(AppRoutes.LOGINSCREEN);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: primaryColor,
                                content: Text(
                                  "Password reset link sent to your email", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                              ),
                            );
                          }
                          print("clicked reset button");
                        },
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration( color: primaryColor, borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              "Reset Password",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
