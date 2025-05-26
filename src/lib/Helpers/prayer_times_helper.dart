import 'package:adhan/adhan.dart';

class PrayerTimesHelper {
  static Future<PrayerTimes?> getPrayerTimes({
    required DateTime theDate,
    required double userLat,
    required double userLon,
    required String prayerCalcMethod,
    required String asrCalculationMethod,
    required int fajrAdjustment,
    required int sunriseAdjustment,
    required int dhuhrAdjustment,
    required int asrAdjustment,
    required int maghribAdjustment,
    required int ishaAdjustment,
  }) async {
    PrayerTimes? prayerTimes;

    var prayerParams = _getParameters(
      prayerCalcMethod,
      fajrAdjustment,
      sunriseAdjustment,
      dhuhrAdjustment,
      asrAdjustment,
      maghribAdjustment,
      ishaAdjustment,
    );

    prayerParams.madhab = asrCalculationMethod == "Shafi" ? Madhab.shafi : Madhab.hanafi;

    prayerTimes = PrayerTimes(Coordinates(userLat, userLon), DateComponents.from(theDate), prayerParams);

    return prayerTimes;
  }

  static CalculationParameters _getParameters(
    String calcMethod,
    int fajrAdjustment,
    int sunriseAdjustment,
    int dhuhrAdjustment,
    int asrAdjustment,
    int maghribAdjustment,
    int ishaAdjustment,
  ) {
    return switch (calcMethod) {
      "Muslim World League" => CalculationMethod.north_america.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "Egyptian General Authority of Survey" => CalculationMethod.egyptian.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "University of Islamic Sciences, Karachi" => CalculationMethod.karachi.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "Umm Al-Qura University, Makkah" => CalculationMethod.umm_al_qura.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "Dubai, UAE" => CalculationMethod.dubai.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "Islamic Society of North America" => CalculationMethod.north_america.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "Moonsighting Committee" => CalculationMethod.moon_sighting_committee.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "Kuwait" => CalculationMethod.kuwait.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "Qatar" => CalculationMethod.qatar.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "Majlis Ugama Islam Singapura, Singapore" => CalculationMethod.singapore.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "Diyanet İşleri Başkanlığı, Turkey" => CalculationMethod.turkey.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "Institute of Geophysics, University of Tehran" => CalculationMethod.tehran.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "Shia Ithna-Ashari, Leva Institute, Qum" =>
        CalculationParameters(
          fajrAngle: 17.7,
          ishaAngle: 14,
          maghribAngle: 4.5,
        ).withMethodAdjustments(
          PrayerAdjustments(
            fajr: 0 + fajrAdjustment,
            dhuhr: 0 + dhuhrAdjustment,
            asr: 0 + asrAdjustment,
            maghrib: 0 + maghribAdjustment,
            isha: 0 + ishaAdjustment,
            sunrise: 0 + sunriseAdjustment,
          ),
        ),
      "London Unified Prayer Timetable" => CalculationMethod.north_america.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: -3 + fajrAdjustment,
          dhuhr: 6 + dhuhrAdjustment,
          asr: 3 + asrAdjustment,
          maghrib: 4 + maghribAdjustment,
          isha: -2 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      "custom" => CalculationMethod.other.getParameters().withMethodAdjustments(
        PrayerAdjustments(
          fajr: 0 + fajrAdjustment,
          dhuhr: 0 + dhuhrAdjustment,
          asr: 0 + asrAdjustment,
          maghrib: 0 + maghribAdjustment,
          isha: 0 + ishaAdjustment,
          sunrise: 0 + sunriseAdjustment,
        ),
      ),
      _ => throw FormatException('Invalid Calculation Method'),
    };
  }

  // static Future<(String, DateTime)> getNextPrayer(PrayerTimes prayers, DateTime currentDateTime) async {
  //   String? prayerName;
  //   DateTime? prayerTime;

  //   var nextPrayer = prayers.nextPrayerByDateTime(currentDateTime);

  //   if (nextPrayer == Prayer.none) {
  //     var nextDayPrayers = await getPrayerTimes(currentDateTime.add(Duration(days: 1)));

  //     prayerName = "Fajr";
  //     prayerTime = nextDayPrayers!.fajr;
  //   } else {
  //     if (nextPrayer == Prayer.sunrise) {
  //       nextPrayer = Prayer.dhuhr;
  //     }

  //     switch (nextPrayer) {
  //       case Prayer.fajr:
  //         prayerName = "Fajr";
  //         prayerTime = prayers.fajr;
  //       case Prayer.dhuhr:
  //         prayerName = "Dhuhr";
  //         prayerTime = prayers.dhuhr;
  //       case Prayer.asr:
  //         prayerName = "Asr";
  //         prayerTime = prayers.asr;
  //       case Prayer.maghrib:
  //         prayerName = "Maghrib";
  //         prayerTime = prayers.maghrib;
  //       case Prayer.isha:
  //         prayerName = "Isha";
  //         prayerTime = prayers.isha;
  //       case Prayer.sunrise:
  //         prayerName = "Sunrise";
  //         prayerTime = prayers.sunrise;
  //       default:
  //         throw FormatException('Invalid Date/Time');
  //     }
  //   }

  //   return (prayerName, prayerTime);
  // }

  // static Future<(String, DateTime)> getCurrentPrayer(PrayerTimes prayers, DateTime currentDateTime) async {
  //   String? prayerName;
  //   DateTime? prayerTime;

  //   var currentPrayer = prayers.currentPrayerByDateTime(currentDateTime);

  //   switch (currentPrayer) {
  //     case Prayer.sunrise:
  //     case Prayer.fajr:
  //       prayerName = "Fajr";
  //       prayerTime = prayers.fajr;
  //     case Prayer.dhuhr:
  //       prayerName = "Dhuhr";
  //       prayerTime = prayers.dhuhr;
  //     case Prayer.asr:
  //       prayerName = "Asr";
  //       prayerTime = prayers.asr;
  //     case Prayer.maghrib:
  //       prayerName = "Maghrib";
  //       prayerTime = prayers.maghrib;
  //     case Prayer.isha:
  //       prayerName = "Isha";
  //       prayerTime = prayers.isha;
  //     default:
  //       prayerName = "None";
  //       prayerTime = DateTime(2000, 1, 1);
  //   }

  //   return (prayerName, prayerTime);
  // }
}
