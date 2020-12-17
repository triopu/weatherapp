class CityData {
  final String id;
  final String city;
  final String province;

  CityData({this.id, this.city, this.province});

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      id: json['id'],
      city: json['kota'],
      province: json['propinsi'],
    );
  }
}