import 'dart:io';

import 'package:BornoBangla/Core/AppRoutes.dart';
import 'package:BornoBangla/Data/Models/coaching_model.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class EditCoachingScreen extends StatefulWidget {
  @override
  State<EditCoachingScreen> createState() => _EditCoachingScreenState();
}

class _EditCoachingScreenState extends State<EditCoachingScreen> {
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  ScreenshotController screenshotController = ScreenshotController();

  CoachingModel coachingModel = Get.arguments;

  TextEditingController nameController = TextEditingController();
  List ratingList = ["1", "2", "3", "4", "5"];
  String? selectedRating;
  File? image;
  File? bannerImages;
  bool loader = false;
  @override
  void initState() {
    nameController = TextEditingController(text: coachingModel.name);
    selectedRating = coachingModel.rating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Center(
          child: Text(
            "Edit Coaching",
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
                controller: nameController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green, width: 1)),
                  labelText: "Coaching Name",
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
                        selectedRating = v;
                      });
                    },
                    value: selectedRating,
                    hint: Text("Coaching Rating",
                        style: TextStyle(color: Colors.black)),
                    items: ratingList
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
              InkWell(
                onTap: () async {
                  print("camera button clicked");
                  var pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      image = File(pickedFile.path);
                    });
                  }
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: image == null
                      ? Image.network(coachingModel.image)
                      : Image.file(image!),
                ),
              ),
              Text(
                "(image ratio should be 1/1)",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  print("camera button clicked");
                  var pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      bannerImages = File(pickedFile.path);
                    });
                  }
                },
                child: Container(
                  height: 90,
                  width: 160,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: bannerImages == null
                      ? Image.network(coachingModel.bannerImages)
                      : Image.file(bannerImages!),
                ),
              ),
              Text(
                "(image ratio should be 16/9)",
                style: TextStyle(color: Colors.grey),
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
                        onPressed: () async {
                          setState(() {
                            loader = true;
                          });
                          if (image != null) {
                            var upload = await FirebaseStorage.instance
                                .ref()
                                .child("image")
                                .child(nameController.text)
                                .putFile(image!);
                            var downloadUrl = await upload.ref.getDownloadURL();
                            coachingModel.image = downloadUrl;
                          }
                          if (bannerImages != null) {
                            var upload2 = await FirebaseStorage.instance
                                .ref()
                                .child("banner")
                                .child(nameController.text)
                                .putFile(bannerImages!);
                            var bannerUrls = await upload2.ref.getDownloadURL();

                            coachingModel.bannerImages = bannerUrls;
                          }
                          coachingModel.name = nameController.text;
                          await coachingModel.update();
                          setState(() {
                            loader = false;
                          });
                          Get.back();
                        },
                        child: Center(
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                child: RaisedButton(
                  elevation: 0,
                  color: Colors.red,
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  onPressed: () async {
                    setState(() {
                      loader = true;
                    });
                    var result = await CoolAlert.show(
                      backgroundColor: Colors.green,
                      confirmBtnColor: Colors.red,
                      confirmBtnText: ("Delete"),
                      width: 10,
                      context: context,
                      type: CoolAlertType.confirm,
                      onCancelBtnTap: () => Get.back(result: false),
                      onConfirmBtnTap: () => Get.back(result: true),
                    );
                    if (result) {
                      await coachingModel.delete();
                      setState(() {
                        loader = false;
                      });
                    }
                    setState(() {
                      loader = false;
                    });
                    Get.back();
                  },
                  child: Center(
                    child: Text(
                      "Delete Coaching",
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
