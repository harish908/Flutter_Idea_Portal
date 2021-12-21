import 'package:get/get.dart';
import 'package:idea_portal/controllers/home_controller.dart';
import 'package:idea_portal/controllers/idea_controller.dart';
import 'package:idea_portal/controllers/login_controller.dart';

class MainBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<IdeaController>(() => IdeaController());
  }
}
