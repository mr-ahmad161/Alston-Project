// ignore_for_file: depend_on_referenced_packages

import 'package:alston/utils/appcolors.dart';
import 'package:alston/widgets/customelevatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'checklistWidget.dart';
import 'package:alston/utils/theme_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckList extends StatelessWidget {
  const CheckList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final List<String> questionList = [
      "#1 : Drivers temperature is between 36.1 - 37.2 degrees celsius",
      '#2 : Check "Daily Vehicle Cleaning & Disinfectant Schedule" that the bus/coach has been cleaned  and sanitised',
      '#3 : I have no drugs or alcohol present in my blood or breath',
      // '#4 : I am not impaired by drugs or medication',
      // '#5 : Check first Aid kit at this place',
      // '#6 : Check Fire Extinguisture(s) are secure and servicealbe',
      // '#7 : Check Emergency Hammer(s) are in place',
      // '#8 : Check seatbelts are serviceable',
      // '#9 : Check oil and fuel and Adblue and coolant levels',
      // '#10 : Check all type of tread damage and inflation including spares',
      // '#11 : Check wipes,washers,windows,mirrors,and clean & operational',
      // '#12 : Visually Check for fluid leaks of oil and coolant and fuel',
      // '#13 : Check for any damage or defect',
      // '#14 : Check engine belts for cracking and wear and tension',
      // '#15 : Check lights and horn are serviceable',
    ];

    return Obx(() => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pre-Start Checklist', style: GoogleFonts.lato()),
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
      body: ListView.builder(
        itemCount: questionList.length + 1, // Add one for the button at the end
        itemBuilder: (context, index) {
          if (index < questionList.length) {
            // Return a checklist widget for each question item
            return CheckListWidget(
              themeController: themeController, // Pass the themeController
              question: questionList[index],
              onOptionSelected: (bool isCorrect) {
                // Handle the selected option here
              },
              width: 20, // Set the desired width
            );

          } else {
            // Return a button for the last item
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: CustomElevatedButton(
                  buttonText: 'Submit Checklist',
                  buttonColor: themeController.isDarkMode.value
                      ? AppColors.primaryColorDarker
                      : AppColors.primaryColor,
                  textColor: themeController.isDarkMode.value
                      ? AppColors.whiteColor
                      : AppColors.whiteColor,
                  onPressed: () {}),
            );
          }
        },
      ),
    ));
  }
}
