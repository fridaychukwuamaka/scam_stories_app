import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/controller/auth_controller.dart';
import 'package:scam_stories_app/view/screens/auth/signup_screen.dart';
import 'package:scam_stories_app/view/widgets/app_button.dart';
import 'package:scam_stories_app/view/widgets/app_input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final authCont = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                AppInput(
                  label: 'Email',
                  controller: authCont.email,
                  onchanged: (val) {},
                ),
                SizedBox(
                  height: 40.5,
                ),
                AppInput(
                  label: 'Password',
                  controller: authCont.password,
                  onchanged: (val) {},
                  obscure: true,
                ),
                SizedBox(
                  height: 100,
                ),
                AppButton(
                  onPressed: authCont.login,
                  title: 'Login',
                ),
                SizedBox(
                  height: 42,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => SignUpScreen());
                    },
                    child: Text(
                      'Dont have an accont?',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
