import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_lite/models/city_model.dart';
import 'package:sky_lite/models/weather_model.dart';
import 'package:sky_lite/services/weather_service.dart';
import 'package:sky_lite/utils/colors_manger.dart';
import 'package:sky_lite/utils/text_widget.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherService(apiKey: "d2c7bb7fabed5ca96f69661958b50b63");
  Weather? _weather;

  var administrativeArea = "";
  var country = "";
  var isoCountryCode = "";
  var locality = "";
  var addressName = "";
  var postalCode = "";
  var street = "";
  var subAdministrativeArea = "";
  var subLocality = "";
  var subThoroughfare = "";
  var thoroughfare = "";

  _fetchWeather() async {
    try {
      City currentCity = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeather(
          currentCity.latitude, currentCity.longitude);
      administrativeArea = currentCity.administrativeArea;
      country = currentCity.country;
      isoCountryCode = currentCity.isoCountryCode;
      locality = currentCity.locality;
      addressName = currentCity.name;
      postalCode = currentCity.postalCode;
      street = currentCity.street;
      subAdministrativeArea = currentCity.subAdministrativeArea;
      subLocality = currentCity.subLocality;
      subThoroughfare = currentCity.subThoroughfare;
      thoroughfare = currentCity.thoroughfare;

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sun.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'smoke':
      case 'fog':
      case 'mist':
      case 'haz':
      case 'dust':
        return 'assets/cloud.json';
      case 'shower rain':
      case 'rain':
      case 'drizzle':
        return 'assets/sun_cloud_rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sun.json';
      default:
        return 'assets/sun.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.primaryColor,
      body: _buildWeaterPageBody(),
    );
  }

  Widget _buildWeaterPageBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _cityNameWidget(),
                _lottieAsset(),
                _tempCondationWidget(),
                _buildAreaInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAreaInfo() {
    return Column(
      children: [
        SizedBox(height: 8.h),
        _areaInfo(info: country),
        _areaInfo(info: administrativeArea),
        _areaInfo(info: subAdministrativeArea),
        _areaInfo(info: isoCountryCode),
        _areaInfo(info: locality),
        _areaInfo(info: addressName),
        _areaInfo(info: street),
        _areaInfo(info: postalCode),
        _areaInfo(info: thoroughfare),
        _areaInfo(info: subThoroughfare),
        _areaInfo(info: subLocality),
        _areaInfo(
            info:
                "Important Alert: All displayed data is unofficial, and the application is not responsible for considering it as official or acting upon it."),
      ],
    );
  }

  Widget _areaInfo({required String info}) {
    if (info.isNotEmpty || info != "") {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        child: Card(
          elevation: 5,
          color: ColorsManger.whiteColor,
          shadowColor: ColorsManger.whiteColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 14.h),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: textWidget(
                  text: info,
                  fontSize: 20.sp,
                  color: ColorsManger.grayColor,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Container();
  }

  Widget _cityNameWidget() {
    return Column(
      children: [
        Icon(
          Icons.location_on,
          size: 30.w,
          color: ColorsManger.grayColor,
        ),
        SizedBox(height: 8.h),
        textWidget(
          text: _weather?.cityName ?? "Loading city...",
          fontSize: 20.sp,
          color: ColorsManger.grayColor,
        ),
      ],
    );
  }

  Widget _lottieAsset() {
    DateTime now = DateTime.now();
    if (now.hour >= 19 || now.hour < 6) {
      return Lottie.asset("assets/moon.json");
    } else {
      return Lottie.asset(getWeatherAnimation(_weather?.mainCondition));
    }
  }

  Widget _tempCondationWidget() {
    return Column(
      children: [
        textWidget(
          text:
              "${_weather?.getTemperatureInCelsius().toStringAsFixed(0) ?? ""}°",
          fontSize: 24.sp,
          color: ColorsManger.grayColor,
        ),
        textWidget(
          text: _weather?.mainCondition ?? "",
          fontSize: 20.sp,
          color: ColorsManger.grayColor,
        ),
      ],
    );
  }
}
