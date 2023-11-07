// ignore_for_file: depend_on_referenced_packages, unused_local_variable

import 'package:alston/utils/appcolors.dart';

import 'package:alston/utils/theme_controller.dart';
import 'package:alston/widgets/checklistscreen.dart';
import 'package:alston/widgets/customelevatedbutton.dart';
import 'package:alston/widgets/customtextformfield.dart';
import 'package:alston/widgets/navigationdrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PreStartCheckList extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _locationName = TextEditingController();
  final TextEditingController _mileage = TextEditingController();

  PreStartCheckList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Accessing the ThemeController
    final ThemeController themeController = Get.find<ThemeController>();

    // Using Obx to listen to changes
    return Obx(() {
      // Determine if dark mode is enabled
      final isDarkMode = themeController.isDarkMode.value;

      // Choose colors based on the theme mode
      final Color appBarColor =
          isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColor;
      final Color backgroundColor = isDarkMode
          ? AppColors.backgroundColorDarker
          : AppColors.backgroundColor;
      final Color textColor =
          isDarkMode ? AppColors.textColorDarker : AppColors.textColor;
      final Color primaryColor =
          isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColor;

      return Scaffold(
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const MyDrawerHeader(), // Make sure this is properly defined or remove if not needed
                myDrawerList(), // Make sure this is properly defined or remove if not needed
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Pre-Start Checklist', style: GoogleFonts.acme()),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: backgroundColor,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02 * 7),
                  CenterTextPair(
                      text: 'Driver Name : ',
                      value: 'Imax Melbourne',
                      textColor: textColor),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CenterTextPair(
                      text: 'Bus Number : ',
                      value: 'BS04HW',
                      textColor: textColor),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02 * 2),
                  CustomTextFormField(
                    labelText: "Enter location name",
                      obscureText: false,
                    controller: _locationName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Location cannot be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomTextFormField(
                    labelText: "Enter Mileage",
                      obscureText: false, 
                    controller: _mileage,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mileage cannot be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02 * 2.5),
                  CustomElevatedButton(
                    buttonText: 'Submit info',
                    buttonColor: themeController.isDarkMode.value
                        ? AppColors.primaryColorDarker
                        : AppColors.primaryColor,
                    textColor: themeController.isDarkMode.value
                        ? AppColors.whiteColor
                        : AppColors.textColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Navigate to the next screen
                        Get.to(
                            const CheckList()); // Make sure CheckListScreen is properly defined
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

// Helper widget to create a row of text with a title and value
class CenterTextPair extends StatelessWidget {
  final String text;
  final String value;
  final Color textColor;

  const CenterTextPair({
    Key? key,
    required this.text,
    required this.value,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w100,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: textColor,
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),
      ],
    );
  }
}
