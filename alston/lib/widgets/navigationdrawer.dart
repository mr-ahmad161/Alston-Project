// ignore_for_file: depend_on_referenced_packages
import 'package:alston/utils/appcolors.dart';
import 'package:alston/view/mybooking.dart';
import 'package:alston/view/notification.dart';
import 'package:alston/view/shiftscreen.dart';
import 'package:alston/view/sign_in_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/endshift_screen.dart';
import '../view/homepage.dart';
import '../view/takearest_screen.dart';

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 245,
        color: AppColors.primaryColor,
        padding: const EdgeInsets.only(left: 15, bottom: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            CircleAvatar(
                maxRadius: 50,
                backgroundImage: AssetImage('assets/images/user.png')),
            SizedBox(
              height: 30,
            ),
            Text(
              'Imax Melbourne',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
            ),
          ],
        ));
  }
}

Widget myDrawerList() {
  return Column(
    children: [
      manuItem(
        'Home',
        Icons.home,
        () => Get.offAll(const HomePage()),
      ),
      manuItem(
        'Notification',
        Icons.notifications_none_rounded,
        () => Get.to(const ChatScreen()),
      ),
      manuItem('Shifts', Icons.folder_copy_outlined,
          () => Get.to(const ShiftScreen())),
      manuItem('My Bookings', Icons.timer_outlined,
          () => Get.offAll(const MyBooking())),
      const Divider(thickness: 1, height: 1),
      manuItem('Take A Rest', Icons.timer_outlined,
          () => Get.offAll(const TakeARestScreen())),
      manuItem('Bus Routes', Icons.map_outlined,
          () => Get.offAll(const MyBooking())),
      manuItem(
          'End Shift', Icons.lock, () => Get.offAll(const EndShiftScreen())),
      const Divider(thickness: 1, height: 1),
      manuItem('Logout', Icons.logout, ()  => Get.offAll( SignInScreen())),
    ],
  );
}

Widget manuItem(String title, IconData? icon, Function()? onPressed) {
  return Material(
    child: InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              child: Icon(
                icon,
                color: AppColors.primaryColor,
                size: 28,
              ),
            )),
            Expanded(
                flex: 4,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, color: AppColors.primaryColor),
                ))
          ],
        ),
      ),
    ),
  );
}