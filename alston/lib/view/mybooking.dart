// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import '../utils/theme_controller.dart';
import '../utils/appcolors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/navigationdrawer.dart';

class MyBooking extends StatelessWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(() {
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
          title: Text('My Booking', style: GoogleFonts.lato()),
          backgroundColor: themeController.isDarkMode.value
              ? AppColors.primaryColor
              : AppColors.backgroundColors,
          actions: [
            IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.light_mode // Icon for light mode
                    : Icons.dark_mode, // Icon for dark mode
                color: themeController.isDarkMode.value
                    ? AppColors.darkModeIcon
                    : AppColors.primaryColor, // Icon color in light mode
              ),
              onPressed: () {
                // Toggle the theme
                themeController.toggleTheme(!themeController.isDarkMode.value);
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: themeController.isDarkMode.value
              ? AppColors.backgroundColorDarker
              : AppColors.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('There is no booking',
                  style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? AppColors.whiteColor
                          : AppColors.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w100).merge(GoogleFonts.josefinSans())),
            ],
          ),
        ),
      );
    });

  }
}
