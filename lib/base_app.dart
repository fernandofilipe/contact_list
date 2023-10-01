import 'package:contact_list/pages/main_page.dart';
import 'package:contact_list/services/theme_services.dart';
import 'package:contact_list/shared/constants.dart';
import 'package:contact_list/shared/layout/theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Constants.appTitle,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeService().theme,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MainPage(),
    );
  }
}
