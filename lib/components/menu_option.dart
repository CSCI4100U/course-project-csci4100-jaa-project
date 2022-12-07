import 'package:course_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

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
    onSelected ??= () {};
  }
}

PreferredSizeWidget buildTabBar(
  BuildContext context,
  List<MenuOption> options,
) {
  const i18nKey = "components.menu_option";
  return TabBar(
      labelStyle: const TextStyle(fontSize: 16, color: kPrimaryColor),
      labelColor: kPrimaryColor,
      indicatorColor: kSecondaryColor,
      indicator: const BoxDecoration(color: kSecondaryColor),
      onTap: (value) => options[value].onSelected!(),
      tabs: options
          .map(
            (option) => Tab(
              text: FlutterI18n.translate(context, "$i18nKey.${option.name}"),
              icon: option.icon,
            ),
          )
          .toList());
}

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
