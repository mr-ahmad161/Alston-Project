// ignore_for_file: depend_on_referenced_packages
import 'package:alston/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/theme_controller.dart';
import '../widgets/navigationdrawer.dart';

class ShiftScreen extends StatelessWidget {
  const ShiftScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the instance of ThemeController
    final ThemeController themeController = Get.find<ThemeController>();

    // Using Obx to listen to changes in the theme
    return Obx(() {
      // Access the theme values based on isDarkMode
      final isDarkMode = themeController.isDarkMode.value;
      final Color primaryColor =
          isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColor;
      final Color backgroundColor = isDarkMode
          ? AppColors.backgroundColorDarker
          : AppColors.backgroundColor;
      final Color textColor =
          isDarkMode ? AppColors.textColorDarker : AppColors.textColor;

      return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const MyDrawerHeader(), // Define this header or remove if not needed
                  myDrawerList(), // Define this method or remove if not needed
                ],
              ),
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'SHIFT REPORT',
              style: GoogleFonts.acme(),
            ),
            bottom: TabBar(
              unselectedLabelColor: textColor,
              indicatorColor: primaryColor,
              tabs: const <Widget>[
                Tab(
                  icon: Icon(Icons.today),
                  text: 'Today',
                ),
                Tab(
                  icon: Icon(Icons.calendar_view_week),
                  text: 'This Week',
                ),
                Tab(
                  icon: Icon(Icons.calendar_month),
                  text: 'This Month',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              buildTabContext('Today You don\'t have any\nreport',
                  backgroundColor, textColor),
              buildTabContext('This Week You don\'t have\nany report',
                  backgroundColor, textColor),
              buildTabContext('This Month You don\'t have\nany report',
                  backgroundColor, textColor),
            ],
          ),
        ),
      );
    });
  }

  Widget buildTabContext(String text, Color backgroundColor, Color textColor) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        color: backgroundColor,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 18, // Adjust the font size as needed
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
