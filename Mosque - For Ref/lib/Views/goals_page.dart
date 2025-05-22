import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslimlife/Framework/Extensions/widget_extensions.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_styles.dart';
import 'package:muslimlife/ViewControls/Shared/app_frame.dart';
import 'package:muslimlife/ViewControls/goals_page/prayer_stats_cell.dart';
import 'package:muslimlife/ViewModels/goals_page_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:fl_chart/fl_chart.dart';

class GoalsPage extends StackedView<GoalsPageViewModel> {
  late GoalsPageViewModel pageViewModel;
  final EventBus eventBus;

  GoalsPage(this.eventBus, {super.key});

  @override
  GoalsPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = GoalsPageViewModel(eventBus);
    return pageViewModel;
  }

  @override
  void onViewModelReady(GoalsPageViewModel viewModel) async {
    await viewModel.loadData();
  }

  @override
  Widget builder(BuildContext context, GoalsPageViewModel viewModel, Widget? child) => AppFrame(
    isErrorState: viewModel.IsErrorState,
    errorMessage: viewModel.ErrorMessage,
    isBusy: viewModel.IsBusy,
    loadingText: viewModel.LoadingText,
    dataLoaded: viewModel.DataLoaded,
    child: _mainContentArea(context, viewModel),
  );

  Widget _mainContentArea(BuildContext context, GoalsPageViewModel viewModel) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        //Page Header
        SliverAppBar(
          backgroundColor: AppColors.AppPrimaryColor,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          pinned: true,
          centerTitle: true,
          title: Text(viewModel.Title, style: AppStyles.BoldLight22TextStyle),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(28),
            child: Container(
              height: 20.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.PageBackgroundColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: (16, 0).withSymetricPadding(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Todays Goals
                _todaysGoals(context, viewModel),

                //Spacer
                12.toVerticalSpacer(),

                //Total, This Month and This Year Goals
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Total Stats
                    PrayerStatsCell(
                      isDark: true,
                      text: "Total*\nPrayers",
                      prayerCount: viewModel.TotalPrayedAll,
                      totalPrayerCount: viewModel.TotalPrayersAll,
                    ).expandWidget(),

                    //Spacer
                    12.toHorizontalSpacer(),

                    //This Month Stats
                    PrayerStatsCell(
                      isDark: false,
                      text: "This\nMonth",
                      prayerCount: viewModel.TotalPrayedThisMonth,
                      totalPrayerCount: viewModel.TotalPrayersThisMonth,
                    ).expandWidget(),

                    //Spacer
                    12.toHorizontalSpacer(),

                    //This Year Stats
                    PrayerStatsCell(
                      isDark: false,
                      text: "This\nYear",
                      prayerCount: viewModel.TotalPrayedThisYear,
                      totalPrayerCount: viewModel.TotalPrayersThisYear,
                    ).expandWidget(),
                  ],
                ),

                //Spacer
                12.toVerticalSpacer(),

                //Seven Day Goals
                _sevenDayGoals(context, viewModel),

                //Spacer
                12.toVerticalSpacer(),

                //Disclaimer
                Text(
                  "* Since ${DateFormat('MMM dd, yyyy').format(viewModel.FirstPrayerDate!)}",
                  style: AppStyles.BoldDark12TextStyle,
                ),

                //Final Spacer
                24.toVerticalSpacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _todaysGoals(BuildContext context, GoalsPageViewModel viewModel) => Container(
    width: double.infinity,
    //height: 200,
    padding: (24, 16).withSymetricPadding(),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(12),
      //border: Border.all(color: AppColors.AppPrimaryColor.withValues(alpha: 0.6), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Header
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your prayers\nfor today", style: AppStyles.BoldDark18TextStyle, textAlign: TextAlign.center),

            //Spacer
            10.toVerticalSpacer(),

            Text(
              "${viewModel.TodaysPrayerCount} of 5 completed",
              style: AppStyles.RegularDark14TextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),

        //Progress
        DashedCircularProgressBar.square(
          dimensions: 120,
          progress: (360.0 * viewModel.TodaysPrayerCount.toDouble()) / 5.0,
          maxProgress: 360,
          startAngle: -180,
          foregroundColor: AppColors.AppPrimaryColor,
          backgroundColor: Colors.grey.withValues(alpha: 0.5),
          foregroundStrokeWidth: 9,
          backgroundStrokeWidth: 5,
          foregroundGapSize: 13,
          foregroundDashSize: 59,
          backgroundGapSize: 13,
          backgroundDashSize: 59,
          animation: false,
          child: Center(
            child: Text("${viewModel.TodaysPrayerCount * 100 ~/ 5}%", style: AppStyles.BoldDark22TextStyle),
          ),
        ),
      ],
    ),
  );

  Widget _sevenDayGoals(BuildContext context, GoalsPageViewModel viewModel) => Container(
    width: double.infinity,
    //height: 200,
    padding: (24, 24, 24, 16).withLTRBPadding(),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(12),
      //border: Border.all(color: AppColors.AppPrimaryColor.withValues(alpha: 0.6), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Progress
        SizedBox(height: 140, child: BarChart(_sevenDaysData())),

        //Spacer
        12.toVerticalSpacer(),

        Text("Last 7 Days", style: AppStyles.BoldDark18TextStyle, textAlign: TextAlign.center),
      ],
    ),
  );

  Widget _getSevenDaysTitles(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Fajr', style: AppStyles.MediumDark12TextStyle);
        break;
      case 1:
        text = const Text('Dhuhr', style: AppStyles.MediumDark12TextStyle);
        break;
      case 2:
        text = const Text('Asr', style: AppStyles.MediumDark12TextStyle);
        break;
      case 3:
        text = const Text('Maghrib', style: AppStyles.MediumDark12TextStyle);
        break;
      case 4:
        text = const Text('Isha', style: AppStyles.MediumDark12TextStyle);
        break;
      default:
        text = const Text('', style: AppStyles.MediumDark12TextStyle);
        break;
    }
    return SideTitleWidget(
      space: 8,
      meta: meta,
      //TitleMeta(min: min, max: max, parentAxisSize: parentAxisSize, axisPosition: axisPosition, appliedInterval: appliedInterval, sideTitles: sideTitles, formattedValue: formattedValue, axisSide: meta.axisSide, rotationQuarterTurns: rotationQuarterTurns),
      child: text,
    );
  }

  BarChartData _sevenDaysData() {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, getTitlesWidget: _sevenDaysRightTitles, interval: 1),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, getTitlesWidget: _getSevenDaysTitles, reservedSize: 24),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      barGroups: _showSevenDayGroups(),
      gridData: const FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 1),
      alignment: BarChartAlignment.spaceAround,
    );
  }

  List<BarChartGroupData> _showSevenDayGroups() => List.generate(5, (i) {
    switch (i) {
      case 0:
        return _makeGroupData(
          0,
          pageViewModel.Last7DaysPrayers.where((p) => p.PrayerName == "Fajr").first.PrayerCount.toDouble(),
        );
      case 1:
        return _makeGroupData(
          1,
          pageViewModel.Last7DaysPrayers.where((p) => p.PrayerName == "Dhuhr").first.PrayerCount.toDouble(),
        );
      case 2:
        return _makeGroupData(
          2,
          pageViewModel.Last7DaysPrayers.where((p) => p.PrayerName == "Asr").first.PrayerCount.toDouble(),
        );
      case 3:
        return _makeGroupData(
          3,
          pageViewModel.Last7DaysPrayers.where((p) => p.PrayerName == "Maghrib").first.PrayerCount.toDouble(),
        );
      case 4:
        return _makeGroupData(
          4,
          pageViewModel.Last7DaysPrayers.where((p) => p.PrayerName == "Isha").first.PrayerCount.toDouble(),
        );
      default:
        return throw Error();
    }
  });

  BarChartGroupData _makeGroupData(int x, double y) {
    Color barColor = AppColors.AppPrimaryColor;
    Color barBackgroundColor = Colors.grey.withValues(alpha: 0.5);

    // switch (y.toInt()) {
    //   case 1:
    //     barColor = AppColors.AppPrimaryColor.withValues(red: 1);
    //     break;
    //   case 2:
    //     barColor = AppColors.AppPrimaryColor.withValues(red: 0.8);
    //     break;
    //   case 3:
    //     barColor = AppColors.AppPrimaryColor.withValues(red: 0.6);
    //     break;
    //   case 4:
    //     barColor = AppColors.AppPrimaryColor.withValues(red: 0.4);
    //     break;
    //   case 5:
    //     barColor = AppColors.AppPrimaryColor.withValues(red: 0.2);
    //     break;
    //   case 6:
    //     barColor = AppColors.AppPrimaryColor.withValues(red: 0.1);
    //     break;
    //   default:
    //     break;
    // }

    return BarChartGroupData(
      x: x,
      //showingTooltipIndicators: [0],
      barRods: [
        BarChartRodData(
          toY: y,
          color: barColor,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          width: 24,
          backDrawRodData: BackgroundBarChartRodData(show: true, toY: 7, color: barBackgroundColor),
        ),
      ],
    );
  }

  Widget _sevenDaysRightTitles(double value, TitleMeta meta) {
    String text;
    text = '${value.toInt()}';

    return SideTitleWidget(meta: meta, space: 6, child: Text(text, style: AppStyles.MediumDark10TextStyle));
  }
}
