import 'package:course_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'package:course_project/firebase_options.dart';
import 'package:course_project/theme.dart';
import 'package:course_project/constants.dart';
import 'models/db_models/notifications.dart';
import 'package:course_project/models/db_models/category_model.dart';
import 'package:course_project/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var categoryModel = CategoryModel();
  for (var category in defaultCategories) {
    await categoryModel.insertCategory(category);
  }

  tz.initializeTimeZones();
  final _notifications = Notifications();
  await _notifications.init();

  Geolocator.isLocationServiceEnabled().then((value) async {
    if (!value) {
      await Geolocator.requestPermission();
    }
  });

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Event App',
        theme: theme(),
        initialRoute: HomeScreen.routeName,
        routes: routes,
      ),
    );
  }
}


// StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//       },
//     );
