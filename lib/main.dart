import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/utils/my_translations.dart';

import 'bindings/all_binding.dart';
import 'utils/unknown_route_page.dart';
import 'utils/routes.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    defaultTransition: Transition.zoom,
    translations: MyTranslations(),
    locale: Locale('en', 'US'),
    theme: ThemeData(
      primarySwatch: Colors.pink,
      primaryColor: Colors.purple,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    
    // home: MyApp(),
    initialBinding: AllBinding(),
    initialRoute: Routes.homePage,
    unknownRoute: GetPage(
      name: '/notfound',
      page: () => UnknownRoutePage(),
    ),
    getPages: Routes.getPages
  ));
}
