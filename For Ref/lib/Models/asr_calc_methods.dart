class AsrCalcMethod {
  String? id;
  String? description;

  AsrCalcMethod({this.id, this.description});

  static List<AsrCalcMethod> getAsrCalcMethods() {
    return [
      AsrCalcMethod(id: "Hanafi", description: "Hanafi: Later Asr / Mithl 2"),
      AsrCalcMethod(id: "Shafi", description: "Shafi: Earlier Asr / Mithl 1"),
    ];
  }
}
