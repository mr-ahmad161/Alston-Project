import 'package:flutter/material.dart';

import '../utils/appcolors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color? buttonColor; // Existing property for button background color
  final Color? textColor; // New property for text color

  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
    this.textColor, // Initialize the new property
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7), // Make the border circular
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color:
                textColor ?? AppColors.textColor, // Apply the text color here
          ),
        ),
      ),
    );
  }
}
