import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'Controllers/profile_controller.dart';
import 'Core/AppRoutes.dart';
import 'Core/notificationService.dart';
import 'Data/Models/profile_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    NotificationService.init();
    Get.lazyPut(() => ProfileController());
    storeUserData();
    super.initState();
  }

  void storeUserData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await ProfileModel.getProfileByUserId(
          uId: FirebaseAuth.instance.currentUser!.uid);
      ProfileController.to.profile(profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Appifylab',
      theme: ThemeData(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)),
      initialRoute: FirebaseAuth.instance.currentUser == null ? AppRoutes.LOGINSCREEN : AppRoutes.MAINSCREEN,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
