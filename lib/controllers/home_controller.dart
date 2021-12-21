import 'package:get/get.dart';
import 'dart:convert';
import 'package:idea_portal/constants/consts.dart';
import 'package:idea_portal/controllers/login_controller.dart';
import 'package:idea_portal/models/Idea.dart';
import 'package:idea_portal/services/base_client.dart';

class HomeController extends GetxController {
  var ideaList = <Idea>[].obs,
      userIdeaList = <Idea>[].obs,
      userLikes = {}.obs,
      isLoading = true.obs,
      currentPage = 0.obs;

  changeCurrentPage(var index) {
    currentPage.value = index;
  }

  fetchData() async {
    await fetchUserLikes();
    await fetchIdeas();
    await fetchUserIdeas();
  }

  fetchIdeas() async {
    try {
      var response = await BaseClient.get(Consts.IdeaPortalURL, 'getAllIdeas');
      ideaList.value = Idea.ObjectFromJson(response);
      print(ideaList.value);
    } catch (ex) {
      print('Unable to get ideas : $ex');
    }
    isLoading(false);
  }

  fetchUserIdeas() async {
    if (Get.find<LoginController>().isLogin.value) {
      try {
        var response = await BaseClient.get(Consts.IdeaPortalURL,
            'getUserIdeas/' + Get.find<LoginController>().phoneNumber.value);
        userIdeaList.value = Idea.ObjectFromJson(response);
        print(userIdeaList.value);
      } catch (ex) {
        print('Unable to get user ideas : $ex');
      }
    }
  }

  fetchUserLikes() async {
    if (Get.find<LoginController>().isLogin.value) {
      try {
        var response = await BaseClient.get(Consts.IdeaPortalURL,
            'getUserLikes/' + Get.find<LoginController>().phoneNumber.value);
        List<dynamic> likes = json.decode(response);
        likes.forEach((x) => userLikes[x] = true);
        print(response);
      } catch (ex) {
        print('Unable to get user likes : $ex');
      }
    }
  }

  deleteUserIdea(String id) async {
    try {
      var phoneNo = Get.find<LoginController>().phoneNumber.value;
      var response = await BaseClient.delete(
          Consts.IdeaPortalURL, 'deleteUserIdea/' + phoneNo + '/' + id, null);
      // check for success response and remove from list
      userIdeaList.removeWhere((element) => element.Id == id);
      print(response);
    } catch (ex) {
      print('Unable to deleteUserLike : $ex');
    }
  }
}
