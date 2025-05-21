import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lehttp_overrides/lehttp_overrides.dart';
import 'package:muslim_life_mosque_edition/Services/app_settings_service.dart';
import 'package:muslim_life_mosque_edition/Shared/app_constants.dart';
import 'package:muslim_life_mosque_edition/Shared/app_session.dart';
import 'package:muslim_life_mosque_edition/Views/mosque_code_selection_page.dart';
import 'package:muslim_life_mosque_edition/Views/onboarding_page.dart';
import 'package:muslim_life_mosque_edition/Views/start_page.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appSettingsService = AppSettingService();
  //await appSettingsService.clearAllPreferences();

  await AppSession.setAppParameters(appSettingsService);

  //Override certificate
  HttpOverrides.global = LEHttpOverrides();

  //Enable Wakelock
  WakelockPlus.enable();

  //Run App
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        //color set to transperent or set your own color
        statusBarColor: Colors.transparent,
        //set brightness for icons, like dark background light icons
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.ApplicationName,
      theme: ThemeData.light().copyWith(visualDensity: VisualDensity.standard),
      home: AppSession.OnboadingCompleted
          ? (AppSession.MosqueCodeSelectionCompleted ? StartPage() : MosqueCodeSelectionPage())
          : OnboardingPage(),
    );
  }
}
