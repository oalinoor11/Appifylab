import 'package:BornoBangla/AllWidgets/progressDialog.dart';
import 'package:BornoBangla/Core/AppRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import '../../main.dart';
import 'mainscreen.dart';


class SignInScreen extends StatelessWidget
{
  static const String idScreen = "login";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [Container(),
              SizedBox(height: 80.0,),
              Image(image: AssetImage("assets/coppedlogo.png"),
                height: 180,
                alignment: Alignment.center,
              ),

              SizedBox(height: 10.0,),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    SizedBox(height: 5.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),

                    SizedBox(height: 5.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),

                    SizedBox(height: 20.0,),
                    RaisedButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "bolt-semibold",
                            ),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: ()
                      {
                        if(!emailTextEditingController.text.contains("@"))
                        {
                          Get.snackbar(
                            "Invalid Email!",
                            "Enter correct email address",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }

                        else if(passwordTextEditingController.text.isEmpty)
                        {
                          Get.snackbar(
                            "Password Required!",
                            "Enter your account password",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }

                        else
                        {
                          loginAndAuthenticateUser(context);
                        }
                        print("clicked Login button");
                      },
                    ),
                  ],
                ),
              ),

              TextButton(
                onPressed: (){
                  Get.offAllNamed(AppRoutes.SIGNUPSCREEN);
                  print("clicked to go signup");
                },
                child: Text(
                    "Do not have an Account? Register Here.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Authenticating, Please wait...");
        }
    );

    final User? firebaseuser = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      Get.snackbar(
        "Login Failed!",
        "Invalid Login information",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    })).user;

    if(firebaseuser != null)
    {
      userRef.child(firebaseuser.uid).once().then((DataSnapshot snap)
      {
        if(snap.value != null)
        {
          Get.offAllNamed(AppRoutes.MAINSCREEN);
          Get.snackbar(
            "Login Success!",
            "You are Logged in successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
        else
        {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          Get.snackbar(
            "Login Failed!",
            "You don't have an account",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      });

    }
    else
    {
      Navigator.pop(context);
      Get.snackbar(
          "Error!",
          "an error occurred",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
      );
    }
  }

}
