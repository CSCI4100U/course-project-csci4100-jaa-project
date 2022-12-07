import 'package:course_project/auth/fire_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import '/constants.dart';

class MyAccount extends StatefulWidget {
  static String routeName = "/my_account";
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final i18nKey = "profile_screen.my_account";

  @override
  Widget build(BuildContext context) {
    var user = FireAuth.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(FlutterI18n.translate(context, "$i18nKey.title")),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 70),
        child: Center(
          child: Column(
            children: [
              Text(
                FlutterI18n.translate(
                  context,
                  "$i18nKey.email",
                  translationParams: {"email": user.email!},
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (user.displayName != null && user.displayName!.isNotEmpty)
                Text(
                  FlutterI18n.translate(
                    context,
                    "$i18nKey.name",
                    translationParams: {"name": user.displayName!},
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (user.phoneNumber != null && user.phoneNumber!.isNotEmpty)
                Text(
                  FlutterI18n.translate(
                    context,
                    "$i18nKey.phone",
                    translationParams: {"phone": user.phoneNumber!},
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 60),
              _localeDropdown(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _localeDropdown(BuildContext context) {
    Locale actualLocale =
        FlutterI18n.currentLocale(context) ?? const Locale("en");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          FlutterI18n.translate(context, "$i18nKey.locale"),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 35,
        ),
        DropdownButton<Locale?>(
          value: supportedLocales.firstWhere(
              (element) => element.languageCode == actualLocale.languageCode,
              orElse: () => supportedLocales.first),
          items: supportedLocales.map((locale) {
            return DropdownMenuItem(
              value: locale,
              child: Text(
                FlutterI18n.translate(
                    context, "locales.${locale.languageCode}"),
                style: const TextStyle(fontSize: 18),
              ),
            );
          }).toList(),
          onChanged: (Locale? value) async {
            if (value != null) {
              await FlutterI18n.refresh(context, value);
              setState(() {});
            }
          },
        ),
      ],
    );
  }
}
