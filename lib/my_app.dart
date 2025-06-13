import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.responsiveDesign,
      getPages: AppRouter.pages,
      unknownRoute: AppRouter.unknownRoute,
    );
  }
}
