import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sky_lite/pages/spalsh.dart';
import 'package:sky_lite/utils/colors_manger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sky Lite',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: ColorsManger.primarySwatchColor),
          useMaterial3: true,
        ),
        home: const SplashView(),
      ),
    );
  }
}
