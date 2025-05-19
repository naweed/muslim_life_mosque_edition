import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class MosqueCodeSelectionPageViewModel extends AppViewModel {
  late BuildContext screenContext;
  final FocusNode continueButtonFocus = FocusNode();
  final List<FocusNode> otpFocusNodes = List.generate(5, (_) => FocusNode());
  final List<TextEditingController> otpControllers = List.generate(5, (_) => TextEditingController());

  String Description =
      "Please input the 5 digit unique code for your mosque. This code is available under the Mosque Name in the Masjid Pulse Portal.";

  String ButtonText = "Continue";

  bool isButtonEnabled = true;

  MosqueCodeSelectionPageViewModel() : super() {
    this.Title = "Register your Mosque!";
  }

  void requestFocus() async {
    // Focus the first OTP field initially
    FocusScope.of(screenContext).requestFocus(otpFocusNodes[0]);
  }

  void moveToNextField(int currentIndex) {
    if (currentIndex < 4) {
      // Move to next OTP field
      FocusScope.of(screenContext).requestFocus(otpFocusNodes[currentIndex + 1]);
    } else {
      // Move to continue button on last field
      FocusScope.of(screenContext).requestFocus(continueButtonFocus);
    }
  }

  Future<void> saveMosquCodeSelectionStatus() async {
    await appSettingsService.saveMosqueCodeSelectionCompleted();
  }

  @override
  void dispose() {
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    for (var controller in otpControllers) {
      controller.dispose();
    }
    continueButtonFocus.dispose();
    super.dispose();
  }
}
