import 'package:Appifylab/Core/AppRoutes.dart';
import 'package:Appifylab/Data/Models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readmore/readmore.dart';
import 'dart:io';

import '../../../Controllers/profile_controller.dart';
import '../../../Core/Customization.dart';
import '../../../Data/Models/profile_model.dart';

class CreatePost extends StatefulWidget {
  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  TextEditingController postcaptionController = TextEditingController();
  File? image;
  bool loader = false;

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
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [Container(),
                  Container(height: 70, color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: (){
                                Get.back();
                              },
                              child: Icon(Icons.close, color: Colors.black, size: 28,)),
                          Text("Create post", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                          loader ? Center(child: CircularProgressIndicator()) : InkWell(
                            onTap: () async {
                              if(image != null) {
                                setState(() {
                                  loader = true;
                                });

                                var upload = await FirebaseStorage.instance
                                    .ref()
                                    .child("PostImages")
                                    .child(ProfileController.to.profile.value!.id.toString() + DateTime.now().millisecondsSinceEpoch.toString())
                                    .putFile(image!);
                                var downloadUrl = await upload.ref.getDownloadURL();

                                await PostModel(
                                  caption: postcaptionController.text,
                                  image: downloadUrl,
                                  posterID: ProfileController.to.profile.value!.id.toString(),
                                  posterName: ProfileController.to.profile.value!.name.toString(),
                                  posterImage: ProfileController.to.profile.value!.profilePicture.toString(),
                                  posterVerified: ProfileController.to.profile.value!.verified.toString(),
                                  privacy: "Public",
                                  timeStamps: DateTime.now().millisecondsSinceEpoch.toString(),
                                  comments: [],
                                  reactions: [],
                                  shares: [],
                                  hideto: [],
                                  reports: [],
                                ).save();

                                setState(() {
                                  loader = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: primaryColor,
                                    content: Text(
                                      "Post Created!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                                  ),
                                );
                                Get.offAllNamed(AppRoutes.MAINSCREEN);
                              } else {
                                setState(() {
                                  loader = true;
                                });

                                await PostModel(
                                  caption: postcaptionController.text,
                                  image: "",
                                  posterID: ProfileController.to.profile.value!.id.toString(),
                                  posterName: ProfileController.to.profile.value!.name.toString(),
                                  posterImage: ProfileController.to.profile.value!.profilePicture.toString(),
                                  posterVerified: ProfileController.to.profile.value!.verified.toString(),
                                  privacy: "Public",
                                  timeStamps: DateTime.now().millisecondsSinceEpoch.toString(),
                                  comments: [],
                                  reactions: [],
                                  shares: [],
                                  hideto: [],
                                  reports: [],
                                ).save();

                                setState(() {
                                  loader = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: primaryColor,
                                    content: Text(
                                      "Post Created!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                                  ),
                                );
                                Get.offAllNamed(AppRoutes.MAINSCREEN);
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: primaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Text("Post", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 1, color: Colors.grey[300],),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                          children: [
                            Container(
                              height: 45, width: 45,
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
                                    SizedBox(width: 3,),
                                    ProfileController.to.profile.value!.verified.toString() == "1" ? Icon(Icons.verified, color: primaryColor, size: 15,) : Container(),
                                  ],
                                ),
                                SizedBox(height: 4,),
                                Row(
                                  children: [
                                    Icon(Icons.public, color: Colors.black.withOpacity(0.5), size: 15,),
                                    Text(" Public", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14, fontWeight: FontWeight.normal),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                  ),

                  Container(height: Get.height/5, color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: true,
                      controller: postcaptionController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: "What's on your mind?",
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.normal),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  ),
                  Container(height: 1, color: Colors.grey[300],),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () async {
                        var pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          setState(() {
                            image = File(pickedFile.path);
                          });
                        }
                      },
                      child: Container(
                        decoration: new BoxDecoration(
                          border:
                          Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: image == null ?
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset("assets/addimage.png", fit: BoxFit.cover, color: Colors.grey,),
                        )
                            : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(image!)),
                      ),
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
