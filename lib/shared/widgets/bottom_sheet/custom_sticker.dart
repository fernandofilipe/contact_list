import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSticker extends StatelessWidget {
  const CustomSticker({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 6,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
        ),
      ),
    );
  }
}
