import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class LocationPermissionPageViewModel extends AppViewModel {
  late BuildContext screenContext;
  final FocusNode continueButtonFocus = FocusNode();

  String Description =
      "We need to know your location in order to find accurate prayer times. We promise that we will not use your location for any other purpose.";

  String ButtonText = "Continue";

  bool isButtonEnabled = true;

  LocationPermissionPageViewModel() : super() {
    this.Title = "Location Access!";
  }

  void requestFocus() async {
    FocusScope.of(screenContext).requestFocus(continueButtonFocus);
  }

  Future<void> saveMosquCodeSelectionStatus() async {
    await appSettingsService.saveMosqueCodeSelectionCompleted();
  }
}
