import 'package:course_project/models/db_models/category_model.dart';
import 'package:course_project/routes.dart';
import 'package:course_project/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:course_project/firebase_options.dart';
import 'package:course_project/theme.dart';
import 'package:course_project/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var categoryModel = CategoryModel();
  for (var category in defaultCategories) {
    await categoryModel.insertCategory(category);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
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
