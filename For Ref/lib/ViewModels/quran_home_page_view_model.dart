import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:muslimlife/Events/sura_reading_event.dart';
import 'package:muslimlife/Framework/Extensions/navigation_extentions.dart';
import 'package:muslimlife/Models/quran_models.dart';
import 'package:muslimlife/Shared/app_session.dart';
import 'package:muslimlife/ViewModels/app_view_model.dart';
import 'package:muslimlife/Views/arabic_sura_page.dart';
import 'package:muslimlife/Views/sura_page.dart';

class QuranHomePageViewModel extends AppViewModel {
  final EventBus eventBus;

  String ReadingHeader = "Start Reading";
  int SuraNoToRead = 0;
  Sura SuraToRead = Sura();

  List<Sura> Suras = [];

  QuranHomePageViewModel(this.eventBus) : super() {
    this.Title = "Quran Al-Kareem";

    //Listen to SuraReadingEvent
    eventBus.on<SuraReadingEvent>().listen((event) async {
      //Sura Header Info
      _getSuraToReadInfo();

      //Read Suras Info Update
      await _updateReadSuraInfo();

      rebuildUi();
    });
  }

  Future<void> loadData() async {
    //Load Suras List
    Suras = await appDataService.getAllSuras();

    //Sura Header Info
    _getSuraToReadInfo();

    //Read Suras Info Update
    await _updateReadSuraInfo();

    DataLoaded = true;
    rebuildUi();
  }

  void _getSuraToReadInfo() {
    if (AppSession.ReadSuraNo! != 0) {
      ReadingHeader = "Continue Reading";
    } else {
      ReadingHeader = "Start Reading";
    }

    SuraNoToRead = AppSession.ReadSuraNo! == 0 ? 1 : AppSession.ReadSuraNo!;
    SuraToRead = Suras.where((s) => s.suraNo == SuraNoToRead).first;
  }

  Future<void> _updateReadSuraInfo() async {
    var completedSuras = await appDatabaseService.getAllComplatedSuras();

    for (var sura in Suras) {
      sura.isCompleted = completedSuras.any((x) => (x.suraNo == sura.suraNo));
    }
  }

  Future<void> navigateToSuraPage(BuildContext context, Sura sura) async {
    if (AppSession.ContinuousQuranReading) {
      context.push(ArabicSuraPage(eventBus, sura));
    } else {
      context.push(SuraPage(eventBus, sura));
    }
  }
}
