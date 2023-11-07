// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alston/widgets/customelevatedbutton.dart';
import 'package:alston/widgets/navigationdrawer.dart';
import 'package:alston/utils/appcolors.dart';
import 'package:alston/view/prestartchecklist.dart';
import 'package:alston/view/mybooking.dart';
import '../utils/theme_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final double sidePadding = screenWidth * 0.05;
    final double verticalSpacing = screenHeight * 0.02;
    final double fontSize = screenHeight * 0.025;

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ALSTON Link',
          style: GoogleFonts.acme(),
        ),
        actions: [
          IconButton(
            icon: Icon(themeController.isDarkMode.value
                ? Icons.light_mode // Icon for light mode
                : Icons.dark_mode), // Icon for dark mode
            onPressed: () {
              // Toggle the theme
              themeController.toggleTheme(!themeController.isDarkMode.value);
            },
          ),
        ],
      ),
      body: Obx(() => Container(
            padding: EdgeInsets.symmetric(horizontal: sidePadding),
            color: themeController.isDarkMode.value
                ? AppColors.backgroundColorDarker
                : AppColors.backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Have you Done The Pre-Start Today?',
                  style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.textColorDarker
                        : AppColors.textColor,
                    fontSize: fontSize,
                  ),
                ),
                SizedBox(height: screenHeight * 0.075),
                CustomElevatedButton(
                  buttonText: 'Pre-Start',
                  buttonColor: themeController.isDarkMode.value
                      ? AppColors.primaryColorDarker
                      : AppColors.primaryColor,
                  textColor: themeController.isDarkMode.value
                      ? AppColors.whiteColor
                      : AppColors.textColor,
                  onPressed: () {
                    Get.to(() => PreStartCheckList());
                  },
                ),
                SizedBox(height: verticalSpacing),
                CustomElevatedButton(
                  buttonText: 'SKIP',
                  buttonColor: themeController.isDarkMode.value
                      ? AppColors.backgroundColorsDarker
                      : Colors.grey,
                  textColor: themeController.isDarkMode.value
                      ? AppColors.textColor
                      : AppColors.textColorDarker,
                  onPressed: () {
                    Get.to(() => const MyBooking());
                  },
                ),
              ],
            ),
          )),
    );
  }
}
