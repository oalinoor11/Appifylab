import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Core/AppRoutes.dart';
import 'package:flutter/services.dart';

import '../../../Core/Customization.dart';

class FriendsPage extends StatefulWidget {

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {

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
      body: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/nofriends.png", height: Get.width/1.2,),
            ],
          ),
          SizedBox(height: 20,),
          Text("You have no friends yet!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),),
        ],
      ),
    );
  }
}
