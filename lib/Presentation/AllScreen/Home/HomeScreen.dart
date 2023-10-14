import 'dart:convert';

import 'package:Appifylab/Core/AppRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;

import '../../../Controllers/profile_controller.dart';
import '../../../Core/Customization.dart';
import '../../../Data/Models/post_model.dart';
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
      body: Obx(()=>ProfileController.to.profile.value == null ? Center(child: CircularProgressIndicator()) : Column(
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
                  InkWell(
                    onTap: (){
                      Get.toNamed(AppRoutes.CREATEPOST);
                  },
                    child: Container(height: 70, color: Colors.white,
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
                  ),
                  Container(height: 8, color: Colors.grey[300],),

                  StreamBuilder<List<PostModel>>(
                      builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              PostModel post = snapshot.data![index];
                              return Container(color: Colors.white,
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
                                          post.caption == "" ? SizedBox() : SizedBox(height: 10,),
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
                                    Container(width: MediaQuery.of(context).size.width, color: Colors.grey[300], height: 0.3,), Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                post.reactions.length < 1 ? Container() : Row(
                                                  children: [
                                                    post.reactions.where((element) => element["reaction"] == "Like").length > 0 ? Padding(
                                                      padding: EdgeInsets.only(right: 1),
                                                      child: Container(
                                                          height: 18, width: 18,
                                                          child: Image.asset("assets/likereacticon.png"),),
                                                    ) : Container(),
                                                    post.reactions.where((element) => element["reaction"] == "Love").length > 0 ? Padding(
                                                      padding: EdgeInsets.only(right: 1),
                                                      child: Container(
                                                        height: 18, width: 18,
                                                        child: Image.asset("assets/lovereacticon.png"),),
                                                    ) : Container(),
                                                    post.reactions.where((element) => element["reaction"] == "Haha").length > 0 ? Padding(
                                                      padding: EdgeInsets.only(right: 1),
                                                      child: Container(
                                                        height: 18, width: 18,
                                                        child: Image.asset("assets/hahareacticon.png"),),
                                                    ) : Container(),
                                                    post.reactions.where((element) => element["reaction"] == "Wow").length > 0 ? Padding(
                                                      padding: EdgeInsets.only(right: 1),
                                                      child: Container(
                                                        height: 18, width: 18,
                                                        child: Image.asset("assets/wowreacticon.png"),),
                                                    ) : Container(),
                                                    post.reactions.where((element) => element["reaction"] == "Sad").length > 0 ? Padding(
                                                      padding: EdgeInsets.only(right: 1),
                                                      child: Container(
                                                        height: 18, width: 18,
                                                        child: Image.asset("assets/cryreacticon.png"),),
                                                    ) : Container(),
                                                    post.reactions.where((element) => element["reaction"] == "Angry").length > 0 ? Padding(
                                                      padding: EdgeInsets.only(right: 1),
                                                      child: Container(
                                                        height: 18, width: 18,
                                                        child: Image.asset("assets/angryreacticon.png"),),
                                                    ) : Container(),
                                                    Text(" ${post.reactions.length}", style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16, fontWeight: FontWeight.normal),),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    post.comments.length < 1 ? Container() : InkWell(
                                                        onTap: (){
                                                          Get.toNamed(AppRoutes.COMMENTPAGE, arguments: post);
                                                        },
                                                        child: Text("${post.comments.length} comments", style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16, fontWeight: FontWeight.normal),)),
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
                                              InkWell(
                                                onLongPress: (){
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          contentPadding: EdgeInsets.zero,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                                          content: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: (){
                                                                  Navigator.pop(context);
                                                                },
                                                                child: InkWell(
                                                                  onTap: () async {
                                                                    if(post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).length > 0){
                                                                      post.reactions.removeWhere((element) => element["id"] == ProfileController.to.profile.value!.id);
                                                                      await post.update();

                                                                      post.reactions = [
                                                                        {
                                                                          "id": ProfileController.to.profile.value!.id,
                                                                          "name": ProfileController.to.profile.value!.name,
                                                                          "image": ProfileController.to.profile.value!.profilePicture,
                                                                          "verified": ProfileController.to.profile.value!.verified,
                                                                          "reaction": "Like",
                                                                        },
                                                                        ...post.reactions
                                                                      ];
                                                                      await post.update();
                                                                      sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} liked to your ${post.image == "" ? "post" : "photo"}");
                                                                      Navigator.pop(context);
                                                                    }
                                                                    else {post.reactions = [
                                                                      {
                                                                        "id": ProfileController.to.profile.value!.id,
                                                                        "name": ProfileController.to.profile.value!.name,
                                                                        "image": ProfileController.to.profile.value!.profilePicture,
                                                                        "verified": ProfileController.to.profile.value!.verified,
                                                                        "reaction": "Like",
                                                                      },
                                                                      ...post.reactions
                                                                    ];
                                                                    await post.update();
                                                                    sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} liked to your ${post.image == "" ? "post" : "photo"}");
                                                                    Navigator.pop(context);
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                      height: 50, width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                                                                      child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(100),
                                                                          child: Image.asset("assets/likereacticon.gif", fit: BoxFit.cover,))),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () async {
                                                                  if(post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).length > 0){
                                                                    post.reactions.removeWhere((element) => element["id"] == ProfileController.to.profile.value!.id);
                                                                    await post.update();

                                                                    post.reactions = [
                                                                      {
                                                                        "id": ProfileController.to.profile.value!.id,
                                                                        "name": ProfileController.to.profile.value!.name,
                                                                        "image": ProfileController.to.profile.value!.profilePicture,
                                                                        "verified": ProfileController.to.profile.value!.verified,
                                                                        "reaction": "Love",
                                                                      },
                                                                      ...post.reactions
                                                                    ];
                                                                    await post.update();
                                                                    sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} loved to your ${post.image == "" ? "post" : "photo"}");
                                                                    Navigator.pop(context);
                                                                  }
                                                                  else {post.reactions = [
                                                                    {
                                                                      "id": ProfileController.to.profile.value!.id,
                                                                      "name": ProfileController.to.profile.value!.name,
                                                                      "image": ProfileController.to.profile.value!.profilePicture,
                                                                      "verified": ProfileController.to.profile.value!.verified,
                                                                      "reaction": "Love",
                                                                    },
                                                                    ...post.reactions
                                                                  ];
                                                                  await post.update();
                                                                  sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} loved to your ${post.image == "" ? "post" : "photo"}");
                                                                  Navigator.pop(context);
                                                                  }
                                                                },
                                                                child: Container(
                                                                    height: 50, width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(100),
                                                                        child: Image.asset("assets/lovereacticon.gif", fit: BoxFit.cover,))),
                                                              ),
                                                              InkWell(
                                                                onTap: () async {
                                                                  if(post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).length > 0){
                                                                    post.reactions.removeWhere((element) => element["id"] == ProfileController.to.profile.value!.id);
                                                                    await post.update();

                                                                    post.reactions = [
                                                                      {
                                                                        "id": ProfileController.to.profile.value!.id,
                                                                        "name": ProfileController.to.profile.value!.name,
                                                                        "image": ProfileController.to.profile.value!.profilePicture,
                                                                        "verified": ProfileController.to.profile.value!.verified,
                                                                        "reaction": "Haha",
                                                                      },
                                                                      ...post.reactions
                                                                    ];
                                                                    await post.update();
                                                                    sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} reacted Haha to your ${post.image == "" ? "post" : "photo"}");
                                                                    Navigator.pop(context);
                                                                  }
                                                                  else {post.reactions = [
                                                                    {
                                                                      "id": ProfileController.to.profile.value!.id,
                                                                      "name": ProfileController.to.profile.value!.name,
                                                                      "image": ProfileController.to.profile.value!.profilePicture,
                                                                      "verified": ProfileController.to.profile.value!.verified,
                                                                      "reaction": "Haha",
                                                                    },
                                                                    ...post.reactions
                                                                  ];
                                                                  await post.update();
                                                                  sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} reacted haha to your ${post.image == "" ? "post" : "photo"}");
                                                                  Navigator.pop(context);
                                                                  }
                                                                },
                                                                child: Container(
                                                                    height: 50, width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(100),
                                                                        child: Image.asset("assets/hahareacticon.gif", fit: BoxFit.cover,))),
                                                              ),
                                                              InkWell(
                                                                onTap: () async {
                                                                  if(post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).length > 0){
                                                                    post.reactions.removeWhere((element) => element["id"] == ProfileController.to.profile.value!.id);
                                                                    await post.update();

                                                                    post.reactions = [
                                                                      {
                                                                        "id": ProfileController.to.profile.value!.id,
                                                                        "name": ProfileController.to.profile.value!.name,
                                                                        "image": ProfileController.to.profile.value!.profilePicture,
                                                                        "verified": ProfileController.to.profile.value!.verified,
                                                                        "reaction": "Wow",
                                                                      },
                                                                      ...post.reactions
                                                                    ];
                                                                    await post.update();
                                                                    sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} reacted Wow to your ${post.image == "" ? "post" : "photo"}");
                                                                    Navigator.pop(context);
                                                                  }
                                                                  else {post.reactions = [
                                                                    {
                                                                      "id": ProfileController.to.profile.value!.id,
                                                                      "name": ProfileController.to.profile.value!.name,
                                                                      "image": ProfileController.to.profile.value!.profilePicture,
                                                                      "verified": ProfileController.to.profile.value!.verified,
                                                                      "reaction": "Wow",
                                                                    },
                                                                    ...post.reactions
                                                                  ];
                                                                  await post.update();
                                                                  sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} reacted Wow to your ${post.image == "" ? "post" : "photo"}");
                                                                  Navigator.pop(context);
                                                                  }
                                                                },
                                                                child: Container(
                                                                    height: 50, width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(100),
                                                                        child: Image.asset("assets/wowreacticon.gif", fit: BoxFit.cover,))),
                                                              ),
                                                              InkWell(
                                                                onTap: () async {
                                                                  if(post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).length > 0){
                                                                    post.reactions.removeWhere((element) => element["id"] == ProfileController.to.profile.value!.id);
                                                                    await post.update();

                                                                    post.reactions = [
                                                                      {
                                                                        "id": ProfileController.to.profile.value!.id,
                                                                        "name": ProfileController.to.profile.value!.name,
                                                                        "image": ProfileController.to.profile.value!.profilePicture,
                                                                        "verified": ProfileController.to.profile.value!.verified,
                                                                        "reaction": "Sad",
                                                                      },
                                                                      ...post.reactions
                                                                    ];
                                                                    await post.update();
                                                                    sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} reacted Sad to your ${post.image == "" ? "post" : "photo"}");
                                                                    Navigator.pop(context);
                                                                  }
                                                                  else {post.reactions = [
                                                                    {
                                                                      "id": ProfileController.to.profile.value!.id,
                                                                      "name": ProfileController.to.profile.value!.name,
                                                                      "image": ProfileController.to.profile.value!.profilePicture,
                                                                      "verified": ProfileController.to.profile.value!.verified,
                                                                      "reaction": "Sad",
                                                                    },
                                                                    ...post.reactions
                                                                  ];
                                                                  await post.update();
                                                                  sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} reacted Sad to your ${post.image == "" ? "post" : "photo"}");
                                                                  Navigator.pop(context);
                                                                  }
                                                                },
                                                                child: Container(
                                                                    height: 50, width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(100),
                                                                        child: Image.asset("assets/cryreacticon.gif", fit: BoxFit.cover,))),
                                                              ),
                                                              InkWell(
                                                                onTap: () async {
                                                                  if(post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).length > 0){
                                                                    post.reactions.removeWhere((element) => element["id"] == ProfileController.to.profile.value!.id);
                                                                    await post.update();

                                                                    post.reactions = [
                                                                      {
                                                                        "id": ProfileController.to.profile.value!.id,
                                                                        "name": ProfileController.to.profile.value!.name,
                                                                        "image": ProfileController.to.profile.value!.profilePicture,
                                                                        "verified": ProfileController.to.profile.value!.verified,
                                                                        "reaction": "Angry",
                                                                      },
                                                                      ...post.reactions
                                                                    ];
                                                                    await post.update();
                                                                    sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} reacted Angry to your ${post.image == "" ? "post" : "photo"}");
                                                                    Navigator.pop(context);
                                                                  }
                                                                  else {post.reactions = [
                                                                    {
                                                                      "id": ProfileController.to.profile.value!.id,
                                                                      "name": ProfileController.to.profile.value!.name,
                                                                      "image": ProfileController.to.profile.value!.profilePicture,
                                                                      "verified": ProfileController.to.profile.value!.verified,
                                                                      "reaction": "Angry",
                                                                    },
                                                                    ...post.reactions
                                                                  ];
                                                                  await post.update();
                                                                  sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} reacted Angry to your ${post.image == "" ? "post" : "photo"}");
                                                                  Navigator.pop(context);
                                                                  }
                                                                },
                                                                child: Container(
                                                                    height: 50, width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(100),
                                                                        child: Image.asset("assets/angryreacticon.gif", fit: BoxFit.cover,))),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                onTap: () async {
                                                  if(post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).length > 0){
                                                    post.reactions.removeWhere((element) => element["id"] == ProfileController.to.profile.value!.id);
                                                    await post.update();
                                                  }
                                                  else {
                                                    post.reactions = [
                                                    {
                                                      "id": ProfileController.to.profile.value!.id,
                                                      "name": ProfileController.to.profile.value!.name,
                                                      "image": ProfileController.to.profile.value!.profilePicture,
                                                      "verified": ProfileController.to.profile.value!.verified,
                                                      "reaction": "Like",
                                                    },
                                                    ...post.reactions
                                                  ];
                                                  await post.update();}
                                                  sendReactPush(post.posterID, "New Reaction", "${ProfileController.to.profile.value!.name} liked to your ${post.image == "" ? "post" : "photo"}");
                                                },
                                                child: post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).length > 0 ? Row(
                                                  children: [
                                                    Image.asset(post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"] == "Like" ? "assets/likereacticon.png" : post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"] == "Love" ? "assets/lovereacticon.png" : post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"] == "Haha" ? "assets/hahareacticon.png" : post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"] == "Wow" ? "assets/wowreacticon.png" : post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"] == "Sad" ? "assets/cryreacticon.png" : post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"] == "Angry" ? "assets/angryreacticon.png" : "assets/logo.png", height: 20, width: 20,),
                                                    Text(" ${post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"]}", style: TextStyle(color: post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"] == "Like" ? primaryColor : post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"] == "Love" ? Colors.red : post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"] == "Haha" ? Colors.amber : post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"] == "Wow" ? Colors.amber : post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"] == "Sad" ? Colors.amber : post.reactions.where((element) => element["id"] == ProfileController.to.profile.value!.id).toList().first["reaction"] == "Angry" ? Colors.deepOrange : Colors.black.withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.bold),),
                                                  ],
                                                ) : Row(
                                                  children: [
                                                    Icon(Icons.thumb_up_alt_outlined, color: Colors.black.withOpacity(0.5), size: 20,),
                                                    Text(" Like", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.bold),),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  Get.toNamed(AppRoutes.COMMENTPAGE, arguments: post);
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.chat_bubble_outline, color: Colors.black.withOpacity(0.5), size: 20,),
                                                    Text(" Comment", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.bold),),
                                                  ],
                                                ),
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
                              );
                            },
                            itemCount: snapshot.data?.length ?? 0,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                      stream: PostModel.getPosts()),
                ],
              ),
            ),
          ),
        ],
      )),
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
