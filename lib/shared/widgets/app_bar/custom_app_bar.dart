import 'package:contact_list/services/language_services.dart';
import 'package:contact_list/services/theme_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:math' as math;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isEditingAppBar;
  const CustomAppBar({super.key, this.isEditingAppBar = false});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: InkWell(
        onTap: () async {
          Locale newLocale =
              LanguageServices().getLocale(context.locale.toString());

          await context.setLocale(newLocale);
          Get.updateLocale(newLocale);
        },
        child: Icon(
          Icons.language,
          size: 20,
          color: Get.isDarkMode
              ? Colors.white70
              : Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      leading: widget.isEditingAppBar
          ? null
          : InkWell(
              onTap: () {
                ThemeService().switchTheme();
              },
              child: Transform.rotate(
                angle: 315 * math.pi / 180,
                child: Get.isDarkMode
                    ? const Icon(Icons.wb_sunny_outlined, size: 20)
                    : Icon(
                        Icons.nightlight_outlined,
                        size: 20,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
              ),
            ),
      actions: [
        InkWell(
          onTap: () async {},
          child: CircleAvatar(
            child: Text(
              box.read('initials'),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 20)
      ],
    );
  }
}
