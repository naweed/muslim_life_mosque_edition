class City {
  int? iD;
  String? name;
  String? countryCode;
  double? lat;
  double? lon;

  City({this.iD, this.name, this.lat, this.lon, this.countryCode});

  City.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    countryCode = json['CountryCode'];
    lat = json['Lat']?.toDouble();
    lon = json['Lon']?.toDouble();
  }
}
