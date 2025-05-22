import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslimlife/Events/page_index_evet.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Shared/app_assets.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_constants.dart';
import 'package:muslimlife/ViewModels/app_view_model.dart';
import 'package:muslimlife/Views/goals_page.dart';
import 'package:muslimlife/Views/home_page.dart';
import 'package:muslimlife/Views/qibla_direction_page.dart';
import 'package:muslimlife/Views/quran_home_page.dart';
import 'package:muslimlife/Views/settings_page.dart';

class StartPageViewModel extends AppViewModel {
  List<Widget> pages = [];
  List<BottomNavigationBarItem> navBarItems = [];
  int currentIndex = 0;
  double iconHeight = 20;
  EventBus eventBus = EventBus();

  StartPageViewModel() : super() {
    this.Title = AppConstants.ApplicationName;

    pages = [
      HomePage(eventBus),
      QuranHomePage(eventBus),
      QiblaDirectionPage(eventBus),
      GoalsPage(eventBus),
      SettingsPage(eventBus),
    ];

    navBarItems = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppAssets.HomeHomeIcon,
          height: iconHeight,
          colorFilter: ColorFilter.mode(AppColors.DarkGrayColor, BlendMode.srcIn),
        ).withLTRBPadding(0, 8, 0, 4),
        label: "Home",
        activeIcon: SvgPicture.asset(
          AppAssets.HomeHomeIcon,
          height: iconHeight,
          colorFilter: ColorFilter.mode(AppColors.AppPrimaryColor, BlendMode.srcIn),
        ).withLTRBPadding(0, 8, 0, 4),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppAssets.HomeQuranIcon,
          height: iconHeight,
          colorFilter: ColorFilter.mode(AppColors.DarkGrayColor, BlendMode.srcIn),
        ).withLTRBPadding(0, 8, 0, 4),
        label: "Quran",
        activeIcon: SvgPicture.asset(
          AppAssets.HomeQuranIcon,
          height: iconHeight,
          colorFilter: ColorFilter.mode(AppColors.AppPrimaryColor, BlendMode.srcIn),
        ).withLTRBPadding(0, 8, 0, 4),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppAssets.HomeQiblaIcon,
          height: iconHeight,
          colorFilter: ColorFilter.mode(AppColors.DarkGrayColor, BlendMode.srcIn),
        ).withLTRBPadding(0, 8, 0, 4),
        label: "Qibla",
        activeIcon: SvgPicture.asset(
          AppAssets.HomeQiblaIcon,
          height: iconHeight,
          colorFilter: ColorFilter.mode(AppColors.AppPrimaryColor, BlendMode.srcIn),
        ).withLTRBPadding(0, 8, 0, 4),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppAssets.HomeTrendsIcon,
          height: iconHeight,
          colorFilter: ColorFilter.mode(AppColors.DarkGrayColor, BlendMode.srcIn),
        ).withLTRBPadding(0, 8, 0, 4),
        label: "Stats",
        activeIcon: SvgPicture.asset(
          AppAssets.HomeTrendsIcon,
          height: iconHeight,
          colorFilter: ColorFilter.mode(AppColors.AppPrimaryColor, BlendMode.srcIn),
        ).withLTRBPadding(0, 8, 0, 4),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppAssets.HomeSettingsIcon,
          height: iconHeight,
          colorFilter: ColorFilter.mode(AppColors.DarkGrayColor, BlendMode.srcIn),
        ).withLTRBPadding(0, 8, 0, 4),
        label: "Settings",
        activeIcon: SvgPicture.asset(
          AppAssets.HomeSettingsIcon,
          height: iconHeight,
          colorFilter: ColorFilter.mode(AppColors.AppPrimaryColor, BlendMode.srcIn),
        ).withLTRBPadding(0, 8, 0, 4),
      ),
    ];
  }

  Future<void> loadData() async {}

  void onIndexChanged(int newIndex) {
    currentIndex = newIndex;
    rebuildUi();

    //Fire Event
    eventBus.fire(PageIndexEvent(newIndex));
  }
}
