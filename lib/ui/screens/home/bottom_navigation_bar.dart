import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_portal/constants/colors.dart';
import 'package:idea_portal/constants/consts.dart';
import 'package:idea_portal/controllers/home_controller.dart';
import 'package:idea_portal/ui/screens/home/home_screen.dart';
import 'package:idea_portal/ui/screens/idea/user_idea_screen.dart';
import 'package:idea_portal/ui/widgets/pages_widgets/custom_app_bar.dart';

class BottomNavigationPage extends StatelessWidget {
  final screens = [HomePage(), UserIdeaPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(),
      body: Obx(() {
        return IndexedStack(
          index: Get.find<HomeController>().currentPage.value,
          children: screens,
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: Get.find<HomeController>().currentPage.value,
          onTap: (index) => Get.find<HomeController>().changeCurrentPage(index),
          backgroundColor: ColorConstants.kPrimaryDarkColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          elevation: Consts.widgetsElevation,
          items: [CustomNavBarItem("Home"), CustomNavBarItem("Idea")],
        );
      }),
    );
  }

  BottomNavigationBarItem CustomNavBarItem(String iconValue) {
    IconData? icon;
    switch (iconValue) {
      case "Home":
        icon = Icons.home;
        break;
      case "Idea":
        icon = Icons.lightbulb_outline_sharp;
    }

    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      label: iconValue,
    );
  }
}
