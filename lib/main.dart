import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/utils/my_translations.dart';

import 'utils/unknown_route_page.dart';
import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Todo',
    defaultTransition: Transition.zoom,
    translations: MyTranslations(),
    locale: Locale('en', 'US'),
    theme: ThemeData(
      primarySwatch: Colors.pink,
      primaryColor: Colors.purple,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),


    //  initialRoute: "/masterPage",
      // unknownRoute: GetPage(
      //   name: '/notfoundPaage',
      //   page: () => const UnknownRoutePage(),
      // ),
      // unknownRoute: '/notFoundPage',
      // getPages: Routes.getPages,
    
    // home: MyApp(),
    initialRoute: "/home",
    unknownRoute: GetPage(
      name: '/notFoundPage',
      page: () => UnknownRoutePage(),
    ),
    getPages: Routes.getPages
  );
  }
}