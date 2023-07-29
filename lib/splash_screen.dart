import 'package:flutter/material.dart';
import 'package:interview_rajkot/resources/colors.dart';
import 'package:interview_rajkot/screens/navigatio_screen.dart';
import 'package:interview_rajkot/screens/recipe_list.dart';
import 'package:interview_rajkot/screens/login.dart';
import 'package:interview_rajkot/widget/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName').toString();
    String password = prefs.getString('password').toString();

    if (userName != "null" && password != "null") {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const NavigationScreen()), (Route<dynamic> route) => false);
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
      });
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColor.blue,
        child: const Center(child: CommonText.semiBold("Loading...", color: AppColor.white, size: 24)),
      ),
    );
  }
}
