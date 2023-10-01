import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    String loaderUrl = Get.isDarkMode
        ? 'assets/images/app_loading_dark_mode.json'
        : 'assets/images/app_loading.json';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LottieBuilder.asset(loaderUrl),
      ],
    );
  }
}
