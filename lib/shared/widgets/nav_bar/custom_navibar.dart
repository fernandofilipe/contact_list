import 'package:flutter/material.dart';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

class CustomNavibar extends StatelessWidget {
  final List<CurvedNavigationBarItem> items;
  final Function(int)? onTap;
  final int index;
  const CustomNavibar({
    super.key,
    required this.onTap,
    required this.items,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: key,
      backgroundColor: Colors.transparent,
      color: Theme.of(context).colorScheme.inversePrimary,
      items: items,
      onTap: onTap,
      index: index,
      height: 60,
      animationDuration: const Duration(milliseconds: 400),
    );
  }
}
