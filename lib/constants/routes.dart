import 'package:get/get.dart';
import 'package:idea_portal/controllers/bindings/main_bindings.dart';
import 'package:idea_portal/ui/screens/idea/add_idea_screen.dart';
import 'package:idea_portal/ui/screens/idea/idea_screen.dart';
import 'package:idea_portal/ui/screens/login/login_screen.dart';
import 'package:idea_portal/ui/screens/profile/profile_screen.dart';

class Routes {
  static const homeRoute = "/home";
  static const ideaRoute = "/idea";
  static const addIdeaRoute = "/addIdea";
  static const profileRoute = "/profile";
  static const loginRoute = "/login";
}

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.loginRoute,
        page: () => LoginScreen(),
        binding: MainBindings()),
    GetPage(
        name: Routes.profileRoute,
        page: () => ProfileScreen(),
        binding: MainBindings()),
    GetPage(
        name: Routes.ideaRoute,
        page: () => IdeaScreen(),
        binding: MainBindings()),
    GetPage(
        name: Routes.addIdeaRoute,
        page: () => AddIdeaScreen(),
        binding: MainBindings())
  ];
}
