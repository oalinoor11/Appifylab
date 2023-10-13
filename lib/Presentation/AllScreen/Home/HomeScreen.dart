import 'package:Appifylab/Core/AppRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:readmore/readmore.dart';

import '../../../Controllers/profile_controller.dart';
import '../../../Core/Customization.dart';
import '../../../Data/Models/profile_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(height: MediaQuery.of(context).padding.top, color: Colors.white,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("facebook", style: TextStyle(color: primaryColor, fontSize: 30, fontWeight: FontWeight.bold),),
                Row(
                  children: [
                    Container(
                        height: 35, width: 35,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(child: Icon(Icons.add, color: Colors.black, size: 25, ))),
                    SizedBox(width: 10,),
                    Container(
                        height: 35, width: 35,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(child: Icon(Icons.search, color: Colors.black, size: 25, ))),
                    SizedBox(width: 10,),
                    Container(
                        height: 35, width: 35,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(child: Icon(Icons.speaker_notes, color: Colors.black, size: 20, ))),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [Container(),
                  Container(height: 70, color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset("assets/sampleprofilepicture.png", fit: BoxFit.cover,)),
                            ),
                            SizedBox(width: 10,),
                            Text("What's on your mind?", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),)
                          ],
                        ),
                        Icon(Icons.photo_library, color: Colors.green, size: 28,)
                      ],
                    ),
                  ),
                  ),
                  Container(height: 8, color: Colors.grey[300],),

                  Container(color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                          child: Column(
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 40, width: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: Image.network(ProfileController.to.profile.value!.profilePicture.toString(), fit: BoxFit.cover,)),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(ProfileController.to.profile.value!.name.toString(), style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                                              SizedBox(width: 5,),
                                              ProfileController.to.profile.value!.verified.toString() == "1" ? Icon(Icons.verified, color: primaryColor, size: 15,) : Container(),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("15h • ", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14, fontWeight: FontWeight.normal),),
                                              Icon(Icons.public, color: Colors.black.withOpacity(0.5), size: 15,),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.more_horiz, color: Colors.black.withOpacity(0.5), size: 25,),
                                      SizedBox(width: 15,),
                                      InkWell(
                                          onTap: (){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                  "This feature is not created!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.close, color: Colors.black.withOpacity(0.5), size: 25,)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              ReadMoreText(
                                'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                                trimLines: 3,
                                colorClickableText: Colors.grey,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: '... See more',
                                trimExpandedText: '... See less',
                                moreStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)),
                                lessStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                        Container(width: MediaQuery.of(context).size.width, color: Colors.grey[300], height: 0.3,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20,
                            child: Image.asset("assets/logo.png", fit: BoxFit.cover,),
                          ),
                        ),
                        Container(width: MediaQuery.of(context).size.width, color: Colors.grey[300], height: 0.3,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 1),
                                          child: Container(
                                              height: 18, width: 18,
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Center(child: Icon(Icons.thumb_up, color: Colors.white, size: 12,))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 1),
                                          child: Container(
                                              height: 18, width: 18,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Center(child: Icon(Icons.favorite, color: Colors.white, size: 13,))),
                                        ),
                                        Text(" 61.2k", style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16, fontWeight: FontWeight.normal),),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("1.9k comments", style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16, fontWeight: FontWeight.normal),),
                                        SizedBox(width: 15,),
                                        Text("10 shares", style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16, fontWeight: FontWeight.normal),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(width: MediaQuery.of(context).size.width - 20, color: Colors.grey[300], height: 0.5,),
                              SizedBox(height: 10,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.thumb_up_alt_outlined, color: Colors.black.withOpacity(0.5), size: 20,),
                                      Text(" Like", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.chat_bubble_outline, color: Colors.black.withOpacity(0.5), size: 20,),
                                      Text(" Comment", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: (){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            "This feature is not created!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.share, color: Colors.black.withOpacity(0.5), size: 20,),
                                        Text(" Share", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(height: 8, color: Colors.grey[300],),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  _signOutDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 25.0, bottom: 25.0),
                    child: Center(
                      child: Text(
                        "Are you sure?",
                        style:
                        TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style:
                          TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "You are Logged Out!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                            ),
                          );
                          Get.offAllNamed(AppRoutes.LOGINSCREEN);
                          await FirebaseMessaging.instance.unsubscribeFromTopic('all');
                          await FirebaseMessaging.instance.unsubscribeFromTopic(ProfileController.to.profile.value!.id.toString());
                          FirebaseAuth.instance.signOut();
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          );
        });
  }
}
