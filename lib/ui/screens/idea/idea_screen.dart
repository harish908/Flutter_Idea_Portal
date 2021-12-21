import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_portal/constants/colors.dart';
import 'package:idea_portal/constants/consts.dart';
import 'package:idea_portal/controllers/home_controller.dart';
import 'package:idea_portal/controllers/idea_controller.dart';
import 'package:idea_portal/controllers/login_controller.dart';
import 'package:idea_portal/models/Idea.dart';
import 'package:idea_portal/ui/widgets/pages_widgets/idea_tile.dart';
import 'package:idea_portal/ui/widgets/pages_widgets/login_button.dart';

class IdeaScreen extends StatelessWidget {
  final _homeController = Get.find<HomeController>();
  final _ideaController = Get.find<IdeaController>();
  TextEditingController textEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: ColorConstants.kPrimaryLightColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close,
                      color: ColorConstants.kSecondaryDarkColor),
                  iconSize: 35,
                ),
              ),
              Obx(() {
                Idea idea = Idea();
                String? type = Get.parameters['Type'],
                    ideaId = Get.parameters['IdeaId'];

                switch (type) {
                  case "HOME":
                    idea = _homeController.ideaList
                        .firstWhere((element) => element.Id == ideaId);
                    break;
                  case "USER":
                    idea = _homeController.userIdeaList
                        .firstWhere((element) => element.Id == ideaId);
                }

                return Container(
                  child: Column(
                    children: [
                      IdeaTile(idea, true),
                      SizedBox(
                        height: 10,
                      ),
                      textField(MediaQuery.of(context).size.width),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(double width) {
    return Container(
      width: width - 20,
      height: 60,
      decoration: BoxDecoration(
        color: ColorConstants.kPrimaryColor,
      ),
      child: TextFormField(
        controller: textEditController,
        style: TextStyle(fontSize: 17, color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Comment",
          hintStyle: TextStyle(fontSize: 17, color: Colors.white),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          suffixIcon: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                "Post",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.kSecondaryDarkColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
