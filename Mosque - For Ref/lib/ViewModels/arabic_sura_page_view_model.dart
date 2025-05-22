import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:muslimlife/Events/sura_reading_event.dart';
import 'package:muslimlife/Framework/Extensions/navigation_extentions.dart';
import 'package:muslimlife/Framework/Helpers/toast_helpers.dart';
import 'package:muslimlife/Models/db_models.dart';
import 'package:muslimlife/Models/quran_models.dart';
import 'package:muslimlife/Shared/app_session.dart';
import 'package:muslimlife/ViewModels/app_view_model.dart';
import 'package:muslimlife/Views/arabic_sura_page.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class ArabicSuraPageViewModel extends AppViewModel {
  final EventBus eventBus;
  final Sura sura;

  late ScrollController scrollController;
  late ListController listController;

  ArabicSuraPageViewModel(this.eventBus, this.sura) : super() {
    this.Title = "Quran Al-Kareem";

    scrollController = ScrollController();
    listController = ListController();
  }

  Future<void> loadData() async {
    //Set Current Sura Page if needed
    if (sura.suraNo! != AppSession.ReadSuraNo!) {
      AppSession.ReadSuraNo = sura.suraNo!;
      AppSession.ReadAyahNo = 0;
      AppSession.ReadPageNo = 0;
      AppSession.ReadPageOffset = 0;

      await appSettingsService.saveMyQuranReadingStatus(sura.suraNo!, 0, 0, 0);

      eventBus.fire(SuraReadingEvent());
    }

    DataLoaded = true;
    rebuildUi();
  }

  Future<void> markSuraAsRead(BuildContext context) async {
    //Mark Sura as Read
    var completedSuras = await appDatabaseService.getAllComplatedSuras();
    if (!completedSuras.any((x) => (x.suraNo == sura.suraNo))) {
      var completedSura = CompletedSura(suraNo: sura.suraNo!);
      await appDatabaseService.insertSuraComlpted(completedSura);
    }

    var newCompletedSuras = await appDatabaseService.getAllComplatedSuras();

    if (completedSuras.length == 113 && newCompletedSuras.length == 114) {
      //Read complete Quran
      ToastHelpers.showVeryLongToast(context, "Masha'Allah, you have read full Quran!");
    }

    if (sura.suraNo! < 114) {
      //Navigate the next Sura page
      var allSuras = await appDataService.getAllSuras();

      var nextSura = allSuras.where((s) => s.suraNo == (sura.suraNo! + 1)).first;

      context.pushCurrentReplacement(ArabicSuraPage(eventBus, nextSura));
    } else {
      AppSession.ReadSuraNo = 0;
      AppSession.ReadAyahNo = 0;
      AppSession.ReadPageNo = 0;
      AppSession.ReadPageOffset = 0;

      await appSettingsService.saveMyQuranReadingStatus(0, 0, 0, 0);

      eventBus.fire(SuraReadingEvent());

      //Navigate to Home page
      context.popPage();
    }
  }

  Future<void> saveAyahNo(int ayahNo, double offSet) async {
    AppSession.ReadPageNo = ayahNo;
    AppSession.ReadPageOffset = offSet;

    await appSettingsService.saveMyQuranReadingStatus(sura.suraNo!, AppSession.ReadAyahNo!, ayahNo, offSet);
  }
}
