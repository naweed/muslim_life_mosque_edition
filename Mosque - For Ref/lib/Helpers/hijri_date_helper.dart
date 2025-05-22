import 'package:muslimlife/HijriDateEngine/hijri_date.dart';

class HijriDateHelper {
  static (DateTime, String) getCurrentDates() {
    return getDates(DateTime.now());
  }

  static (DateTime, String) getDates(DateTime theDate) {
    var currentDateGregorian = theDate;
    var hijriDate = HijriDate(currentDateGregorian);
    return (currentDateGregorian, hijriDate.toString());
  }
}
