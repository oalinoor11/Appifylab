import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'Home/HomeScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    _checkVersion();
    super.initState();
  }

  void _checkVersion() async {
    final newVersion = NewVersion();

    final status = await newVersion.getVersionStatus();
    print(status?.localVersion.toString());
    print(status?.storeVersion.toString());

    if(status?.localVersion.toString() != status?.storeVersion.toString())
    {
      print("Update availabe");
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status!,
        dialogTitle: "Update Available",
        dismissButtonText: "Skip",
        dialogText: "You're missing out something!",
        dismissAction: () {
          Get.back();
        },
        updateButtonText: "Update Now",
      );
    }
    else
    {print("Update not availabe");}
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.green,
          onTap: (index) {
            pageController.jumpToPage(index);
            setState(() {
              currentIndex = index;
            });
            // pageController.animateToPage(index, duration: Duration(seconds: 0), curve: Curves.ease);
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
          ],
        ),
        body: PageView(
          controller: pageController,
          children: [
            HomeScreen(),
            HomeScreen(),
          ],
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
