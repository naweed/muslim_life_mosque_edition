class TrackedPrayer {
  int? ID;
  String? Prayer_Date;
  String? Prayer_Name;
  bool? Is_Prayed;
  DateTime? Added_On = DateTime.now();

  TrackedPrayer({this.ID, required this.Prayer_Date, required this.Prayer_Name, this.Is_Prayed = false, this.Added_On});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "Prayer_Date": Prayer_Date,
      "Prayer_Name": Prayer_Name,
      "Is_Prayed": Is_Prayed! ? 1 : 0,
      "Added_On": (Added_On == null) ? DateTime.now().toString() : Added_On.toString(),
    };

    if (ID != null) {
      map["ID"] = ID;
    }

    return map;
  }

  TrackedPrayer.fromMap(Map<String, dynamic> map) {
    ID = map["ID"] as int;
    Prayer_Date = map["Prayer_Date"] as String;
    Prayer_Name = map["Prayer_Name"] as String;
    Is_Prayed = (map["Is_Prayed"] as int) == 0 ? false : true;
    Added_On = DateTime.tryParse(map["Added_On"]);
  }
}

class CompletedSura {
  int? suraNo;
  DateTime? Date_Read = DateTime.now();

  CompletedSura({required this.suraNo, this.Date_Read});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "Sura_No": suraNo,
      "Date_Read": (Date_Read == null) ? DateTime.now().toString() : Date_Read.toString(),
    };

    return map;
  }

  CompletedSura.fromMap(Map<String, dynamic> map) {
    suraNo = map["Sura_No"] as int;
    Date_Read = DateTime.tryParse(map["Date_Read"]);
  }
}
