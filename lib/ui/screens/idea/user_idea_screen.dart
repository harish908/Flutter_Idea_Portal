import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:idea_portal/constants/colors.dart';
import 'package:idea_portal/controllers/home_controller.dart';
import 'package:idea_portal/controllers/login_controller.dart';
import 'package:idea_portal/ui/widgets/pages_widgets/idea_tile.dart';
import 'package:idea_portal/ui/widgets/pages_widgets/login_button.dart';
import 'package:idea_portal/ui/widgets/pages_widgets/user_idea_tile.dart';

class UserIdeaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (Get.find<LoginController>().isLogin.value) {
          return SafeArea(
            child: Container(
              color: ColorConstants.kPrimaryDarkColor,
              child: StaggeredGridView.countBuilder(
                  crossAxisCount: 1,
                  itemCount: Get.find<HomeController>().userIdeaList.length,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  itemBuilder: (context, index) {
                    return UserIdeaTile(
                        Get.find<HomeController>().userIdeaList[index], false);
                  },
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1)),
            ),
          );
        } else {
          return LoginButton.loginButton();
        }
      }),
    );
  }
}
