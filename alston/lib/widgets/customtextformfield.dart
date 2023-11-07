import 'package:alston/utils/appcolors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primaryColorDark,
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintMaxLines: 1,
        hoverColor: AppColors.primaryColorDark,
        labelText: labelText,
        errorStyle: const TextStyle(
          color: Colors.deepOrange,
          fontSize: 12,
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColorDark),
            borderRadius: BorderRadius.circular(5)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColorDark),
            borderRadius: BorderRadius.circular(5)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColorDark),
            borderRadius: BorderRadius.circular(5)),
        labelStyle: const TextStyle(color: AppColors.primaryColorDark),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColorDark),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
              color:
                  AppColors.primaryColorDark), // Border color when not focused
        ),
      ),
      controller: controller,
      validator: validator,
    );
  }
}
