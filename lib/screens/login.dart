import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_rajkot/resources/colors.dart';
import 'package:interview_rajkot/screens/recipe_list.dart';
import 'package:interview_rajkot/screens/navigatio_screen.dart';
import 'package:interview_rajkot/widget/text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 150),
                const CommonText.semiBold(
                  "Welcome",
                  size: 50,
                  color: AppColor.black,
                ),
                const SizedBox(height: 50),
                TextFormField(
                    keyboardType: TextInputType.name,
                    controller: emailController,
                    validator: (value) {
                      final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                      if (value.isEmpty) {
                        return 'Please enter Email';
                      } else if (!emailValid) {
                        return 'Please enter valid Email';
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      fillColor: AppColor.white,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColor.black30)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColor.black30)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColor.black30)),
                      labelText: 'Email',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: AppColor.black,
                      ),
                    )),
                const SizedBox(height: 20),
                TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length < 8) {
                        return 'Password length should be more then 8 characters';
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      fillColor: AppColor.white,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColor.black30)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColor.black30)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColor.black30)),
                      labelText: 'Password',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: AppColor.black,
                      ),
                    )),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if(emailController.text.trim()=="admin@gmail.com"&&passwordController.text.trim()=="12345678")
                      {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('userName', emailController.text.toString());
                        await prefs.setString('password', passwordController.text.toString());
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const NavigationScreen()), (Route<dynamic> route) => false);
                      }
                      else{
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            const SnackBar(backgroundColor: AppColor.red,
                                content: CommonText.semiBold("Please check username and password and try again",color: AppColor.white,)
                            ),
                          );
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: AppColor.greyLight, borderRadius: BorderRadius.circular(20)),
                    child: const CommonText.extraBold("Log in", size: 24, color: AppColor.blue),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
