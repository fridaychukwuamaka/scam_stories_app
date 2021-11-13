import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/controller/auth_controller.dart';
import 'package:scam_stories_app/view/screens/auth/signup_screen.dart';
import 'package:scam_stories_app/view/widgets/app_button.dart';
import 'package:scam_stories_app/view/widgets/app_input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final authCont = Get.put(AuthController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    authCont.clearError;
    return SafeArea(
      child: Scaffold(
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
                    validator: authCont.emailValidation,
                  ),
                  SizedBox(
                    height: 40.5,
                  ),
                  AppInput(
                    label: 'Password',
                    controller: authCont.password,
                    onchanged: (val) {},
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
                    onPressed: () => authCont.login(_formKey),
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
      ),
    );
  }
}
