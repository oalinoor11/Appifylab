import 'package:BornoBangla/Core/AppRoutes.dart';
import 'package:BornoBangla/Presentation/AllScreen/Preparation/add_branch_page.dart';
import 'package:BornoBangla/Presentation/Controllers/coaching_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreparationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title:
            // Image.asset("assets/logo.png", height: 130),
            Center(
              child: Text(
          "Preparation",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
            ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(AddBranchPage());
            },
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.fromLTRB(11.0, 0.0, 11.0, 0.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        height: 180.0,
                        width: 175.0,
                        decoration: new BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: AssetImage("assets/admissioncoaching.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        CoachingController.to.selectedType('Admission');
                        Get.toNamed(AppRoutes.ADMISSIONCOACHINGSCREEN);
                      },
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      child: Container(
                        height: 180.0,
                        width: 175.0,
                        decoration: new BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: AssetImage("assets/academiccoaching.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        CoachingController.to.selectedType('Academic');
                        Get.toNamed(AppRoutes.ADMISSIONCOACHINGSCREEN);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        height: 180.0,
                        width: 175.0,
                        decoration: new BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: AssetImage("assets/ieltscoaching.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        CoachingController.to.selectedType('IELTS');
                        Get.toNamed(AppRoutes.ADMISSIONCOACHINGSCREEN);
                      },
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      child: Container(
                        height: 180.0,
                        width: 175.0,
                        decoration: new BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: AssetImage("assets/jobcoaching.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        CoachingController.to.selectedType('Job');
                        Get.toNamed(AppRoutes.ADMISSIONCOACHINGSCREEN);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        height: 180.0,
                        width: 175.0,
                        decoration: new BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: AssetImage("assets/issbcoaching.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        CoachingController.to.selectedType('ISSB');
                        Get.toNamed(AppRoutes.ADMISSIONCOACHINGSCREEN);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
