// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Login/login_response_model.dart';



// *******************  Login **********************//

class ApiService extends GetxService {
  final String _baseUrl = 'https://cloudfront.safelineworld.com/api';

  Future<LoginResponse?> login(String email, String password) async {
    var url = Uri.parse('$_baseUrl/driver-login');
    try {
      var response = await http
          .post(url, body: {'email': "max@admin.com", 'password': "12321"});

      if (response.statusCode == 200) {
        print("ajssjsks");
        var jsonResponse = json.decode(response.body);
        await _setLoginStatus(true); // Set login status on successful login
        return LoginResponse.fromJson(jsonResponse);
      } else {
        // Handle non-200 responses
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle network errors
      debugPrint('Exception caught: $e');
      return null;
    }
  }

  Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> _setLoginStatus(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }

  Future<void> logout() async {
    await _setLoginStatus(false); // Set login status to false on logout
    // Perform additional logout actions if necessary
  }







}
