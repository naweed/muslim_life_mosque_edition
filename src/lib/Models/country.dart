class Country {
  String? id;
  String? name;
  String? pCalc;
  String? asrCalc;

  Country({this.id, this.name, this.pCalc, this.asrCalc});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['Name'];
    pCalc = json['PCalc'];
    asrCalc = json['AsrCalc'];
  }
}
