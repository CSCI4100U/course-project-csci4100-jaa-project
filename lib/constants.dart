import 'package:course_project/components/menu_option.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:course_project/size_config.dart';

import 'package:course_project/screens/home/components/body.dart' as homeBody;
import 'package:course_project/screens/profile/components/body.dart'
    as profileBody;
import 'package:course_project/screens/event/components/body.dart' as eventBody;
import 'package:course_project/screens/map/components/body.dart' as mapBody;
import 'package:course_project/models/entities/category.dart' as CategoryEntity;
import 'package:intl/intl.dart';

import 'models/notifications.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kTextColorForDarkTheme = Colors.white;
const kBorderOutline = Colors.black;
const kPrimaryDarkThemeBackground = Colors.black12;

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);
final lastDateTimeDate = DateTime(2100);
final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

const NO_AVAILABLE_IMAGE_PATH = 'assets/images/No_image_available.png';
final DateFormatDisplay = DateFormat("yyyy-MM-dd hh:mm:ss");
final DateFormatDisplayShort = DateFormat("yyyy-MM-dd");

final NotificationsConst = Notifications();
const String URL_TEMPLATE =
    "https://api.mapbox.com/styles/v1/joacotome24/clar6ybyw000j14njy9l1uv4p/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoiam9hY290b21lMjQiLCJhIjoiY2xhcjVpam5kMXB2MDN2bzVlY3EydW8xOCJ9.tiwkoeBOZnsBzRgsJxOtpQ";

List<MenuOption> options = [
  MenuOption(
    name: "Home",
    icon: buildIcon(Icons.home),
    builder: () => homeBody.Body(),
  ),
  MenuOption(
      name: "Events",
      icon: buildIcon(Icons.event_available),
      builder: () => const eventBody.Body()),
  MenuOption(
      name: "Map",
      icon: buildIcon(Icons.map),
      builder: () => const mapBody.Body()),
  MenuOption(
      name: "Profile",
      icon: buildIcon(Icons.person),
      builder: () => profileBody.Body()),
];

List<CategoryEntity.Category> defaultCategories = [
  CategoryEntity.Category(
    id: 1,
    name: "Music",
    icon: buildIcon(Icons.music_note),
    description: "Events related to music",
    imagesPath: "assets/images/categories/music",
  ),
  CategoryEntity.Category(
    id: 2,
    name: "Sports",
    icon: buildIcon(Icons.sports_baseball),
    description: "Events related to sport",
    imagesPath: "assets/images/categories/sports",
  ),
  CategoryEntity.Category(
    id: 3,
    name: "Art",
    icon: buildIcon(Icons.art_track),
    description: "Events related to art",
    imagesPath: "assets/images/categories/art",
  ),
  CategoryEntity.Category(
    id: 4,
    name: "Food",
    icon: buildIcon(Icons.fastfood),
    description: "Events related to food",
    imagesPath: "assets/images/categories/food",
  ),
  CategoryEntity.Category(
    id: 5,
    name: "Games",
    icon: buildIcon(Icons.sports_esports),
    description: "Events related to games",
    imagesPath: "assets/images/categories/games",
  ),
  CategoryEntity.Category(
    id: 6,
    name: "Movies",
    icon: buildIcon(Icons.movie),
    description: "Events related to movies",
    imagesPath: "assets/images/categories/movies",
  ),
  CategoryEntity.Category(
    id: 7,
    name: "Other",
    icon: buildIcon(Icons.more_horiz),
    description: "Events related to other topics",
    imagesPath: "assets/images/categories/other",
  ),
];

const List<Locale> supportedLocales = [
  Locale('en'),
  Locale('es'),
];
