import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/constants/constants.dart';

class AuthGuard extends GetMiddleware {
//   The default is 0 but you can update it to any number. Please ensure you match the priority based
//   on the number of guards you have.
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    print(box.hasData('userId'));
    if (box.hasData('userId')) return null;
    return RouteSettings(name: Routes.login);
  }
}
