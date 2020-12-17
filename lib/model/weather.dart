class WeatherData {
  
  final String jamCuaca;
  final String kodeCuaca;
  final String cuaca;
  final String humidity;
  final String tempC;

  WeatherData({this.jamCuaca, this.kodeCuaca, this.cuaca, this.humidity, this.tempC});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      jamCuaca: json['jamCuaca'],
      kodeCuaca: json['kodeCuaca'],
      cuaca: json['cuaca'],
      humidity: json['humidity'],
      tempC: json['tempC']
    );
  }
}