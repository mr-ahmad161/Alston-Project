// ignore_for_file: depend_on_referenced_packages

import 'package:alston/utils/appcolors.dart';
import 'package:alston/view/homepage.dart';
import 'package:alston/view/notconfirmbusscreen.dart';
import 'package:alston/widgets/customelevatedbutton.dart';
import 'package:alston/widgets/navigationdrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme_controller.dart'; // Make sure to import your ThemeController

class ConfirmBusScreen extends StatelessWidget {
  const ConfirmBusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ThemeController to manage theme data
    final ThemeController themeController = Get.find<ThemeController>();

    // Obtain the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define responsive sizes based on screen dimensions
    final horizontalPadding = screenWidth * 0.1;
    final textSizeMedium = screenWidth * 0.05;
    final textSizeLarge = screenWidth * 0.06;
    final blockSpacing = screenHeight * 0.02;
    final buttonSpacing = screenHeight * 0.01;

    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyDrawerHeader(),
              myDrawerList(),
            ],
          ),
        ),
      ),
      body: Obx(() => Container(
            // Listen to changes in theme
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            color: themeController.isDarkMode.value
                ? AppColors
                    .backgroundColorDarker // Use a darker color for dark mode
                : AppColors
                    .backgroundColor, // Use a lighter color for light mode
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Are you Sure Operating The Bus With Number',
                  style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.backgroundColor // Dark mode text color
                        : AppColors.textColor, // Light mode text color
                    fontSize: textSizeMedium,
                    fontWeight: FontWeight.w200,
                  ).merge(GoogleFonts.josefinSans()),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: blockSpacing),
                Text(
                  'BUS : BS04HW',
                  style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors
                            .backgroundColor // Dark mode primary color
                        : AppColors.primaryColor, // Light mode primary color
                    fontSize: textSizeLarge,
                    fontWeight: FontWeight.bold,
                  ).merge(GoogleFonts.josefinSans()),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.1),
                CustomElevatedButton(
                  buttonText: 'Yes',
                  buttonColor: themeController.isDarkMode.value
                      ? AppColors.primaryColorDarker
                      : AppColors.primaryColor,
                  textColor: themeController.isDarkMode.value
                      ? AppColors.whiteColor
                      : AppColors.whiteColor,
                  onPressed: () {
                    Get.offAll(const HomePage());
                  },
                ),
                SizedBox(height: buttonSpacing),
                CustomElevatedButton(
                  buttonText: 'No',
                  buttonColor: themeController.isDarkMode.value
                      ? AppColors.backgroundColorsDarker
                      : Colors.grey,
                  textColor: themeController.isDarkMode.value
                      ? AppColors.whiteColor
                      : AppColors.whiteColor,
                  onPressed: () {
                    Get.to(const NotConfirmBusScreen());
                  },
                ),
              ],
            ),
          )),
    );
  }
}
