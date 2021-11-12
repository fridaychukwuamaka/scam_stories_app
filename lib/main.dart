import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import 'constants/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

// TODO: ADD FLAG ABUSE REPORT
// TODO: SHIMMER
// TODO: LOGIN/SIGNUP VALIDATION
// TODO: ONCLICK TAG
// TODO: ADD SEARCH FEATURE
final box = GetStorage();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Scam App',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      initialRoute: box.hasData('auth-token') ? Routes.home : Routes.login,
      getPages: AppPages.routes,
    );
  }
}
