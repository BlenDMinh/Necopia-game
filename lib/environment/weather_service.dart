class Condition {}

class Weather {
  Condition condition;
  Weather._(this.condition);
}

// Chỉ lọc những cái cần thiết, không cần phải có tất cả các property trong json
class WeatherResult {
  Weather current;
  List<Weather> forecasts;
  // ...

  WeatherResult._(this.current, this.forecasts);
}

abstract class IWeatherService {
  WeatherResult fetch(double latitude, double longtitude);
}

class WeatherService implements IWeatherService {
  @override
  WeatherResult fetch(double latitude, double longtitude) {
    throw UnimplementedError();
  }
}
