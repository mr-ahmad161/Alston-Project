// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import '../utils/appcolors.dart';

import 'package:google_fonts/google_fonts.dart';

import '../widgets/navigationdrawer.dart';

class MyBooking extends StatelessWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text('My Booking', style: GoogleFonts.acme()),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.backgroundColor,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('There is no booking',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w100)),
          ],
        ),
      ),
    );
  }
}
