import 'package:BornoBangla/Core/AppRoutes.dart';
import 'package:BornoBangla/Data/Models/course_model.dart';
import 'package:BornoBangla/Data/Models/university_model.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class AddUniversityCourseScreen extends StatefulWidget {
  @override
  State<AddUniversityCourseScreen> createState() =>
      _AddUniversityCourseScreenState();
}

class _AddUniversityCourseScreenState extends State<AddUniversityCourseScreen> {
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  List levelList = ["Diploma", "Undergraduate", "Postgraduate", "PhD", "Certificate"];
  String? selectedLevel;
  ScreenshotController screenshotController = ScreenshotController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _requirementsController = TextEditingController();
  TextEditingController _scholarshipController = TextEditingController();
  TextEditingController _admissionFeesController = TextEditingController();
  TextEditingController _tuitionFeesController = TextEditingController();

  UniversityModel _universityModel = Get.arguments;
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Center(
          child: Text(
            "Add New Course",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green, width: 1)),
                  labelText: "Course Name",
                  labelStyle: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green, width: 1)),
                  labelText: "Course Duration",
                  labelStyle: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                          BorderSide(color: Colors.green, width: 1)),
                    ),
                    onChanged: (v) {
                      setState(() {
                        selectedLevel = v;
                      });
                    },
                    value: selectedLevel,
                    hint: Text("Level",
                        style: TextStyle(color: Colors.black)),
                    items: levelList
                        .map((e) => DropdownMenuItem<String>(
                        child: Text(
                          e,
                          textAlign: TextAlign.start,
                        ),
                        alignment: Alignment.topLeft,
                        value: e))
                        .toList()),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _requirementsController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green, width: 1)),
                  labelText: "Requirements",
                  labelStyle: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _scholarshipController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green, width: 1)),
                  labelText: "Scholarship",
                  labelStyle: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _admissionFeesController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green, width: 1)),
                  labelText: "Admission Fees",
                  labelStyle: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _tuitionFeesController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green, width: 1)),
                  labelText: "Tuition Fees",
                  labelStyle: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                child: loader
                    ? Center(
                     child: CircularProgressIndicator(),
                )
                    : RaisedButton(
                  elevation: 0,
                  color: Colors.green,
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  onPressed: () {
                    setState(() {
                      loader = true;
                    });
                    CourseModel courseModel = CourseModel(
                      admissionFees: int.parse(_admissionFeesController.text),
                      tuitionFees: int.parse(_tuitionFeesController.text),
                      name: _nameController.text,
                      level: selectedLevel!,
                      requirements: _requirementsController.text,
                      scholarship: _scholarshipController.text,
                      duration: _durationController.text,
                    );
                    _universityModel.courseList.add(courseModel);
                    _universityModel.update();
                    setState(() {
                      loader = false;
                    });
                    Get.back();
                  },
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
