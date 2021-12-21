import 'dart:convert';

import 'package:get/get.dart';
import 'package:idea_portal/constants/consts.dart';
import 'package:idea_portal/controllers/login_controller.dart';
import 'package:idea_portal/models/comment.dart';
import 'package:idea_portal/models/idea.dart';
import 'package:idea_portal/models/update_user_like.dart';
import 'package:idea_portal/services/base_client.dart';

class IdeaController extends GetxController {
  var commentList = Comment(Id: "", comments: []).obs;

  addUserLike(String id) async {
    try {
      var request = UpdateUserLike(
          PhoneNo: Get.find<LoginController>().phoneNumber.value, IdeaId: id);
      var response =
          await BaseClient.post(Consts.IdeaPortalURL, 'addUserLike', request);
      print(response);
    } catch (ex) {
      print('Unable to addUserLike : $ex');
    }
  }

  deleteUserLike(String id) async {
    try {
      var request = UpdateUserLike(
          PhoneNo: Get.find<LoginController>().phoneNumber.value, IdeaId: id);
      var response = await BaseClient.delete(
          Consts.IdeaPortalURL, 'deleteUserLike', request);
      print(response);
    } catch (ex) {
      print('Unable to deleteUserLike : $ex');
    }
  }

  getIdeaComment(String id) async {
    try {
      var response =
          await BaseClient.get(Consts.IdeaPortalURL, 'getComment/' + id);
      Map<String, dynamic> respMap = jsonDecode(response);
      commentList.value = Comment.fromJson(respMap);
      print(response);
    } catch (ex) {
      print('Unable to getIdeaComment : $ex');
    }
  }

  addIdeaComment(String id, String comment, String name) async {
    try {
      var request = Comments(Message: comment, Name: name);
      var response = await BaseClient.post(
          Consts.IdeaPortalURL, 'updateComment/' + id, request);
      print(response);
    } catch (ex) {
      print('Unable to addIdeaComment : $ex');
    }
  }
}
