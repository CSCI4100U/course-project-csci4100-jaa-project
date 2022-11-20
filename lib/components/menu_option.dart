import 'package:course_project/constants.dart';
import 'package:flutter/material.dart';

// used for the Home screen
// takes in a builder function, a onSelected function, icon, and name

class MenuOption {
  static int optionsCount = 0;

  int id = 0;
  String? name;
  Widget? icon;
  Function? builder;
  Function? onSelected;

  MenuOption({this.builder, this.icon, this.name, this.onSelected}) {
    optionsCount++;
    id = optionsCount;

    // if onSelected function is null, set it to do nothing
    if (this.onSelected == null) {
      this.onSelected = () {};
    }
  }
}

// for the tab bar at the bottom of the screen (Home, Events, Map, Profile)
PreferredSizeWidget buildTabBar(List<MenuOption> options) {
  return TabBar(
      labelStyle: const TextStyle(fontSize: 16, color: kPrimaryColor),
      labelColor: kPrimaryColor,
      indicatorColor: kSecondaryColor,
      indicator: const BoxDecoration(color: kSecondaryColor),

      // uses onSelected function to switch to the selected screen
      onTap: (value) => options[value].onSelected!(),

      // options (Home, Events, Map, Profile) and their names and icons
      tabs: options
          .map((option) => Tab(text: option.name, icon: option.icon))
          .toList());
}

// to build the tab bar view with the tab bar that was built
buildTabBarView(options) {
  return TabBarView(
      children: options.map<Widget>((option) {
    return Container(child: option.builder());
  }).toList());
}

buildIcon(IconData icon) {
  return Icon(
    icon,
    color: kPrimaryColor,
  );
}
