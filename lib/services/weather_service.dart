// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sky_lite/models/city_model.dart';
import 'package:sky_lite/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService({required this.apiKey});
  Future<Weather> getWeather(double lat, double lon) async {
    var url = '$BASE_URL?lat=$lat&lon=$lon&appid=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data, please try again');
    }
  }

  Future<City> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String administrativeArea =
        placemarks[0].administrativeArea ?? "Unknown administrativeArea";
    String country = placemarks[0].country ?? "Unknown country";
    String isoCountryCode =
        placemarks[0].isoCountryCode ?? "Unknown CountryCode";
    String locality = placemarks[0].locality ?? "Unknown locality";
    String addressName = placemarks[0].name ?? "Unknown address";
    String postalCode = placemarks[0].postalCode ?? "Unknown postalCode";
    String street = placemarks[0].street ?? "Unknown street";
    String subAdministrativeArea =
        placemarks[0].subAdministrativeArea ?? "Unknown subAdministrativeArea";
    String subLocality = placemarks[0].subLocality ?? "Unknown subLocality";
    String subThoroughfare =
        placemarks[0].subThoroughfare ?? "Unknown subThoroughfare";
    String thoroughfare = placemarks[0].thoroughfare ?? "Unknown thoroughfare";
    String cityName =
        placemarks.isNotEmpty ? placemarks[0].locality ?? "Unknown" : "Unknown";
    double lat = position.latitude;
    double lon = position.longitude;

    return City(
      name: cityName,
      latitude: lat,
      longitude: lon,
      administrativeArea: administrativeArea,
      country: country,
      isoCountryCode: isoCountryCode,
      locality: locality,
      addressName: addressName,
      postalCode: postalCode,
      street: street,
      subAdministrativeArea: subAdministrativeArea,
      subLocality: subLocality,
      subThoroughfare: subThoroughfare,
      thoroughfare: thoroughfare,
    );
  }
}
