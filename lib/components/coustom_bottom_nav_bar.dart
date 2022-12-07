import 'package:course_project/components/menu_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../constants.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key, required this.selectedOption});

  final MenuOption selectedOption;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FlutterI18n.retrieveLoadingStream(context),
        builder: (context, snapshot) => buildTabBar(context, options));
  }

  void whenChangedLocale() {
    setState(() {});
  }
}
