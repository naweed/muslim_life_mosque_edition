import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class MosqueCodeSelectionPageViewModel extends AppViewModel {
  late BuildContext screenContext;
  final FocusNode continueButtonFocus = FocusNode();

  String Description =
      "Please input the 5 digit unique code for your mosque. This code is available under the Mosque Name in the Masjid Pulse Portal.";

  String ButtonText = "Continue";

  bool isButtonEnabled = true;

  MosqueCodeSelectionPageViewModel() : super() {
    this.Title = "Register your Mosque!";
  }

  void requestFocus() async {
    FocusScope.of(screenContext).requestFocus(continueButtonFocus);
  }

  Future<void> saveMosquCodeSelectionStatus() async {
    await appSettingsService.saveMosqueCodeSelectionCompleted();
  }
}
