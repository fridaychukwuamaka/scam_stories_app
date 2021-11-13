import 'package:get/get.dart';
import 'package:scam_stories_app/middlewares/auth_guard.dart';
import 'package:scam_stories_app/view/screens/auth/login_screen.dart';
import 'package:scam_stories_app/view/screens/auth/signup_screen.dart';
import 'package:scam_stories_app/view/screens/home_screen.dart';
import 'package:scam_stories_app/view/screens/profile_screen.dart';
import 'package:scam_stories_app/view/screens/settings_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  // static const initial =  Routes.login;

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfileScreen(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: Routes.signup,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: Routes.settingsScreen,
      page: () => SettingsScreen(),
    ),
    /* GetPage(
      name: Routes.newsScreen,
      page: () => const  NewsScreen(),
    ), */
  ];
}
