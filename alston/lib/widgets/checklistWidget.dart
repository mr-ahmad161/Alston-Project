// ignore_for_file: library_private_types_in_public_api, file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CheckListWidget extends StatefulWidget {
  final String question;
  final Function(bool) onOptionSelected;

  const CheckListWidget({
    super.key,
    required this.question,
    required this.onOptionSelected,
  });

  @override
  _CheckListWidgetState createState() => _CheckListWidgetState();
}

class _CheckListWidgetState extends State<CheckListWidget> {
  bool isCorrectSelected = false;
  bool isWrongSelected = false;

  @override
  Widget build(BuildContext context) {
    // Obtain screen size for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust icon size and spacing based on screen size
    double iconSize = screenWidth * 0.075; // e.g., 7.5% of screen width
    double spaceBetween = screenHeight * 0.02; // e.g., 2% of screen height

    return Card(
      margin: EdgeInsets.all(screenWidth * 0.02), // e.g., 2% of screen width
      elevation: 8,
      color: Colors.blue, // Replace with your color: AppColors.primaryColor,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // e.g., 4% of screen width
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.question,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.045), // Dynamically sized text
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spaceBetween),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIcon(Icons.check, isCorrectSelected, Colors.orangeAccent,
                    () {
                  setState(() {
                    isCorrectSelected = !isCorrectSelected;
                    isWrongSelected = false;
                    widget.onOptionSelected(isCorrectSelected);
                  });
                }, iconSize),
                SizedBox(width: spaceBetween),
                _buildIcon(Icons.close, isWrongSelected, Colors.red, () {
                  setState(() {
                    isWrongSelected = !isWrongSelected;
                    isCorrectSelected = false;
                    widget.onOptionSelected(!isWrongSelected);
                  });
                }, iconSize),
                SizedBox(width: spaceBetween),
                _buildIcon(Icons.image, false, Colors.white,
                    _showImageSourceDialog, iconSize),
                SizedBox(width: spaceBetween),
                _buildIcon(Icons.edit_note, false, Colors.white,
                    _showInputDialog, iconSize),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, bool isSelected, Color color,
      VoidCallback onTap, double size) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: isSelected ? color : Colors.white, size: size),
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
                leading: const Icon(
                    Icons.image), // Use your AppColors.primaryColor if needed
                title: const Text("Choose from Gallery"),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(
                    Icons.camera), // Use your AppColors.primaryColor if needed
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
        // Use the picked file
        // Example: setState(() => _imageFile = File(pickedFile.path));

        // If you need to upload the image or do anything else with it,
        // you can do that here.
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
}
