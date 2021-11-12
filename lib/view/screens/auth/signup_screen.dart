import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/controller/auth_controller.dart';
import 'package:scam_stories_app/view/widgets/app_button.dart';
import 'package:scam_stories_app/view/widgets/app_input.dart';

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final authCont = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SIGN UP',
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
                  onchanged: (val) {},
                  controller: authCont.fullname,
                  label: 'Fullname',
                ),
                SizedBox(
                  height: 40.5,
                ),
                AppInput(
                  onchanged: (val) {},
                  controller: authCont.email,
                  label: 'Email',
                ),
                SizedBox(
                  height: 40.5,
                ),
                AppInput(
                  onchanged: (val) {},
                  controller: authCont.password,
                  label: 'Password',
                  obscure: true,
                ),
                SizedBox(
                  height: 100,
                ),
                AppButton(
                  onPressed: authCont.signup,
                  title: 'Sign up',
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
