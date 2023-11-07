// ignore_for_file: depend_on_referenced_packages, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alston/utils/appcolors.dart';
import 'package:alston/widgets/customelevatedbutton.dart';
import 'package:alston/widgets/customtextformfield.dart';
import 'package:alston/view/confirmbusscreen.dart';

import '../utils/theme_controller.dart';

class SignInScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _password = TextEditingController();

  SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the ThemeController
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      // Colors are chosen based on the theme status
      Color backgroundColor = themeController.isDarkMode.value
          ? AppColors.backgroundColorDarker
          : AppColors.backgroundColor;
      Color primaryColor = themeController.isDarkMode.value
          ? AppColors.primaryColor
          : AppColors.primaryColorDark;
      Color textColor = themeController.isDarkMode.value
          ? AppColors.textColor
          : AppColors.textColorDarker;

      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      double verticalPadding = screenHeight * 0.02;
      double headingFontSize = screenWidth * 0.1;
      double subheadingFontSize = screenWidth * 0.05;

      return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          height: screenHeight,
          width: screenWidth,
          color: backgroundColor,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.14),
                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.acme(
                        fontSize: headingFontSize, color: textColor),
                  ),
                  SizedBox(height: screenHeight * 0.12),
                  Text(
                    'Please Sign In to start your shift',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.acme(
                      color: primaryColor,
                      fontSize: subheadingFontSize,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  SizedBox(height: verticalPadding),
                  CustomTextFormField(
                    labelText: "Enter User-Id",
                    controller: _userId,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "User-Id cannot be empty";
                      }
                      return null;
                    }, obscureText: false,
                  ),
                  SizedBox(height: verticalPadding),
                  CustomTextFormField(
                    labelText: "Enter Password",
                    controller: _password,
                    obscureText: true, // Hide password input
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  CustomElevatedButton(
                    buttonText: 'Sign In',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Get.offAll(const ConfirmBusScreen());
                      }
                    },
                   
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
