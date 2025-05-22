import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslimlife/Shared/app_assets.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_styles.dart';
import 'package:muslimlife/ViewControls/Shared/app_frame.dart';
import 'package:muslimlife/ViewControls/quran_page/sura_cell.dart';
import 'package:muslimlife/ViewModels/quran_home_page_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class QuranHomePage extends StackedView<QuranHomePageViewModel> {
  late QuranHomePageViewModel pageViewModel;
  final EventBus eventBus;

  QuranHomePage(this.eventBus, {super.key});

  @override
  QuranHomePageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = QuranHomePageViewModel(eventBus);
    return pageViewModel;
  }

  @override
  void onViewModelReady(QuranHomePageViewModel viewModel) async {
    await viewModel.loadData();
  }

  @override
  Widget builder(BuildContext context, QuranHomePageViewModel viewModel, Widget? child) => AppFrame(
    isErrorState: viewModel.IsErrorState,
    errorMessage: viewModel.ErrorMessage,
    isBusy: viewModel.IsBusy,
    loadingText: viewModel.LoadingText,
    dataLoaded: viewModel.DataLoaded,
    child: _mainContentArea(context, viewModel),
  );

  Widget _mainContentArea(BuildContext context, QuranHomePageViewModel viewModel) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        //Hero Bar
        _heroBar(viewModel, context),

        //Spacer
        4.toVerticalSliverSpacer(),

        //Suras List
        _surasList(viewModel, context),
      ],
    );
  }

  Widget _surasList(QuranHomePageViewModel viewModel, BuildContext context) => SuperSliverList.separated(
    itemCount: viewModel.Suras.length,
    separatorBuilder:
        (context, index) => Column(
          children: [
            Divider(color: AppColors.DarkGrayColor.withValues(alpha: 0.6), thickness: 0.5),
            6.toVerticalSpacer(),
          ],
        ),
    itemBuilder: (context, index) {
      final sura = viewModel.Suras[index];

      return SuraDisplayCell(sura: sura, onTapped: () => viewModel.navigateToSuraPage(context, sura));
    },
  ).withLTRBSliverPadding(16, 0, 16, 16);

  SliverAppBar _heroBar(QuranHomePageViewModel viewModel, BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      backgroundColor: AppColors.AppPrimaryColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      stretch: true,
      expandedHeight: 200,
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Dates
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.BookIcon,
                height: 32,
                colorFilter: ColorFilter.mode(AppColors.LightIndicatorColor, BlendMode.srcIn),
              ),
              6.toHorizontalSpacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(viewModel.Title, style: AppStyles.BoldLight13TextStyle),
                  Text("Your true source of guidance", style: AppStyles.RegularLight11TextStyle),
                ],
              ),
            ],
          ).withLTRBPadding(0, 4, 0, 0),
        ],
      ),

      //Next Sura Info
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            //Side Icon
            Positioned(
              right: -24,
              bottom: -12,
              child: Image.asset(AppAssets.QuranIamgePNG, height: 128, opacity: const AlwaysStoppedAnimation(0.8)),
            ),

            //Reading Info
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(viewModel.ReadingHeader, style: AppStyles.RegularLight14TextStyle.copyWith(height: 1.2)),
                  2.toVerticalSpacer(),
                  InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () => viewModel.navigateToSuraPage(context, viewModel.SuraToRead),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.SuraToRead.engName ?? "",
                          style: AppStyles.BoldLight22TextStyle.copyWith(height: 1.2),
                        ),
                        4.toVerticalSpacer(),
                        Row(
                          children: [
                            Text(
                              "Sura ${viewModel.SuraNoToRead}",
                              style: AppStyles.MediumLight14TextStyle.copyWith(height: 1.2),
                            ),
                            6.toHorizontalSpacer(),
                            Text("|", style: AppStyles.RegularLight12TextStyle.copyWith(height: 1.2)),
                            6.toHorizontalSpacer(),
                            Text(
                              viewModel.SuraToRead.revPlace == "Mecca" ? "Meccan" : "Madani",
                              style: AppStyles.MediumLight14TextStyle.copyWith(height: 1.2),
                            ),
                            6.toHorizontalSpacer(),
                            Text("|", style: AppStyles.RegularLight12TextStyle.copyWith(height: 1.2)),
                            6.toHorizontalSpacer(),
                            Text(
                              "${viewModel.SuraToRead.ayahCount} Ayahs",
                              style: AppStyles.MediumLight14TextStyle.copyWith(height: 1.2),
                            ),
                          ],
                        ),
                      ],
                    ),
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
}
