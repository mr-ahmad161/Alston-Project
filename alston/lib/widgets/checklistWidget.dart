import 'dart:io';
import 'package:alston/model/Prestart%20Activity/prestart_list_model.dart';
import 'package:alston/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../utils/appcolors.dart';
import '../utils/theme_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckListWidget extends StatefulWidget {
  final ThemeController themeController;
  final PrestartItem prestartItem;
  final Function(bool) onOptionSelected;
  final double width;
  final String apiToken;

  const CheckListWidget({
    Key? key,
    required this.themeController,
    required this.prestartItem,
    required this.onOptionSelected,
    this.width = 200,
    required this.apiToken,
  }) : super(key: key);

  @override
  _CheckListWidgetState createState() => _CheckListWidgetState();
}

class _CheckListWidgetState extends State<CheckListWidget> {
  bool isCorrectSelected = false;
  bool isWrongSelected = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double iconSize = screenWidth * 0.075;
    double spaceBetween = screenHeight * 0.02;

    return Obx(() {
      return SizedBox(
        width: screenWidth * 0.8,
        height: screenHeight * 0.8,
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: widget.themeController.isDarkMode.value
              ? AppColors.primaryColor
              : AppColors.backgroundColors,
          child: Padding(
            padding: EdgeInsets.only(
              top: screenWidth * 0.1,
              left: screenWidth * 0.03,
              right: screenWidth * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.prestartItem.getFormattedQuestion(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                  ).merge(GoogleFonts.josefinSans()),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  "Please Submit the  Following:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIcon(Icons.check, isCorrectSelected, Colors.green, () {
                        setState(() {
                          isCorrectSelected = !isCorrectSelected;
                          isWrongSelected = false;
                          widget.onOptionSelected(isCorrectSelected);
                        });
                        _submitPrestartStep2(true);
                      }, iconSize, "Yes"),
                      SizedBox(width: spaceBetween),
                      _buildIcon(Icons.close, isWrongSelected, Colors.red, () {
                        setState(() {
                          isWrongSelected = !isWrongSelected;
                          isCorrectSelected = false;
                          widget.onOptionSelected(!isWrongSelected);
                        });
                        _submitPrestartStep2(false);
                      }, iconSize, "No"),
                      SizedBox(width: spaceBetween),
                      _buildIcon(Icons.image, false, Colors.white, _showImageSourceDialog, iconSize, "Upload a Image"),
                      SizedBox(width: spaceBetween),
                      _buildIcon(Icons.edit_note, false, Colors.white, _showInputDialog, iconSize, "Ask a Question"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildIcon(IconData icon, bool isSelected, Color color, VoidCallback onTap, double size, String text) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Icon(icon, color: isSelected ? color : Colors.white, size: size),
              SizedBox(
                width: screenWidth * 0.05,
              ),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? color : Colors.white,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.01,
          )
        ],
      ),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Take a Photo"),
                onTap: () {
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        _uploadPhoto(File(pickedFile.path));
      }
    } catch (e) {
      debugPrint("Image picker error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
        ),
      );
    }
  }

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Ask a Question"),
          content: const TextField(
            decoration: InputDecoration(hintText: "Type your question here"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Implement logic to handle the submitted question
                Navigator.pop(context);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
  final String _baseUrl = 'https://cloudfront.safelineworld.com/api';
  Future<void> _submitPrestartStep2(bool isCorrect) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/submit-prestart-question'),
        body: {
          'api_token': widget.apiToken,
          'prestart_id': widget.prestartItem.prestartId.toString(),
          'flag': isCorrect ? '1' : '0',
          'note': 'YOUR_NOTE', // Replace with the actual note
        },
      );

      if (response.statusCode == 200) {
        print('Prestart Step 2 submitted successfully');
      } else {
        debugPrint('Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
    }
  }

  Future<void> _uploadPhoto(File photoFile) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/submit-prestart-photo'),
        body: {
          'api_token': widget.apiToken,
          'prestart_id': widget.prestartItem.prestartId.toString(),
        },
        files: [http.MultipartFile.fromBytes('photo', await photoFile.readAsBytes())],
      );

      if (response.statusCode == 200) {
        print('Photo uploaded successfully');
      } else {
        debugPrint('Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
    }
  }
}
