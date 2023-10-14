import 'package:Appifylab/Presentation/AllScreen/Authentication/LoginScreen.dart';
import 'package:Appifylab/Presentation/AllScreen/Authentication/SignupScreen.dart';
import 'package:Appifylab/Presentation/AllScreen/Home/HomeScreen.dart';
import 'package:Appifylab/Presentation/Posts/CommentPage.dart';
import 'package:Appifylab/Presentation/Posts/CreatePost.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../Presentation/AllScreen/Authentication/ForgetScreen.dart';
import '../Presentation/AllScreen/MainScreen.dart';
import '../Presentation/Posts/EditPost.dart';
class AppRoutes {
  static const String MAINSCREEN = "/mainscreen";
  static const String HOMESCREEN = "/homescreen";
  static const String LOGINSCREEN = "/loginscreen";
  static const String SIGNUPSCREEN = "/signupscreen";
  static const String FORGETSCREEN = "/forgetscreen";
  static const String CREATEPOST = "/createpost";
  static const String EDITEPOST = "/edittepost";
  static const String COMMENTPAGE = "/commentpage";

  static List<GetPage> routes = [
    GetPage(
        name: MAINSCREEN,
        page: () => MainScreen(),
        transitionDuration: Duration(milliseconds: 100),
        transition: Transition.cupertino),
    GetPage(
        name: HOMESCREEN,
        page: () => HomeScreen(),
        transitionDuration: Duration(milliseconds: 100),
        transition: Transition.cupertino),
    GetPage(
        name: LOGINSCREEN,
        page: () => LoginScreen(),
        transitionDuration: Duration(milliseconds: 100),
        transition: Transition.cupertino),
    GetPage(
        name: SIGNUPSCREEN,
        page: () => SignupScreen(),
        transitionDuration: Duration(milliseconds: 100),
        transition: Transition.cupertino),
    GetPage(
        name: FORGETSCREEN,
        page: () => ForgetScreen(),
        transitionDuration: Duration(milliseconds: 100),
        transition: Transition.cupertino),
    GetPage(
        name: CREATEPOST,
        page: () => CreatePost(),
        transitionDuration: Duration(milliseconds: 100),
        transition: Transition.cupertino),
    GetPage(
        name: EDITEPOST,
        page: () => EditPost(),
        transitionDuration: Duration(milliseconds: 100),
        transition: Transition.cupertino),
    GetPage(
        name: COMMENTPAGE,
        page: () => CommentPage(),
        transitionDuration: Duration(milliseconds: 100),
        transition: Transition.cupertino),

  ];
}
