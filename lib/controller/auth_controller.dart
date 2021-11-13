import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:scam_stories_app/constants/routes/app_pages.dart';
import 'package:scam_stories_app/services/api_status.dart';
import 'package:scam_stories_app/services/my_pref.dart';
import 'package:scam_stories_app/services/user_service.dart';

UserService _userService = UserService();
FirebaseFirestore userInstance = FirebaseFirestore.instance;
CollectionReference _users = userInstance.collection('users');

class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullname = TextEditingController();

  var error = ''.obs;

  login(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      var result = await _userService.login(email.text, password.text);

      if (result.runtimeType == Success) {
        User user = result.response;
        MyPref.userId.val = user.uid;
        MyPref.authToken.val = await user.getIdToken();

        clearTextContoller();
        await Get.offAllNamed(Routes.home);
        AppThemes.snackBar(result.msg, inverted: true);
      } else {
        print(result.msg);
        error.value = result.msg;
      }
    }
  }

  signup(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      var result =
          await _userService.signUp(fullname.text, email.text, password.text);

      if (result.runtimeType == Success) {
        User user = result.response;

        print(user.uid);
        await addUser(user);
        MyPref.userId.val = user.uid;
        MyPref.authToken.val = await user.getIdToken();
        await Get.toNamed(Routes.home);
        clearTextContoller();
        AppThemes.snackBar(result.msg);
      } else {
        error.value = result.msg;
      }
    }
  }

  Future<void> logout() async {
    MyPref.clearBoxes();
    _userService.logout();
    userInstance.clearPersistence();
    await Get.offAllNamed(Routes.home);
  }

  Future<void> addUser(User user) async {
    await _users.doc(user.uid).set({
      'email': user.email,
      'userId': user.uid,
      'name': fullname.text,
      'img': '',
    });
  }

  get clearError => error.value = '';

  clearTextContoller() {
    email.clear();
    password.clear();
    fullname.clear();
  }

  String? emailValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please your email';
    } else if (!value.isEmail) {
      return 'Please a valid email';
    }
    return null;
  }

  String? fullnameValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please your Fullname';
    }
    return null;
  }

  String? passwordValidation(String? val) {
    /*   String uppercasePattern = '(?=.*[A-Z])';
    String lowercasePattern = '(?=.*[a-z])';
    String digitPattern = '(?=.*?[0-9])';
    String spcPattern = '(?=.*?[!@#\$&*~])';

    if (!(val!.length >= 8)) {
      return 'Must be at least 8 characters in length';
    } else if (!GetUtils.hasMatch(val, uppercasePattern)) {
      return 'should contain at least one upper case';
    } else if (!GetUtils.hasMatch(val, lowercasePattern)) {
      return 'should contain at least one lower case';
    } else if (!GetUtils.hasMatch(val, digitPattern)) {
      return 'should contain at least one number';
    } else if (!GetUtils.hasMatch(val, spcPattern)) {
      return 'should contain at least one special character';
    } else {
      return null;
    }
  } */
    return null;
  }
}
