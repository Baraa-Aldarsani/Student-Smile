import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_smile/feautre/feautre.dart';
import '../../../core/core.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(Images.logoBoarding),
            Text(
              "Welcome to the Department of Dentistry at Damascus University",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              "Join us to be a part of this distinguished scientific journey, as we always strive to raise the level of education and scientific research, and work side by side for better health of society",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            ElevatedBtn(
              height: 45.h,
              width: 250.w,
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString("pref", "checkPref");
                Get.to(SignIn());
              },
              title: 'Get Started',
            ),
          ],
        ),
      ),
    );
  }
}
