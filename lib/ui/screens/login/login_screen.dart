import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_portal/constants/colors.dart';
import 'package:idea_portal/controllers/login_controller.dart';
import 'package:idea_portal/ui/widgets/dialogs/message_dialog.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: ColorConstants.kPrimaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Text(
                'LOGIN',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.kSecondaryColor,
                    fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              textField(MediaQuery.of(context).size.width),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    Text(
                      "Enter 6 digit OTP",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  onChanged: (value) {},
                  onCompleted: (value) {
                    Get.find<LoginController>().smsCode.value = value;
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Get.find<LoginController>().phoneLogin();
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                      color: ColorConstants.kSecondaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Lets Go",
                      style: TextStyle(
                          fontSize: 17,
                          color: ColorConstants.kPrimaryTextColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(double width) {
    return Container(
      width: width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: phoneController,
        style: TextStyle(fontSize: 17),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Phone Number",
          hintStyle: TextStyle(fontSize: 17),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              " (+91) ",
              style: TextStyle(fontSize: 17),
            ),
          ),
          suffixIcon: InkWell(
            onTap: () {
              if (phoneController.text.length == 10) {
                Get.find<LoginController>().phoneVerify(phoneController.text);
              } else {
                MessageDialog.showDialog('Please enter valid number');
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                "Send",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
