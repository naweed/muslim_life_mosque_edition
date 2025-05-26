import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/error_indicator.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/loading_indicator.dart';
import 'package:muslim_life_mosque_edition/ViewControls/start_page/prayer_display_cell.dart';
import 'package:muslim_life_mosque_edition/ViewModels/start_page_view_model.dart';
import 'package:stacked/stacked.dart';

class StartPage extends StackedView<StartPageViewModel> {
  late StartPageViewModel pageViewModel;

  int itemHorizontalSpacerUnit = 16;
  int itemVerticalSpacerUnit = 24;
  double itemHorizontalPaddingUnit = 32.0;
  double itemVerticalPaddingUnit = 16.0;

  StartPage({super.key});

  @override
  StartPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = StartPageViewModel();
    pageViewModel.screenContext = context;
    return pageViewModel;
  }

  @override
  void onViewModelReady(StartPageViewModel viewModel) async {
    await viewModel.loadData();
  }

  @override
  Widget builder(BuildContext context, StartPageViewModel viewModel, Widget? child) =>
      Scaffold(backgroundColor: AppColors.StartPageBackgroundColor, body: _mainContentArea(context, viewModel));

  Widget _mainContentArea(BuildContext context, StartPageViewModel viewModel) {
    //Show Error Indicator
    if (viewModel.IsErrorState) {
      return ErrorIndicator(errorText: viewModel.ErrorMessage);
    }

    //Show Loading Indicator
    if (viewModel.IsBusy) {
      return LoadingIndicator(indicatorColor: AppColors.LightIndicatorColor);
    }

    //Return empty container if data has not yet been loaded
    if (!viewModel.DataLoaded) {
      return Container();
    }

    //Return Main Content
    return LayoutGrid(
      columnSizes: [
        //Left Spacer
        itemHorizontalPaddingUnit.px,
        //Main Content Area
        1.fr,
        //Right Spacer
        itemHorizontalPaddingUnit.px,
      ],
      rowSizes: [
        //Top Spacer
        itemVerticalPaddingUnit.px,
        //Mosque Name and Current Time Area
        auto,
        //Spacer
        itemVerticalSpacerUnit.px,
        //Prayer Information Area
        1.fr,
        //Spacer
        itemVerticalSpacerUnit.px,
        //Current Date Area
        auto,
        //Spacer
        itemVerticalSpacerUnit.px,
        //Prayers List Area
        auto,
        //Spacer
        itemVerticalSpacerUnit.px,
        //Quran Ayah and App Information Area
        auto,
        //Bottom Spacer
        itemVerticalPaddingUnit.px,
      ],
      children: [
        //Mosqe Name and Current Time Area
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Mosque Name
            Text(viewModel.mosque.mosqueName!, style: AppStyles.YellowExtraBold40TextStyle),
            //Time
            Text(viewModel.CurrentTime, style: AppStyles.ClockTextStyle),
          ],
        ).withGridPlacement(columnStart: 1, rowStart: 1),

        //Quran Ayah and App Information Area
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Quran Ayah
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\"Indeed, prayer has been decreed upon the believers at specified times.\"",
                  style: AppStyles.YellowMedium6TextStyle,
                ),
                Text(" - Sura An-Nisa (4:103)", style: AppStyles.RegularLight16TextStyle),
              ],
            ),

            //App Info
            Text(
              "Masjid Pulse TV v1.0  |  Prayer times for ${viewModel.mosque.addressCity}, ${viewModel.mosque.addressCountryName}",
              style: AppStyles.RegularLight14TextStyle,
            ),
          ],
        ).withGridPlacement(columnStart: 1, rowStart: 9),

        //Current Date Area
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Gregorian Date
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(viewModel.CurrentDateGregorian, style: AppStyles.MediumLight20TextStyle)],
            ),

            //Hijri Date
            Text(viewModel.CurrentDateHijri, style: AppStyles.MediumLight16TextStyle),
          ],
        ).withGridPlacement(columnStart: 1, rowStart: 5),

        //Prayers List Area
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Fajr
            PrayerDisplayCell(
              prayerName: viewModel.AllPrayerTimes[0].prayerName,
              prayerTime: viewModel.AllPrayerTimes[0].prayerTimeDisplay,
              isCurrent: viewModel.AllPrayerTimes[0].isCurrent,
              isNext: viewModel.AllPrayerTimes[0].isNext,
              iqamaTime: viewModel.AllPrayerTimes[0].iqamaTimeDisplay,
            ),

            //Sunrise
            PrayerDisplayCell(
              prayerName: viewModel.AllPrayerTimes[5].prayerName,
              prayerTime: viewModel.AllPrayerTimes[5].prayerTimeDisplay,
              isCurrent: viewModel.AllPrayerTimes[5].isCurrent,
              isNext: viewModel.AllPrayerTimes[5].isNext,
              iqamaTime: "N/A",
            ),

            //Dhuhr
            PrayerDisplayCell(
              prayerName: viewModel.AllPrayerTimes[1].prayerName,
              prayerTime: viewModel.AllPrayerTimes[1].prayerTimeDisplay,
              isCurrent: viewModel.AllPrayerTimes[1].isCurrent,
              isNext: viewModel.AllPrayerTimes[1].isNext,
              iqamaTime: viewModel.AllPrayerTimes[1].iqamaTimeDisplay,
            ),

            //Asr
            PrayerDisplayCell(
              prayerName: viewModel.AllPrayerTimes[2].prayerName,
              prayerTime: viewModel.AllPrayerTimes[2].prayerTimeDisplay,
              isCurrent: viewModel.AllPrayerTimes[2].isCurrent,
              isNext: viewModel.AllPrayerTimes[2].isNext,
              iqamaTime: viewModel.AllPrayerTimes[2].iqamaTimeDisplay,
            ),

            //Maghrib
            PrayerDisplayCell(
              prayerName: viewModel.AllPrayerTimes[3].prayerName,
              prayerTime: viewModel.AllPrayerTimes[3].prayerTimeDisplay,
              isCurrent: viewModel.AllPrayerTimes[3].isCurrent,
              isNext: viewModel.AllPrayerTimes[3].isNext,
              iqamaTime: viewModel.AllPrayerTimes[3].iqamaTimeDisplay,
            ),

            //Isha
            PrayerDisplayCell(
              prayerName: viewModel.AllPrayerTimes[4].prayerName,
              prayerTime: viewModel.AllPrayerTimes[4].prayerTimeDisplay,
              isCurrent: viewModel.AllPrayerTimes[4].isCurrent,
              isNext: viewModel.AllPrayerTimes[4].isNext,
              iqamaTime: viewModel.AllPrayerTimes[4].iqamaTimeDisplay,
            ),
          ],
        ).withGridPlacement(columnStart: 1, rowStart: 7),
      ],
    );
  }
}
