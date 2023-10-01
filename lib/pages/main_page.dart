import 'package:contact_list/controllers/contact_controller.dart';
import 'package:contact_list/pages/contacts/contact_list_page.dart';
import 'package:contact_list/pages/favorites/favorite_list_page.dart';
import 'package:contact_list/pages/recent/recent_contacts_page.dart';
import 'package:contact_list/shared/widgets/app_bar/custom_app_bar.dart';
import 'package:contact_list/shared/widgets/nav_bar/custom_navibar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final ContactsController _contactController;
  late final PageController _pageController;
  final box = GetStorage();
  int pagePosition = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _contactController = Get.put(ContactsController());
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (pos) {
          setState(() {
            pagePosition = pos;
          });
        },
        children: [
          ContactListPage(controller: _contactController),
          RecentContactPage(controller: _contactController),
          FavoriteListPage(controller: _contactController),
        ],
      ),
      bottomNavigationBar: CustomNavibar(
        onTap: (value) {
          _pageController.jumpToPage(value);
        },
        items: <CurvedNavigationBarItem>[
          CurvedNavigationBarItem(
            child: const Icon(
              Icons.people_alt,
              color: Colors.white,
            ),
            label: context.tr('APP_BAR_LABEL_CONTACT'),
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          CurvedNavigationBarItem(
            child: const Icon(
              Icons.schedule,
              color: Colors.white,
            ),
            label: context.tr('APP_BAR_LABEL_RECENTS'),
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          CurvedNavigationBarItem(
            child: const Icon(
              Icons.star_border_rounded,
              color: Colors.white,
            ),
            label: context.tr('APP_BAR_LABEL_FAVORITES'),
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        index: pagePosition,
      ),
    );
  }
}
