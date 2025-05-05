import 'package:event_bus/event_bus.dart';
import 'package:muslimlife/Events/prayer_setting_event.dart';
import 'package:muslimlife/Shared/app_session.dart';
import 'package:muslimlife/ViewModels/app_view_model.dart';

class SettingsPageViewModel extends AppViewModel {
  final EventBus eventBus;
  String prayerCalcMethod = AppSession.PrayerCalculationMethod!;
  String asrCalcMethod = AppSession.AsrCalculationMethod!;
  int fajrAdjustment = AppSession.FajrAdjustment!;
  int dhuhrAdjustment = AppSession.DhuhrAdjustment!;
  int asrAdjustment = AppSession.AsrAdjustment!;
  int maghribAdjustment = AppSession.MaghribAdjustment!;
  int ishaAdjustment = AppSession.IshaAdjustment!;
  int sunriseAdjustment = AppSession.SunriseAdjustment!;
  bool showTranslation = AppSession.ShowTranslation;
  bool showTransliteration = AppSession.ShowTransliteration;
  bool continuousQuranReading = AppSession.ContinuousQuranReading;

  int quranFontSize = AppSession.QuranFontSize!;
  int translationFontSize = AppSession.TranslationFontSize!;
  int transliterationFontSize = AppSession.TransliterationFontSize!;

  String ManualPrayerAdjustments = "";
  String FontSizes = "";

  SettingsPageViewModel(this.eventBus) : super() {
    Title = "Settings";
    ManualPrayerAdjustments = getManualPrayerAdjustments();
    FontSizes = getFontSizes();
  }

  Future<void> loadData() async {
    DataLoaded = true;
    rebuildUi();
  }

  String getManualPrayerAdjustments() =>
      "F: $fajrAdjustment, SR: $sunriseAdjustment, D: $dhuhrAdjustment, A: $asrAdjustment, M: $maghribAdjustment, I: $ishaAdjustment";

  String getFontSizes() =>
      "Ayah: $quranFontSize, Translation: $translationFontSize, Transliteration: $transliterationFontSize";

  Future<void> setSelectedAsrCalcMethod(String newAsrCalcMethod) async {
    asrCalcMethod = newAsrCalcMethod;

    await appSettingsService.saveMyAsrCalcMethod(asrCalcMethod);
    AppSession.AsrCalculationMethod = asrCalcMethod;

    rebuildUi();

    //Fire the event to notify the Prayers Home Page
    eventBus.fire(PrayerSettingEvent());
  }

  Future<void> setSelectedPrayerCalcMethod(String newPrayerCalcMethod) async {
    prayerCalcMethod = newPrayerCalcMethod;

    await appSettingsService.saveMyPrayerCalcMethod(prayerCalcMethod);
    AppSession.PrayerCalculationMethod = prayerCalcMethod;

    rebuildUi();

    //Fire the event to notify the Prayers Home Page
    eventBus.fire(PrayerSettingEvent());
  }

  Future<void> setFajrAdjustment(int newValue) async {
    fajrAdjustment = newValue;
    ManualPrayerAdjustments = getManualPrayerAdjustments();

    await appSettingsService.saveMyFajrAdjustment(fajrAdjustment);
    AppSession.FajrAdjustment = fajrAdjustment;

    rebuildUi();

    //Fire the event to notify the Prayers Home Page
    eventBus.fire(PrayerSettingEvent());
  }

  Future<void> setDhuhrAdjustment(int newValue) async {
    dhuhrAdjustment = newValue;
    ManualPrayerAdjustments = getManualPrayerAdjustments();

    await appSettingsService.saveMyDhuhrAdjustment(dhuhrAdjustment);
    AppSession.DhuhrAdjustment = dhuhrAdjustment;

    rebuildUi();

    //Fire the event to notify the Prayers Home Page
    eventBus.fire(PrayerSettingEvent());
  }

  Future<void> setAsrAdjustment(int newValue) async {
    asrAdjustment = newValue;
    ManualPrayerAdjustments = getManualPrayerAdjustments();

    await appSettingsService.saveMyAsrAdjustment(asrAdjustment);
    AppSession.AsrAdjustment = asrAdjustment;

    rebuildUi();

    //Fire the event to notify the Prayers Home Page
    eventBus.fire(PrayerSettingEvent());
  }

  Future<void> setMaghribAdjustment(int newValue) async {
    maghribAdjustment = newValue;
    ManualPrayerAdjustments = getManualPrayerAdjustments();

    await appSettingsService.saveMyMaghribAdjustment(maghribAdjustment);
    AppSession.MaghribAdjustment = maghribAdjustment;

    rebuildUi();

    //Fire the event to notify the Prayers Home Page
    eventBus.fire(PrayerSettingEvent());
  }

  Future<void> setIshaAdjustment(int newValue) async {
    ishaAdjustment = newValue;
    ManualPrayerAdjustments = getManualPrayerAdjustments();

    await appSettingsService.saveMyIshaAdjustment(ishaAdjustment);
    AppSession.IshaAdjustment = ishaAdjustment;

    rebuildUi();

    //Fire the event to notify the Prayers Home Page
    eventBus.fire(PrayerSettingEvent());
  }

  Future<void> setSunriseAdjustment(int newValue) async {
    sunriseAdjustment = newValue;
    ManualPrayerAdjustments = getManualPrayerAdjustments();

    await appSettingsService.saveMySunriseAdjustment(sunriseAdjustment);
    AppSession.SunriseAdjustment = sunriseAdjustment;

    rebuildUi();

    //Fire the event to notify the Prayers Home Page
    eventBus.fire(PrayerSettingEvent());
  }

  Future<void> setShowTranslationFlag(bool value) async {
    showTranslation = value;

    await appSettingsService.saveShowTranslation(value);
    AppSession.ShowTranslation = value;

    rebuildUi();
  }

  Future<void> setShowTransliterationFlag(bool value) async {
    showTransliteration = value;

    await appSettingsService.saveShowTransliteration(value);
    AppSession.ShowTransliteration = value;

    rebuildUi();
  }

  Future<void> setQuranFontSize(int newValue) async {
    quranFontSize = newValue;
    FontSizes = getFontSizes();

    await appSettingsService.saveQuranFontSize(quranFontSize);
    AppSession.QuranFontSize = quranFontSize;

    rebuildUi();
  }

  Future<void> setTranslationFontSize(int newValue) async {
    translationFontSize = newValue;
    FontSizes = getFontSizes();

    await appSettingsService.saveTranslationFontSize(translationFontSize);
    AppSession.TranslationFontSize = translationFontSize;

    rebuildUi();
  }

  Future<void> setTransliterationFontSize(int newValue) async {
    transliterationFontSize = newValue;
    FontSizes = getFontSizes();

    await appSettingsService.saveTransliterationFontSize(transliterationFontSize);
    AppSession.TransliterationFontSize = transliterationFontSize;

    rebuildUi();
  }

  Future<void> setContinuousQuranReadingFlag(bool value) async {
    continuousQuranReading = value;

    await appSettingsService.saveContinuousQuranReading(value);
    AppSession.ContinuousQuranReading = value;

    rebuildUi();
  }
}
