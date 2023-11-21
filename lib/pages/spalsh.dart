import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sky_lite/pages/weather_page.dart';
import 'package:sky_lite/utils/colors_manger.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const WeatherPage()),
        (route) => false);
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManger.primaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorsManger.primaryColor,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: ColorsManger.primaryColor,
      body: Padding(
        padding: EdgeInsets.all(100.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png"),
              const Spacer(),
              Text(
                "Sky Lite",
                style: TextStyle(
                  fontSize: 20.h,
                  fontWeight: FontWeight.bold,
                  color: ColorsManger.fourthColor,
                ),
              ),
              Text(
                "Copyright ©",
                style: TextStyle(
                    fontSize: 12.h,
                    fontWeight: FontWeight.bold,
                    color: ColorsManger.whiteColor),
              ),
              Text(
                "Abanoub Ezzat 2023.",
                style: TextStyle(
                    fontSize: 12.h,
                    fontWeight: FontWeight.bold,
                    color: ColorsManger.whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
