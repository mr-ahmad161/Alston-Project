// ignore_for_file: depend_on_referenced_packages

import 'package:alston/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/appcolors.dart';
import '../widgets/navigationdrawer.dart';
import '../utils/theme_controller.dart'; // Import your theme controller

class EndShiftScreen extends StatelessWidget {
  const EndShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

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
        elevation: 0,
        centerTitle: true,
        title: const Text('ALSTON Link'),
      ),
      body: Obx(() => Center(
            // Use Obx to listen for changes
            child: Card(
              color: themeController.isDarkMode.value
                  ? AppColors.backgroundColorDarker // Dark mode color
                  : AppColors.backgroundColor, // Light mode color
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(32),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Check Bus !',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: themeController.isDarkMode.value
                            ? AppColors
                                .primaryColorDarker // Dark mode text color
                            : Colors.blueAccent, // Light mode text color
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Do you want to end your shift on this bus today?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: themeController.isDarkMode.value
                            ? AppColors.textColorDarker // Dark mode text color
                            : AppColors.textColor, // Light mode text color
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        // Yes button action
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: themeController.isDarkMode.value
                            ? AppColors
                                .primaryColorDarker // Dark mode button color
                            : Colors.blueAccent, // Light mode button color
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                      child: const Text('YES'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const HomePage());
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: themeController.isDarkMode.value
                            ? AppColors
                                .primaryColorDarker // Dark mode text color
                            : Colors.blueAccent, // Light mode text color
                        textStyle: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                      ),
                      child: const Text('No!-SKIP'),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
