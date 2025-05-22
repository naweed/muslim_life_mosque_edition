import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_styles.dart';
import 'package:muslimlife/ViewModels/start_page_view_model.dart';
import 'package:stacked/stacked.dart';

class StartPage extends StackedView<StartPageViewModel> {
  late StartPageViewModel pageViewModel;

  StartPage({super.key});

  @override
  StartPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = StartPageViewModel();
    return pageViewModel;
  }

  @override
  void onViewModelReady(StartPageViewModel viewModel) async {
    await viewModel.loadData();
  }

  @override
  Widget builder(BuildContext context, StartPageViewModel viewModel, Widget? child) => Scaffold(
    backgroundColor: AppColors.PageBackgroundColor,
    body: IndexedStack(index: viewModel.currentIndex, children: viewModel.pages),
    bottomNavigationBar: Container(
      height: Platform.isIOS ? 84 : 70,
      color: Colors.white,
      child: Wrap(
        children: [
          BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.white,
            onTap: (index) => viewModel.onIndexChanged(index),
            type: BottomNavigationBarType.fixed,
            fixedColor: AppColors.AppPrimaryColor,
            unselectedItemColor: AppColors.DarkTextColor,
            unselectedLabelStyle: AppStyles.UnselectedTabLabelStyle,
            selectedLabelStyle: AppStyles.SelectedTabLabelStyle,
            currentIndex: viewModel.currentIndex,
            items: viewModel.navBarItems,
          ).withLTRBPadding(8, 0, 8, Platform.isIOS ? 0 : 4),
        ],
      ),
    ),
  );
}
