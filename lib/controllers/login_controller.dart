import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:idea_portal/ui/widgets/dialogs/message_dialog.dart';

class LoginController extends GetxController {
  var isLogin = true.obs,
      verificationCode = "".obs,
      smsCode = "".obs,
      userName = "".obs,
      phoneNumber = "9999999999".obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');

  phoneVerify(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" + number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              checkUserDetails();
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            MessageDialog.showDialog('The provided phone number is not valid');
          }
        },
        codeSent: (String code, int? resendToken) {
          verificationCode.value = code;
        },
        codeAutoRetrievalTimeout: (String code) {
          verificationCode.value = code;
        });
  }

  phoneLogin() async {
    try {
      if (smsCode.value.length == 6) {
        await FirebaseAuth.instance
            .signInWithCredential(PhoneAuthProvider.credential(
                verificationId: verificationCode.value, smsCode: smsCode.value))
            .then((value) async {
          if (value.user != null) {
            checkUserDetails();
          }
        });
      } else {
        MessageDialog.showDialog('Please enter valid OTP');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        MessageDialog.showDialog('Invalid OTP');
        return;
      }
      MessageDialog.showDialog('Server issue, please try later');
    }
  }

  checkUserDetails() async {
    var number = _auth.currentUser?.phoneNumber?.substring(3);
    phoneNumber.value = number ?? "";
    await _firestore
        .where('phoneNumber', isEqualTo: phoneNumber.value)
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        userName.value = value.docs[0]['name'];
        isLogin.value = true;
        Get.back();
      } else {
        postUserDetails();
      }
    }).catchError((error) {
      print('Failed to get user details: $error');
    });
  }

  postUserDetails() async {
    await _firestore
        .doc(_auth.currentUser?.uid)
        .set({'name': '', 'phoneNumber': phoneNumber.value}).then((value) {
      isLogin.value = true;
      Get.back();
    }).catchError((error) {
      print('Failed to add user details: $error');
    });
  }

  updateUserDetails(String name) async {
    await _firestore
        .doc(_auth.currentUser?.uid)
        .update({'name': name})
        .then((value) {})
        .catchError((error) {
          print('Failed to update user: $error');
        });
  }

  signOut() {
    _auth.signOut();
    isLogin.value = false;
    userName.value = "";
  }
}
