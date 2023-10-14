import 'dart:convert';

import 'package:Appifylab/Core/AppRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;

import '../../../Controllers/profile_controller.dart';
import '../../../Core/Customization.dart';
import '../../../Data/Models/post_model.dart';
import '../../../Data/Models/profile_model.dart';

class CommentPage extends StatefulWidget {
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  PostModel post = Get.arguments;

  TextEditingController commentController = TextEditingController();

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
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: (){
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back_ios)),
                        Container(
                          height: 40, width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(post.posterImage, fit: BoxFit.cover,)),
                        ),
                        SizedBox(width: 10,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(post.posterName, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                                SizedBox(width: 3,),
                                post.posterVerified == "1" ? Icon(Icons.verified, color: primaryColor, size: 15,) : Container(),
                              ],
                            ),
                            Row(
                              children: [
                                Text("${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(post.timeStamps), isUtc: false)).inMinutes.toString() == "0" ? "now" : int.parse(DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(post.timeStamps), isUtc: false)).inMinutes.toString()) < 60 ? "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(post.timeStamps), isUtc: false)).inMinutes.toString()} m" : int.parse(DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(post.timeStamps), isUtc: false)).inHours.toString()) < 24 ? "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(post.timeStamps), isUtc: false)).inHours.toString()} h" : "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(post.timeStamps), isUtc: false)).inDays.toString()} d"} • ", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14, fontWeight: FontWeight.normal),),
                                post.privacy == "Public" ? Icon(Icons.public, color: Colors.black.withOpacity(0.5), size: 15,) : Container(),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: (){
                              if(post.posterID != ProfileController.to.profile.value!.id){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "This feature is not created!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                                  ),
                                );
                              }
                              else{
                                Get.toNamed(AppRoutes.EDITEPOST, arguments: post);
                              }
                            },
                            child: Icon(post.posterID != ProfileController.to.profile.value!.id ? Icons.more_horiz : Icons.edit, color: Colors.black.withOpacity(0.5), size: post.posterID != ProfileController.to.profile.value!.id ? 25 : 20,)),
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
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [Container(),
                  Container(color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
                          child: Column(
                            children: [
                              post.caption == "" ? SizedBox() : Align(
                                alignment: Alignment.centerLeft,
                                child: ReadMoreText(
                                  post.caption,
                                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                                  trimLines: 3,
                                  colorClickableText: Colors.grey,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: '... See more',
                                  trimExpandedText: '... See less',
                                  moreStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)),
                                  lessStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)),
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                        post.image == "" ? SizedBox() : Container(width: MediaQuery.of(context).size.width, color: Colors.grey[300], height: 0.3,),
                        post.image == "" ? SizedBox() : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20,
                            child: Image.network(post.image, fit: BoxFit.cover,),
                          ),
                        ),
                        Container(width: MediaQuery.of(context).size.width, color: Colors.grey[300], height: 0.3,),
                        Container(
                          height: MediaQuery.of(context).size.height - 300,
                          // color: Colors.red,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: post.comments.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
                                child: Column(
                                  children: [
                                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40, width: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: Image.network(post.comments[index]["image"], fit: BoxFit.cover,)),
                                        ),
                                        SizedBox(width: 10,),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(post.comments[index]["name"], style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                                                    SizedBox(width: 3,),
                                                    post.comments[index]["verified"] == "1" ? Icon(Icons.verified, color: primaryColor, size: 15,) : Container(),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Container(
                                                  width: MediaQuery.of(context).size.width - 100,
                                                  child: ReadMoreText(
                                                    post.comments[index]["comment"],
                                                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),
                                                    trimLines: 3,
                                                    colorClickableText: Colors.grey,
                                                    trimMode: TrimMode.Line,
                                                    trimCollapsedText: '... See more',
                                                    trimExpandedText: '... See less',
                                                    moreStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)),
                                                    lessStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)),
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                Text("${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(post.comments[index]["timeStamps"]), isUtc: false)).inMinutes.toString() == "0" ? "now" : int.parse(DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(post.comments[index]["timeStamps"]), isUtc: false)).inMinutes.toString()) < 60 ? "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(post.comments[index]["timeStamps"]), isUtc: false)).inMinutes.toString()} m" : int.parse(DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(post.comments[index]["timeStamps"]), isUtc: false)).inHours.toString()) < 24 ? "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(post.comments[index]["timeStamps"]), isUtc: false)).inHours.toString()} h" : "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(post.comments[index]["timeStamps"]), isUtc: false)).inDays.toString()} d"} ago", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12),),

                                              ]),
                                          ),
                                        )])]));}),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //post comment
          Container(height: 0.3, width: MediaQuery.of(context).size.width, color: Colors.grey[300],),
          Container(color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
              child: Column(
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
                      Expanded(
                        child: TextFormField(
                          controller: commentController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Write a comment...",
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.normal),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: () async {
                            if(commentController.text.isNotEmpty){
                              post.comments = [
                                {
                                  "id": ProfileController.to.profile.value!.id,
                                  "name": ProfileController.to.profile.value!.name,
                                  "image": ProfileController.to.profile.value!.profilePicture,
                                  "verified": ProfileController.to.profile.value!.verified,
                                  "comment": commentController.text,
                                  "timeStamps": DateTime.now().millisecondsSinceEpoch.toString(),
                                },
                                ...post.comments
                              ];
                              await post.update();
                              sendReactPush(post.posterID, "New Comment", "${ProfileController.to.profile.value!.name} commented on your ${post.image == "" ? "post" : "photo"}");
                              commentController.clear();
                              Get.back();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: primaryColor,
                                  content: Text(
                                    "Commented Successfully!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                                ),
                              );
                            }
                          },
                          child: Icon(Icons.send, color: primaryColor, size: 25,)),
                    ],
                  ),
                  SizedBox(height: 10,),
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
  sendReactPush(String channel, String title, String body) async {
    if(channel != ProfileController.to.profile.value!.id){
      var response = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "key=AAAAB0THxvk:APA91bGuEA14fgLQorOjtIIPMkwIjaYYBEF1E0HgMkhmgUNqfydjYeuxX1EpPi6sphube1JRetbaW-jlWTnVgW7J6N4C8Ez4CrG421A8cg85QVPl4xuIPnHMJF38T8_0boZV0DSUorF_"
          },
          body: jsonEncode({
            "to": "/topics/$channel",
            "notification": {
              "title": title,
              "body": body,
              "mutable_content": true,
            },
            "data": {
              // "url": "<url of media image>",
              // "dl": "<deeplink action on tap of notification>"
            }
          })
      );
      print(response.body);
    }
  }
}
