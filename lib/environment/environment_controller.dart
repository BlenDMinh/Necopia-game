import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:necopia/environment/air_visual_service.dart';
import 'package:necopia/environment/config.dart';
import 'package:necopia/environment/openuv_service.dart';

enum EnvTime { morning, noon, afternoon, night }

enum EnvWeather { normal, rain, thunder }

enum EnvUv { low, moderate, high, veryHigh, extreme }

class Environment {
  late EnvTime time;
  EnvWeather weather = EnvWeather.normal;
  EnvUv uv = EnvUv.low;
  AirQuality airQuality = AirQuality.good;

  OpenUVResult? openUvResult;
  AirVisualResult? airVisualResult;

  static int count = 0;
  Environment() {
    debugPrint("Creating new Environment instance");
    final dtime = DateTime.now();
    time = dtime.hour <= 7
        ? EnvTime.morning
        : dtime.hour <= 15
            ? EnvTime.noon
            : dtime.hour <= 18
                ? EnvTime.afternoon
                : EnvTime.night;
  }

  int get current => count;
}

abstract class IEnvironmentController {
  Environment get currentEnvironment;

  void listen(void Function(Environment?) onChange);

  Stream<Environment?> get stream;

  // For testing only
  void forceUpdate();

  // true = auto update, false = manual
  void setUpdate(bool status);
  void updateEnv(Environment environment);
  bool get updateStatus;
}

class EnvironmentController extends GetxController
    implements IEnvironmentController {
  final openUvService = Get.find<IOpenUVService>();
  final airVisualService = Get.find<IAirVisualService>();

  final Rxn<Environment> _environment = Rxn<Environment>(Environment());

  @override
  Environment get currentEnvironment => _environment.value!;

  @override
  Stream<Environment?> get stream => _environment.stream;

  _updateOpenUv() async {
    debugPrint("Updating OpenUV Information");
    OpenUVResult result = await openUvService.getUVData();
    // update
    _environment.value!.openUvResult = result;
    _environment.value!.uv = result.uv <= 2
        ? EnvUv.low
        : result.uv <= 5
            ? EnvUv.moderate
            : result.uv <= 7
                ? EnvUv.high
                : result.uv <= 10
                    ? EnvUv.veryHigh
                    : EnvUv.extreme;

    _environment.refresh();
    _environment.value = _environment.value;
  }

  _updateAirVisual() async {
    debugPrint("Updating AirVisual Information");
    AirVisualResult result = await airVisualService.getNearestCityData();
    // update
    _environment.value!.airVisualResult = result;
    _environment.value!.airQuality = result.currentPollution.airQualityStatus;

    _environment.refresh();
    _environment.value = _environment.value;
  }

  _updateTime() {
    debugPrint("Updating time");
    // var environment = _environment.value;
    DateTime time = DateTime.now();
    _environment.value!.time = time.hour <= 7
        ? EnvTime.morning
        : time.hour <= 15
            ? EnvTime.noon
            : time.hour <= 18
                ? EnvTime.afternoon
                : EnvTime.night;
    _environment.refresh();
    _environment.value = _environment.value;
  }

  @override
  void listen(void Function(Environment?) onChange) {
    _environment.listen(onChange);
  }

  @override
  void onInit() {
    debugPrint("Initializing Environment Controller");
    super.onInit();

    // Test update
    // Stream.periodic(Duration(seconds: 1), (time) {
    //   forceUpdate();
    //   return time;
    // }).forEach((element) {});

    // Time init + update
    Stream.periodic(Duration(seconds: 5), (time) {
      if (!_updateStatus) {
        debugPrint("");
        return time;
      }
      _updateTime();
      return time;
    }).forEach((element) {});

    // OpenUV update
    Stream.periodic(Duration(seconds: openUvUpdateInterval), (time) {
      if (!_updateStatus) return time;
      _updateOpenUv();
      return time;
    }).forEach((element) {});

    // AirVisual update
    Stream.periodic(Duration(seconds: airVisualUpdateInterval), (time) {
      if (!_updateStatus) return time;
      _updateAirVisual();
      return time;
    }).forEach((element) {});

    if (_updateStatus) forceUpdate();
  }

  @override
  void forceUpdate() {
    _updateTime();
    // Temporary disable
    _updateOpenUv();
    _updateAirVisual();
  }

  bool _updateStatus = true;

  @override
  void setUpdate(bool status) {
    _updateStatus = status;
  }

  @override
  void updateEnv(Environment environment) {
    _environment.value = environment;
    _environment.refresh();
  }

  @override
  bool get updateStatus => _updateStatus;
}
