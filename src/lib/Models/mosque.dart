class Mosque {
  String? iD;
  String? mosqueName;
  String? mosqueCode;
  String? phoneCountryISDNCode;
  String? phoneNo;
  String? website;
  String? emailAddress;
  double? latitude;
  double? longitude;
  String? addressLine1;
  String? addressLine2;
  String? addressCity;
  String? addressPostCode;
  String? addressCountryName;
  String? appLanguageCode;
  bool? appLanguageRTL;
  String? prayerCalcMethod;
  String? asrCalcMethod;
  int? adjustmentFajr;
  int? adjustmentSunrise;
  int? adjustmentDhuhr;
  int? adjustmentAsr;
  int? adjustmentMaghrib;
  int? adjustmentIsha;
  int? adjustmentFajrIqamah;
  int? adjustmentDhuhrIqamah;
  int? adjustmentAsrIqamah;
  int? adjustmentMaghribIqamah;
  int? adjustmentIshaIqamah;

  Mosque({
    this.iD,
    this.mosqueName,
    this.mosqueCode,
    this.phoneCountryISDNCode,
    this.phoneNo,
    this.website,
    this.emailAddress,
    this.latitude,
    this.longitude,
    this.addressLine1,
    this.addressLine2,
    this.addressCity,
    this.addressPostCode,
    this.addressCountryName,
    this.appLanguageCode,
    this.appLanguageRTL,
    this.adjustmentFajr,
    this.adjustmentSunrise,
    this.adjustmentDhuhr,
    this.adjustmentAsr,
    this.adjustmentMaghrib,
    this.adjustmentIsha,
    this.adjustmentFajrIqamah,
    this.adjustmentDhuhrIqamah,
    this.adjustmentAsrIqamah,
    this.adjustmentMaghribIqamah,
    this.adjustmentIshaIqamah,
    this.prayerCalcMethod,
    this.asrCalcMethod,
  });

  Mosque.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    mosqueName = json['Mosque_Name'];
    mosqueCode = json['Mosque_Code'];
    phoneCountryISDNCode = json['Phone_Country_ISDN_Code'];
    phoneNo = json['Phone_No'];
    website = json['Website'];
    emailAddress = json['Email_Address'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    addressLine1 = json['Address_Line_1'];
    addressLine2 = json['Address_Line_2'];
    addressCity = json['Address_City'];
    addressPostCode = json['Address_Post_Code'];
    addressCountryName = json['Address_Country_Name'];
    appLanguageCode = json['App_Language_Code'];
    appLanguageRTL = json['App_Language_RTL'];
    adjustmentFajr = json['Adjustment_Fajr'];
    adjustmentSunrise = json['Adjustment_Sunrise'];
    adjustmentDhuhr = json['Adjustment_Dhuhr'];
    adjustmentAsr = json['Adjustment_Asr'];
    adjustmentMaghrib = json['Adjustment_Maghrib'];
    adjustmentIsha = json['Adjustment_Isha'];
    adjustmentFajrIqamah = json['Adjustment_Fajr_Iqamah'];
    adjustmentDhuhrIqamah = json['Adjustment_Dhuhr_Iqamah'];
    adjustmentAsrIqamah = json['Adjustment_Asr_Iqamah'];
    adjustmentMaghribIqamah = json['Adjustment_Maghrib_Iqamah'];
    adjustmentIshaIqamah = json['Adjustment_Isha_Iqamah'];
    prayerCalcMethod = json['Prayer_Calc_Method'];
    asrCalcMethod = json['Asr_Calc_Method'];
  }
}
