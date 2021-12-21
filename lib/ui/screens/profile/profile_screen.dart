import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_portal/constants/colors.dart';
import 'package:idea_portal/controllers/login_controller.dart';
import 'package:idea_portal/ui/widgets/pages_widgets/login_button.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (Get.find<LoginController>().isLogin.value) {
          return Container(
            child: Column(
              children: [
                Center(
                  child: Text(
                    Get.find<LoginController>().userName.value,
                    style: TextStyle(
                        color: ColorConstants.kPrimaryColor, fontSize: 20),
                  ),
                ),
                Container(
                  child: InkWell(
                    onTap: () {
                      Get.find<LoginController>().signOut();
                    },
                    child: Container(
                      height: 60,
                      width: 160,
                      decoration: BoxDecoration(
                          color: ColorConstants.kPrimaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "SignOut",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return LoginButton.loginButton();
        }
      }),
    );
  }
}
