import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:necopia/environment/config.dart';
import 'package:http/http.dart' as http;

import 'location_service.dart';

enum AirQuality {
  good,
  moderate,
  sensitive,
  unhealthy,
  veryUnhealth,
  hazardous
}

class Pollution {
  DateTime timeStamp;
  final int _aqius;
  final int _aqicn;

  int get aqi => _aqius;

  Pollution._(this.timeStamp, this._aqius, this._aqicn);

  factory Pollution.fromJson(Map<String, dynamic> json) {
    return Pollution._(
        DateTime.parse(json["ts"]), json["aqius"], json["aqicn"]);
  }

  AirQuality get airQualityStatus => aqi <= 50
      ? AirQuality.good
      : aqi <= 100
          ? AirQuality.moderate
          : aqi <= 150
              ? AirQuality.sensitive
              : aqi <= 200
                  ? AirQuality.unhealthy
                  : aqi <= 300
                      ? AirQuality.veryUnhealth
                      : AirQuality.hazardous;

  @override
  String toString() {
    return {"aqi": aqi, "status": airQualityStatus.toString()}.toString();
  }
}

class Weather {
  DateTime timeStamp;
  final num? _aqius;
  final num? _aqicn;

  num get aqi => _aqius ?? -1;
  final num temperature;
  final num? temperatureMin;
  final num pressure;
  final num humidity;
  final num windSpeed;
  final num windDirection;
  final String icon;

  Weather._(
      this.timeStamp,
      this._aqius,
      this._aqicn,
      this.temperature,
      this.temperatureMin,
      this.pressure,
      this.humidity,
      this.windSpeed,
      this.windDirection,
      this.icon);

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather._(
        DateTime.parse(json["ts"]),
        json["aqius"],
        json["aqicn"],
        json["tp"],
        json["tp_min"],
        json["pr"],
        json["hu"],
        json["ws"],
        json["wd"],
        "https://www.airvisual.com/images/${json["ic"]}.png");
  }

  @override
  String toString() => {
        "temperature": temperature,
        "min_temperature": temperatureMin,
        "atmospheric_pressure": pressure,
        "humidity": humidity,
        "wind_speed": windSpeed,
        "wind_direction": windDirection
      }.toString();
}

class AirVisualResult {
  String? name;
  String city;
  String state;
  String country;

  Pollution currentPollution;
  Weather currentWeather;

  List<Weather> forecasts;

  AirVisualResult._(this.city, this.state, this.country, this.currentPollution,
      this.currentWeather, this.forecasts,
      {this.name});
  factory AirVisualResult.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    final forecastsJson = (json["forecasts"] ?? []) as Iterable<dynamic>;
    final forecasts =
        forecastsJson.map<Weather>((w) => Weather.fromJson(w)).toList();
    return AirVisualResult._(
        json["city"],
        json["state"],
        json["country"],
        Pollution.fromJson(json["current"]["pollution"]),
        Weather.fromJson(json["current"]["weather"]),
        forecasts,
        name: json["name"]);
  }

  @override
  String toString() {
    return {
      "name": name,
      "city": city,
      "state": state,
      "country": country,
      "current_pollution": currentPollution.toString(),
      "current_weather": currentWeather.toString(),
      "forecasts": '[${forecasts.map((e) => e.toString()).toList().join(",")}]'
    }.toString();
  }
}

enum By { position, ip }

abstract class IAirVisualService {
  Future<AirVisualResult> getNearestCityData(
      {Position? position, By by = By.position});
  Future<AirVisualResult> getNearestStationData(
      {Position? position, By by = By.position});
}

class AirVisualService implements IAirVisualService {
  final locationService = Get.find<ILocationService>();
  final hostUrl = "api.airvisual.com";

  @override
  Future<AirVisualResult> getNearestCityData(
      {Position? position, By by = By.position}) async {
    if (by == By.position) {
      position ??= await locationService.getCurrentPosition();
      final url = Uri.https(hostUrl, "v2/nearest_city", {
        "lat": position.latitude.toString(),
        "lon": position.longitude.toString(),
        "key": airVisualApiKey
      });
      debugPrint("Fetching AirVisual API: $url");
      return http.get(url).then((response) {
        final json = jsonDecode(response.body);

        if (json["status"] == "success") {
          return AirVisualResult.fromJson(json["data"]);
        } else {
          return Future.error(json["status"]);
        }
      });
    }
    return Future.error('Not supported method');
  }

  @override
  Future<AirVisualResult> getNearestStationData(
      {Position? position, By by = By.position}) async {
    if (by == By.position) {
      position ??= await locationService.getCurrentPosition();
      final url = Uri.https(hostUrl, "v2/nearest_station", {
        "lat": position.latitude.toString(),
        "lon": position.longitude.toString(),
        "key": airVisualApiKey
      });

      debugPrint("Fetching AirVisual API: $url");

      return http.get(url).then((response) {
        final json = jsonDecode(response.body);

        if (json["status"] == "success") {
          return AirVisualResult.fromJson(json["data"]);
        } else {
          return Future.error(json["status"]);
        }
      });
    }
    return Future.error('Not supported method');
  }
}
