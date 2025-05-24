import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Services/app_api_service.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class StartPageViewModel extends AppViewModel {
  late BuildContext screenContext;

  StartPageViewModel() : super() {
    this.Title = "Prayer Times";

    appApiService = AppApiService();
  }
}
