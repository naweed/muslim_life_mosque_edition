import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:muslimlife/Framework/Extensions/navigation_extentions.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslimlife/Shared/app_assets.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_constants.dart';
import 'package:muslimlife/Shared/app_styles.dart';
import 'package:muslimlife/ViewControls/Shared/app_frame.dart';
import 'package:muslimlife/ViewControls/prayer_times/date_display_cell.dart';
import 'package:muslimlife/ViewControls/prayer_times/prayer_display_cell.dart';
import 'package:muslimlife/ViewModels/home_page_view_model.dart';
import 'package:muslimlife/Views/location_permissions_page.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StackedView<HomeTimesPageViewModel> {
  late HomeTimesPageViewModel pageViewModel;
  final EventBus eventBus;

  HomePage(this.eventBus, {super.key});

  @override
  HomeTimesPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = HomeTimesPageViewModel(eventBus);
    return pageViewModel;
  }

  @override
  void onViewModelReady(HomeTimesPageViewModel viewModel) async {
    await viewModel.loadData();
  }

  @override
  Widget builder(BuildContext context, HomeTimesPageViewModel viewModel, Widget? child) => AppFrame(
    isErrorState: viewModel.IsErrorState,
    errorMessage: viewModel.ErrorMessage,
    isBusy: viewModel.IsBusy,
    loadingText: viewModel.LoadingText,
    dataLoaded: viewModel.DataLoaded,
    child: _mainContentArea(context, viewModel),
  );

  Widget _mainContentArea(BuildContext context, HomeTimesPageViewModel viewModel) {
    return LiquidPullToRefresh(
      onRefresh: () async => await viewModel.loadData(),
      color: AppColors.AppPrimaryColor,
      height: 200,
      springAnimationDurationInMilliseconds: AppConstants.SmallDuration,
      animSpeedFactor: 3,
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          //Hero Bar
          _heroBar(context, viewModel),

          //Spacer
          4.toVerticalSliverSpacer(),

          //Other Options
          SliverToBoxAdapter(child: _prayerTimes(context, viewModel)),
        ],
      ),
    );
  }

  SliverAppBar _heroBar(BuildContext context, HomeTimesPageViewModel viewModel) {
    return SliverAppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      backgroundColor: AppColors.AppPrimaryColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      stretch: true,
      expandedHeight: 220,
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Dates
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.HomeCalendarIcon, height: 28),
              6.toHorizontalSpacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(viewModel.CurrentDateHijri, style: AppStyles.BoldLight13TextStyle),
                  Text(viewModel.CurrentDateGregorian, style: AppStyles.RegularLight11TextStyle),
                ],
              ),
            ],
          ),

          //Location
          GestureDetector(
            onTap: () => context.pushReplacement(LocationPermissionsPage()),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: Container(
                  padding: (12, 6).withSymetricPadding(),
                  color: AppColors.BlurBoxBackgroundColor.withValues(alpha: 0.25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.HomeLocationPinIcon,
                        height: 14,
                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                      6.toHorizontalSpacer(),
                      Text(viewModel.MyLocation, style: AppStyles.MediumLight14TextStyle, textAlign: TextAlign.center),
                      2.toHorizontalSpacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      //Prayer Info
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            //Side Icon
            Positioned(
              right: 8,
              bottom: 36,
              child: Image.asset(AppAssets.HomeMosqueImagePNG, height: 116, opacity: const AlwaysStoppedAnimation(0.7)),
            ),

            //Next Prayer
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Next Prayer", style: AppStyles.RegularLight14TextStyle.copyWith(height: 1.2)),
                  InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () => viewModel.shareNextPrayer(),
                    child: Row(
                      children: [
                        Text(viewModel.NextPrayerName, style: AppStyles.BoldLight22TextStyle.copyWith(height: 1.2)),

                        //Spacer
                        6.toHorizontalSpacer(),

                        Text("|", style: AppStyles.RegularLight16TextStyle.copyWith(height: 1.2)),

                        //Spacer
                        6.toHorizontalSpacer(),

                        Text(
                          DateFormat('hh:mm a').format(viewModel.NextPrayerTime),
                          style: AppStyles.MediumLight22TextStyle.copyWith(height: 1.2),
                        ),

                        //Spacer
                        10.toHorizontalSpacer(),

                        SvgPicture.asset(
                          AppAssets.ShareIcon,
                          height: 22,
                          colorFilter: ColorFilter.mode(AppColors.LightGreenColor, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                ],
              ).withLTRBPadding(16, 24, 0, 0),
            ),

            //Remaining Time
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Time Remaining", style: AppStyles.RegularLight14TextStyle.copyWith(height: 1.2)),
                  CountdownTimer(
                    controller: viewModel.countrDownController,
                    //endTime: viewModel.NextPrayerTime.millisecondsSinceEpoch,
                    //onEnd: () async => await viewModel.reloadData(),
                    widgetBuilder:
                        (_, time) =>
                            (time != null)
                                ? Text(
                                  "${NumberFormat("00").format(time.hours ?? 0)}:${NumberFormat("00").format(time.min ?? 0)}:${NumberFormat("00").format(time.sec ?? 0)}",
                                  style: AppStyles.BoldLight18TextStyle.copyWith(
                                    height: 1.2,
                                    fontFeatures: [FontFeature.tabularFigures()],
                                  ),
                                )
                                : Text("00:00:00", style: AppStyles.BoldLight18TextStyle.copyWith(height: 1.2)),
                  ),
                ],
              ).withLTRBPadding(16, 0, 0, 42),
            ),
          ],
        ),
        stretchModes: const [StretchMode.blurBackground, StretchMode.zoomBackground],
      ),

      //Bottom rounded corners
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(36),
        child: Container(
          height: 28.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.PageBackgroundColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          ),
          child: Column(
            children: [
              //Spacer
              12.toVerticalSpacer(),

              //Top Line
              Container(
                width: 40.0,
                height: 5.0,
                decoration: BoxDecoration(color: AppColors.ShadowColor, borderRadius: BorderRadius.circular(100.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _prayerTimes(BuildContext context, HomeTimesPageViewModel viewModel) {
    return Column(
      children: [
        //Dates Slider
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1.0,
            autoPlay: false,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            initialPage: 5,
            pageSnapping: true,
            enlargeFactor: 0.3,
            height: 108,
            onPageChanged: (index, _) => viewModel.setCurrentIndex(index),
          ),
          carouselController: viewModel.buttonCarouselController,
          items:
              viewModel.Dates.map((date) {
                return Builder(
                  builder: (context) {
                    return Container(
                      margin: (16, 0).withSymetricPadding(),
                      child: DateDisplayCell(
                        gregDate: date.$1,
                        hijriDate: date.$2,
                        canScrollBack: viewModel.currentDateIndex != 0,
                        canScrollForward: viewModel.currentDateIndex != 10,
                        onNextTapped:
                            () => viewModel.buttonCarouselController.nextPage(
                              duration: AppConstants.SmallDuration.milliseconds,
                              curve: Curves.decelerate,
                            ),
                        onPrevTapped:
                            () => viewModel.buttonCarouselController.previousPage(
                              duration: AppConstants.SmallDuration.milliseconds,
                              curve: Curves.decelerate,
                            ),
                      ),
                    );
                  },
                );
              }).toList(),
        ),

        //Spacer
        12.toVerticalSpacer(),

        //Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              viewModel.Dates.map((date) {
                int index = viewModel.Dates.indexOf(date);
                return AnimatedContainer(
                  duration: AppConstants.SmallDuration.milliseconds,
                  curve: Curves.easeInOut,
                  height: 8,
                  width: viewModel.currentDateIndex == index ? 16 : 8,
                  margin: 8.withRightPadding(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        viewModel.currentDateIndex == index
                            ? AppColors.DarkGreenColor
                            : AppColors.DarkGreenColor.withValues(alpha: 0.5),
                  ),
                );
              }).toList(),
        ),

        //Spacer
        18.toVerticalSpacer(),

        //Prayer Times
        Padding(
          padding: (16, 0, 16, 12).withLTRBPadding(),
          child: Container(
            padding: (16, 16).withSymetricPadding(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              //border: Border.all(color: AppColors.DarkGrayColor.withValues(alpha: 0.05)),
              color: Colors.white.withValues(alpha: 0.9),
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Fajr
                PrayerDisplayCell(
                  prayerName: viewModel.AllPrayerTimes[0].prayerName,
                  prayerTime: viewModel.AllPrayerTimes[0].prayerTime,
                  isPrayed: viewModel.AllPrayerTimes[0].isPrayed,
                  isCurrent: viewModel.AllPrayerTimes[0].isCurrent,
                  onTap:
                      () async => await viewModel.markPrayerStatus(
                        context,
                        viewModel.AllPrayerTimes[0].prayerTime,
                        viewModel.AllPrayerTimes[0].prayerName,
                        !viewModel.AllPrayerTimes[0].isPrayed,
                      ),
                ),

                //Spacer
                12.toVerticalSpacer(),

                //Sunrise
                PrayerDisplayCell(
                  prayerName: viewModel.AllPrayerTimes[5].prayerName,
                  prayerTime: viewModel.AllPrayerTimes[5].prayerTime,
                  isPrayed: viewModel.AllPrayerTimes[5].isPrayed,
                  isCurrent: viewModel.AllPrayerTimes[5].isCurrent,
                  onTap: () {},
                ),

                //Spacer
                12.toVerticalSpacer(),

                //Dhuhr
                PrayerDisplayCell(
                  prayerName: viewModel.AllPrayerTimes[1].prayerName,
                  prayerTime: viewModel.AllPrayerTimes[1].prayerTime,
                  isPrayed: viewModel.AllPrayerTimes[1].isPrayed,
                  isCurrent: viewModel.AllPrayerTimes[1].isCurrent,
                  onTap:
                      () async => await viewModel.markPrayerStatus(
                        context,
                        viewModel.AllPrayerTimes[1].prayerTime,
                        viewModel.AllPrayerTimes[1].prayerName,
                        !viewModel.AllPrayerTimes[1].isPrayed,
                      ),
                ),

                //Spacer
                12.toVerticalSpacer(),

                //Asr
                PrayerDisplayCell(
                  prayerName: viewModel.AllPrayerTimes[2].prayerName,
                  prayerTime: viewModel.AllPrayerTimes[2].prayerTime,
                  isPrayed: viewModel.AllPrayerTimes[2].isPrayed,
                  isCurrent: viewModel.AllPrayerTimes[2].isCurrent,
                  onTap:
                      () async => await viewModel.markPrayerStatus(
                        context,
                        viewModel.AllPrayerTimes[2].prayerTime,
                        viewModel.AllPrayerTimes[2].prayerName,
                        !viewModel.AllPrayerTimes[2].isPrayed,
                      ),
                ),

                //Spacer
                12.toVerticalSpacer(),

                //Maghrib
                PrayerDisplayCell(
                  prayerName: viewModel.AllPrayerTimes[3].prayerName,
                  prayerTime: viewModel.AllPrayerTimes[3].prayerTime,
                  isPrayed: viewModel.AllPrayerTimes[3].isPrayed,
                  isCurrent: viewModel.AllPrayerTimes[3].isCurrent,
                  onTap:
                      () async => await viewModel.markPrayerStatus(
                        context,
                        viewModel.AllPrayerTimes[3].prayerTime,
                        viewModel.AllPrayerTimes[3].prayerName,
                        !viewModel.AllPrayerTimes[3].isPrayed,
                      ),
                ),

                //Spacer
                12.toVerticalSpacer(),

                //Isha
                PrayerDisplayCell(
                  prayerName: viewModel.AllPrayerTimes[4].prayerName,
                  prayerTime: viewModel.AllPrayerTimes[4].prayerTime,
                  isPrayed: viewModel.AllPrayerTimes[4].isPrayed,
                  isCurrent: viewModel.AllPrayerTimes[4].isCurrent,
                  onTap:
                      () async => await viewModel.markPrayerStatus(
                        context,
                        viewModel.AllPrayerTimes[4].prayerTime,
                        viewModel.AllPrayerTimes[4].prayerName,
                        !viewModel.AllPrayerTimes[4].isPrayed,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
