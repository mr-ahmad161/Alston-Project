import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/appcolors.dart';
import '../utils/theme_controller.dart'; // Adjust this import based on your project structure
import '../view/homepage.dart';
import '../view/notconfirmbusscreen.dart';
import '../widgets/customelevatedbutton.dart';
import '../widgets/navigationdrawer.dart';

class ConfirmBusScreen extends StatelessWidget {
  final List<String> busNumbers;
  String? selectedBusNumber;

  ConfirmBusScreen({Key? key, required this.busNumbers}) : super(key: key);

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
    final textSizeLarge = screenWidth * 0.04;
    final blockSpacing = screenHeight * 0.02;
    final buttonSpacing = screenHeight * 0.01;

    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyDrawerHeader(), // Ensure you have this widget defined
              myDrawerList(), // Ensure you have this function or widget defined
            ],
          ),
        ),
      ),
      body: Obx(() => Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            color: themeController.isDarkMode.value
                ? AppColors.backgroundColorDarker
                : AppColors.backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Are you Sure Operating The Bus With Number',
                  style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.backgroundColor
                        : AppColors.textColor,
                    fontSize: textSizeMedium,
                    fontWeight: FontWeight.w200,
                  ).merge(GoogleFonts.josefinSans()),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.1),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Row(
                    children: [
                      Text(
                        'BUS ',
                        style: TextStyle(
                          color: themeController.isDarkMode.value
                              ? AppColors.backgroundColor
                              : AppColors.primaryColor,
                          fontSize: textSizeLarge,
                          fontWeight: FontWeight.bold,
                        ).merge(GoogleFonts.josefinSans()),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: screenWidth * 0.1),
                      DropdownButton<String>(
                        value: selectedBusNumber,
                        hint: const Text('Select Bus Number'),
                        items: busNumbers.map((String number) {
                          return DropdownMenuItem<String>(
                            value: number,
                            child: Text(number),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          selectedBusNumber = newValue;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                CustomElevatedButton(
                  buttonText: 'Yes',
                  buttonColor: themeController.isDarkMode.value
                      ? AppColors.primaryColorDarker
                      : AppColors.primaryColor,
                  textColor: AppColors.whiteColor,
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
                  textColor: AppColors.whiteColor,
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
