import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:necopia/environment/config.dart';
import 'package:necopia/environment/location_service.dart';
import 'package:http/http.dart' as http;

class OpenUVResult {
  num uv;
  num uvMax;
  num ozone;
  DateTime uvTime;
  DateTime uvMaxTime;
  DateTime ozoneTime;
  List<num> safeExposureTime;

  OpenUVResult._(this.uv, this.uvTime, this.uvMax, this.uvMaxTime, this.ozone,
      this.ozoneTime, this.safeExposureTime);

  factory OpenUVResult.fromJson(Map<String, dynamic> json) {
    List<int> safeExposureTime = [];
    final stJson = json["safe_exposure_time"] as Map<String, dynamic>;

    for (final i in stJson.values) {
      if (i != null && i != Null) {
        safeExposureTime.add(i);
      }
    }

    return OpenUVResult._(
        double.parse(json["uv"].toString()),
        DateTime.parse(json["uv_time"]),
        double.parse(json["uv_max"].toString()),
        DateTime.parse(json["uv_max_time"]),
        double.parse(json["ozone"].toString()),
        DateTime.parse(json["ozone_time"]),
        safeExposureTime);
  }

  @override
  String toString() => {
        "uv": uv,
        "uv_time": uvTime.toIso8601String(),
        "uv_max": uvMax,
        "uv_max_time": uvMaxTime.toIso8601String(),
        "ozone": ozone,
        "ozone_time": ozoneTime.toIso8601String(),
        "safe_exposure_time":
            '[${safeExposureTime.map((e) => e.toString()).toList().join(',')}]'
      }.toString();
}

abstract class IOpenUVService {
  Future<OpenUVResult> getUVData({Position? position});
}

class OpenUVService implements IOpenUVService {
  final locationService = Get.find<ILocationService>();

  @override
  Future<OpenUVResult> getUVData({Position? position}) async {
    position ??= await locationService.getCurrentPosition();
    final url = Uri.https("api.openuv.io", "api/v1/uv", {
      "lat": position.latitude.toString(),
      "lng": position.longitude.toString()
    });
    http.get(url, headers: {"x-access-token": openUvApiKey}).then(
        (response) => print(jsonDecode(response.body)["result"]));

    return http.get(url, headers: {"x-access-token": openUvApiKey}).then(
        (response) =>
            OpenUVResult.fromJson(jsonDecode(response.body)["result"]));
  }
}
