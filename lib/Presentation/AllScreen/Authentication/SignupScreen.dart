import 'package:country_dial_code/country_dial_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../../AllWidgets/progressDialog.dart';
import '../../../Controllers/profile_controller.dart';
import '../../../Core/AppRoutes.dart';
import '../../../Core/Customization.dart';
import '../../../Data/Models/profile_model.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

class SignupScreen extends StatefulWidget {

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int showpass = 0;
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController firstnameTextEditingController = TextEditingController();
  String countryCode = "+880";
  File? image;

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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    GestureDetector(
                      onTap: () async {
                        var pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          setState(() {
                            image = File(pickedFile.path);
                          });
                        }
                      },
                      child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: <Widget> [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: new BoxDecoration(
                                border:
                                Border.all(color: Colors.blue, width: 1.5),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: image == null ?
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset("assets/sampleprofilepicture.png", fit: BoxFit.cover,),
                              )
                                  : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(image!)),
                            ),
                            Positioned(
                              left: 65,
                              top: 70,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: new BoxDecoration(
                                  boxShadow: [
                                    new BoxShadow(
                                      color: primaryColor,
                                      blurRadius: 0,
                                    ),
                                  ],
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Container(child: Icon(Icons.photo_camera, size: 16, color: Colors.white,)),
                              ),
                            ),
                          ]
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 14.0,
                          ),
                          Expanded(
                            child: TextField(
                              controller: firstnameTextEditingController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Name",
                                labelStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
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
                      child: Row(
                        children: [
                          SizedBox(
                            width: 4.0,
                          ),
                          CountryDialCodePicker(
                            initialSelection: 'BD',
                            flagImageSettings: FlagImageSettings(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            bottomSheetSettings: BottomSheetSettings(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              searchTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                countryCode = value.dialCode;
                              });
                              print(countryCode);
                            },
                          ),
                          Expanded(
                            child: TextField(
                              controller: phoneTextEditingController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Phone",
                                labelStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
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
                      child: Row(
                        children: [
                          SizedBox(
                            width: 14.0,
                          ),
                          Expanded(
                            child: TextField(
                              controller: emailTextEditingController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Email",
                                labelStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
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
                      child: Row(
                        children: [
                          SizedBox(
                            width: 14.0,
                          ),
                          Expanded(
                            child: TextField(
                              controller: passwordTextEditingController,
                              obscureText: showpass == 0 ? true : false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
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
                              ),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    InkWell(
                      onTap: (){
                        if (firstnameTextEditingController.text.length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Enter Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                            ),
                          );
                        } else if (phoneTextEditingController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Enter Phone", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                            ),
                          );
                        } else if (!emailTextEditingController.text
                            .contains("@")) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Invalid Email", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                            ),
                          );
                        } else if (passwordTextEditingController.text.length <
                            6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Set a strong Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                            ),
                          );
                        } else {
                          registerNewUser(context);
                        }
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration( color: primaryColor, borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.LOGINSCREEN);
                        print("clicked to go signup");
                      },
                      child: Text(
                        "Already have an account? Login here",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Creating new account, Please wait...",);
        });

    final User? firebaseuser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text)
        .catchError((errMsg) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Request Failed", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
        ),
      );
    }))
        .user;

    if (firebaseuser != null) //user created
        {
          if(image != null){
            var upload = await FirebaseStorage.instance
                .ref()
                .child("ProfilePictures")
                .child(firebaseuser.uid)
                .putFile(image!);
            var downloadUrl = await upload.ref.getDownloadURL();
            var profile = ProfileModel(
              id: firebaseuser.uid,
              name: firstnameTextEditingController.text,
              phone: countryCode + phoneTextEditingController.text,
              email: emailTextEditingController.text,
              address: "",
              verified: "0",
              profilePicture: downloadUrl,
              msg: "0",
              timeStamps: DateTime.now().millisecondsSinceEpoch.toString(),
              posts: [],
            )..save();
            ProfileController.to.profile(profile);
            fcmSubscribe(firebaseuser.uid.toString());

            Get.offAllNamed(AppRoutes.MAINSCREEN);
          }
          else{
            var profile = ProfileModel(
              id: firebaseuser.uid,
              name: firstnameTextEditingController.text,
              phone: countryCode + phoneTextEditingController.text,
              email: emailTextEditingController.text,
              address: "",
              verified: "0",
              profilePicture: "https://firebasestorage.googleapis.com/v0/b/appifylab-b8a18.appspot.com/o/ProfilePictures%2Fsampleprofilepicture.png?alt=media&token=49ffb1b1-43cf-4614-8a46-f70d24c0e218&_gl=1*1vw85qw*_ga*MTI4NjA5MTYzNS4xNjk3MTI2MTIy*_ga_CW55HF8NVT*MTY5NzIyMzg5Ny42LjEuMTY5NzIyMzk0My4xNC4wLjA.",
              msg: "0",
              timeStamps: DateTime.now().millisecondsSinceEpoch.toString(),
              posts: [],
            )..save();
            ProfileController.to.profile(profile);
            fcmSubscribe(firebaseuser.uid.toString());

            Get.offAllNamed(AppRoutes.MAINSCREEN);
          }
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Request Failed", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
        ),
      );
    }
  }

  fcmSubscribe(String userUID) async {
    FirebaseMessaging.instance.subscribeToTopic("all");
    FirebaseMessaging.instance.subscribeToTopic(userUID);
  }
}
