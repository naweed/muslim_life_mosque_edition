import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/navigation_extentions.dart';
import 'package:muslim_life_mosque_edition/Framework/Helpers/toast_helpers.dart';
import 'package:muslim_life_mosque_edition/Services/app_api_service.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';
import 'package:muslim_life_mosque_edition/Views/start_page.dart';

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

    appApiService = AppApiService();
  }

  void requestFocus({int index = 0}) async {
    // Focus the first OTP field initially
    FocusScope.of(screenContext).requestFocus(otpFocusNodes[index]);

    rebuildUi();
  }

  void moveToNextField(int currentIndex) {
    if (currentIndex < 4) {
      // Move to next OTP field
      FocusScope.of(screenContext).requestFocus(otpFocusNodes[currentIndex + 1]);
    } else {
      // Move to continue button on last field
      FocusScope.of(screenContext).requestFocus(continueButtonFocus);
    }

    rebuildUi();
  }

  void handleOtpInput(String value, int index) {
    if (value.isNotEmpty) {
      // Ensure the value is uppercase
      otpControllers[index].text = value.toUpperCase();
      // Move focus to next field
      moveToNextField(index);
    }
  }

  Future<void> continueWithMosqueCode() async {
    ButtonText = "Loading...";
    rebuildUi();

    //Get the code and check if it is 5 digits
    var mosqueCode =
        (otpControllers[0].text +
                otpControllers[1].text +
                otpControllers[2].text +
                otpControllers[3].text +
                otpControllers[4].text)
            .toUpperCase();

    if (mosqueCode.length != 5) {
      //Display error toast
      ToastHelpers.showVeryLongToast(
        screenContext,
        "Please enter the 5 digit Mosque code. You can get it from the Masjid Pulse Portal under your account.",
        isError: true,
      );

      ButtonText = "Continue";

      //Reset code boxes
      resetCodeBoxes();

      //Reset Focus to first box
      requestFocus();

      return;
    }

    try {
      //Fetch the data
      var mosque = await appApiService.getMosqueDetails(mosqueCode);

      ToastHelpers.showVeryLongToast(screenContext, "${mosque.mosqueName!} loaded successfully!", isError: false);

      //Save Mosque Code Status
      await appSettingsService.saveMosqueCode(mosqueCode);
      await appSettingsService.saveMosqueCodeSelectionCompleted();

      //Redirect to Start Page
      await screenContext.pushReplacement(StartPage());
    } on Exception catch (ex) {
      ToastHelpers.showVeryLongToast(screenContext, ex.toString(), isError: true);

      ButtonText = "Continue";

      //Reset code boxes
      resetCodeBoxes();

      //Reset Focus to first box
      requestFocus();
    }
  }

  void resetCodeBoxes() {
    otpControllers[0].text = "";
    otpControllers[1].text = "";
    otpControllers[2].text = "";
    otpControllers[3].text = "";
    otpControllers[4].text = "";
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
