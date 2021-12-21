import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_portal/constants/colors.dart';
import 'package:idea_portal/controllers/home_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:idea_portal/ui/widgets/pages_widgets/idea_tile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: RefreshIndicator(
      child: Container(
          color: ColorConstants.kPrimaryDarkColor,
          child: Obx(() {
            if (Get.find<HomeController>().isLoading.value) {
              Get.find<HomeController>().fetchData();
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return StaggeredGridView.countBuilder(
                  crossAxisCount: 1,
                  itemCount: Get.find<HomeController>().ideaList.length,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  itemBuilder: (context, index) {
                    return IdeaTile(
                        Get.find<HomeController>().ideaList[index], false);
                  },
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1));
            }
          })),
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1), () {
          Get.find<HomeController>().fetchData();
        });
      },
      backgroundColor: ColorConstants.kPrimaryColor,
    )));
  }
}
