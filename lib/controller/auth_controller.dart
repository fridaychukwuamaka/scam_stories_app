import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:scam_stories_app/constants/routes/app_pages.dart';
import 'package:scam_stories_app/repository/api_status.dart';
import 'package:scam_stories_app/repository/user_service.dart';

UserService _userService = UserService();
CollectionReference _users = FirebaseFirestore.instance.collection('users');

class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullname = TextEditingController();

  login() async {
    var result = await _userService.login(email.text, password.text);

    if (result.runtimeType == Success) {
      User user = result.response;
      await box.write('userId', user.uid);
      await box.write('auth-token', await user.getIdToken());
      await Get.toNamed(Routes.home);
      clearTextContoller();
    } else {
      Get.snackbar(
        'Message',
        result.msg,
        backgroundColor: Colors.white,
        margin: EdgeInsets.zero,
        borderRadius: 0,
      );
    }
  }

  signup() async {
    var result =
        await _userService.signUp(fullname.text, email.text, password.text);

    if (result.runtimeType == Success) {
      User user = result.response;

      print(user.uid);
      await addUser(user);
      await box.write('userId', user.uid);
      await box.write('auth-token', await user.getIdToken());
      await Get.toNamed(Routes.home);
      clearTextContoller();
    } else {
      Get.snackbar(
        'Message',
        result.msg,
        backgroundColor: Colors.white,
        margin: EdgeInsets.zero,
        borderRadius: 0,
      );
    }
  }

  Future<void> logout() async {
    await box.remove('auth-token');
    await Get.toNamed(Routes.login);
  }

  Future<void> addUser(User user) async {
    await _users.doc(user.uid).set({
      'email': user.email,
      'userId': user.uid,
      'name': fullname.text,
      'img': '',
    });
  }

  clearTextContoller() {
    email.clear();
    password.clear();
    fullname.clear();
  }
}
