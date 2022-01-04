import 'package:BornoBangla/Core/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdmissionCoachingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.92),
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title:
            // Image.asset("assets/logo.png", height: 130),
            Text(
          "Admission Coaching",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(AppRoutes.ADDCOACHINGSCREEN);
            }),
      body: Column(
        children: [
          SizedBox(height: 15),
          Container(),
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1 / 1,
                  crossAxisCount: context.width > 1080 ? 4 : 2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.green, width: 2),
                        image: DecorationImage(
                            image: AssetImage("assets/marslogo.png")),
                        // boxShadow: [
                        //   new BoxShadow(
                        //     color: Colors.black.withOpacity(1),
                        //     blurRadius: 5.0,
                        //   ),
                        // ],
                      ),
                      child: Stack(children: [
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(13),
                                    bottomRight: Radius.circular(13),
                                  ),
                                  color: Colors.green.withOpacity(0.93),
                                ),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                     child: Text(
                                    "MARS",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                  ),
                                )))),
                      ]),
                    ),
                    onTap: () {
                      Get.toNamed(AppRoutes.UCCSCREEN);
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
