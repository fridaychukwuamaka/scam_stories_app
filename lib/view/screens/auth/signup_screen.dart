import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/controller/auth_controller.dart';
import 'package:scam_stories_app/view/widgets/app_button.dart';
import 'package:scam_stories_app/view/widgets/app_input.dart';

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final authCont = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
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
                    validator: authCont.fullnameValidation,
                    label: 'Fullname',
                  ),
                  SizedBox(
                    height: 40.5,
                  ),
                  AppInput(
                    onchanged: (val) {},
                    controller: authCont.email,
                    label: 'Email',
                    validator: authCont.emailValidation,
                  ),
                  SizedBox(
                    height: 40.5,
                  ),
                  AppInput(
                    onchanged: (val) {},
                    controller: authCont.password,
                    label: 'Password',
                    validator: authCont.passwordValidation,
                    obscure: true,
                  ),
                  Obx(
                    () => authCont.error.value.isNotEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: 40.5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FeatherIcons.info,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      authCont.error.value,
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  AppButton(
                    onPressed: () => authCont.signup(_formKey),
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
      ),
    );
  }
}
