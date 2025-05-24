import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/ViewModels/start_page_view_model.dart';
import 'package:stacked/stacked.dart';

class StartPage extends StackedView<StartPageViewModel> {
  late StartPageViewModel pageViewModel;

  StartPage({super.key});

  @override
  StartPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = StartPageViewModel();
    pageViewModel.screenContext = context;
    return pageViewModel;
  }

  @override
  void onViewModelReady(StartPageViewModel viewModel) async {}

  @override
  Widget builder(BuildContext context, StartPageViewModel viewModel, Widget? child) => Scaffold(
    backgroundColor: AppColors.PageBackgroundColor,
    body: Stack(children: [Text("Hello")]),
  );
}
