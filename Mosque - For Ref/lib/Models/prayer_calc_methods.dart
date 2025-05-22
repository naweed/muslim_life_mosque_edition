class PrayerCalcMethod {
  String? id;
  String? description;

  PrayerCalcMethod({this.id, this.description});

  static List<PrayerCalcMethod> getPrayerCalcMethods() {
    return [
      PrayerCalcMethod(id: "Diyanet İşleri Başkanlığı, Turkey", description: "Diyanet İşleri Başkanlığı, Turkey"),
      PrayerCalcMethod(id: "Dubai, UAE", description: "Dubai, UAE"),
      PrayerCalcMethod(id: "Egyptian General Authority of Survey", description: "Egyptian General Authority of Survey"),
      PrayerCalcMethod(
        id: "Institute of Geophysics, University of Tehran",
        description: "Institute of Geophysics, University of Tehran",
      ),
      PrayerCalcMethod(id: "Islamic Society of North America", description: "Islamic Society of North America"),
      PrayerCalcMethod(id: "Kuwait", description: "Kuwait"),
      PrayerCalcMethod(id: "London Unified Prayer Timetable", description: "London Unified Prayer Timetable"),
      PrayerCalcMethod(
        id: "Majlis Ugama Islam Singapura, Singapore",
        description: "Majlis Ugama Islam Singapura, Singapore",
      ),
      PrayerCalcMethod(id: "Moonsighting Committee", description: "Moonsighting Committee"),
      PrayerCalcMethod(id: "Muslim World League", description: "Muslim World League"),
      PrayerCalcMethod(id: "Qatar", description: "Qatar"),
      PrayerCalcMethod(
        id: "Shia Ithna-Ashari, Leva Institute, Qum",
        description: "Shia Ithna-Ashari, Leva Institute, Qum",
      ),
      PrayerCalcMethod(id: "Umm Al-Qura University, Makkah", description: "Umm Al-Qura University, Makkah"),
      PrayerCalcMethod(
        id: "University of Islamic Sciences, Karachi",
        description: "University of Islamic Sciences, Karachi",
      ),
    ];
  }
}
