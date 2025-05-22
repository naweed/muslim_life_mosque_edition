import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslimlife/Framework/Extensions/navigation_extentions.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslimlife/Models/quran_models.dart';
import 'package:muslimlife/Shared/app_assets.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_session.dart';
import 'package:muslimlife/Shared/app_styles.dart';
import 'package:muslimlife/ViewControls/Shared/error_indicator.dart';
import 'package:muslimlife/ViewControls/Shared/loading_indicator.dart';
import 'package:muslimlife/ViewControls/Shared/page_button.dart';
import 'package:muslimlife/ViewControls/quran_page/ayah_cell.dart';
import 'package:stacked/stacked.dart';
import 'package:muslimlife/ViewModels/sura_page_view_model.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class SuraPage extends StackedView<SuraPageViewModel> {
  late SuraPageViewModel pageViewModel;
  final EventBus eventBus;
  final Sura sura;

  bool isScrollNotificationEnabled = true;

  SuraPage(this.eventBus, this.sura, {super.key});

  @override
  SuraPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = SuraPageViewModel(eventBus, sura);
    return pageViewModel;
  }

  @override
  void onViewModelReady(SuraPageViewModel viewModel) async {
    await viewModel.loadData();

    //Navigate to Specific Ayah/Location
    Future.delayed(500.milliseconds, () async {
      //Disable Scroll Listener
      isScrollNotificationEnabled = false;

      if (AppSession.ReadAyahNo != 0) {
        //await viewModel.scrollController.scrollToIndex(AppSession.ReadAyahNo!, preferPosition: AutoScrollPosition.begin, duration: 1.milliseconds);
        viewModel.listController.jumpToItem(
          index: AppSession.ReadAyahNo! + 1,
          scrollController: viewModel.scrollController,
          alignment: 0.0,
        );
      }

      //Enable Scroll Listener
      isScrollNotificationEnabled = true;
    });
  }

  @override
  Widget builder(BuildContext context, SuraPageViewModel viewModel, Widget? child) => Scaffold(
    backgroundColor: AppColors.PageBackgroundColor,
    body: AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(child: _mainContentArea(context, viewModel)),
    ),
  );

  Widget _mainContentArea(BuildContext context, SuraPageViewModel viewModel) {
    //Show Error Indicator
    if (viewModel.IsErrorState) {
      return ErrorIndicator(errorText: viewModel.ErrorMessage);
    }

    //Show Loading Indicator
    if (viewModel.IsBusy) {
      return LoadingIndicator(loadingText: viewModel.LoadingText, indicatorColor: AppColors.LightIndicatorColor);
    }

    //Show UI
    if (viewModel.DataLoaded) {
      return Container(
        padding: (16, 0, 16, 0).withLTRBPadding(),
        width: double.infinity,
        height: double.infinity,
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (!isScrollNotificationEnabled) {
              return false;
            }

            if (scrollNotification is ScrollEndNotification) {
              var (startIndex, _) = viewModel.listController.unobstructedVisibleRange!;

              var currentAyah = startIndex;
              viewModel.saveAyahNo(currentAyah);
              return true;
            }

            return false;
          },
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            controller: viewModel.scrollController,
            slivers: [
              //Page Header
              _headerContent(context, viewModel),

              //Spacer
              6.toVerticalSliverSpacer(),

              //Sura Info
              SliverToBoxAdapter(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Sura No.
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        padding: (18, 6).withSymetricPadding(),
                        color: AppColors.AppPrimaryColor.withValues(alpha: 0.85),
                        child: Text(
                          "Sura No. ${viewModel.sura.suraNo}",
                          style: AppStyles.MediumLight14TextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    //Spacer
                    16.toHorizontalSpacer(),

                    //Sura Name
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        padding: (18, 6).withSymetricPadding(),
                        color: AppColors.AppPrimaryColor.withValues(alpha: 0.85),
                        child: Text(
                          viewModel.sura.engName!,
                          style: AppStyles.MediumLight14TextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Spacer
              SliverVisibility(visible: sura.suraNo! == 1 || sura.suraNo == 9, sliver: 36.toVerticalSliverSpacer()),
              SliverVisibility(visible: sura.suraNo! != 1 && sura.suraNo != 9, sliver: 20.toVerticalSliverSpacer()),

              //Bismillah
              SliverVisibility(
                visible: sura.suraNo! != 1 && sura.suraNo != 9,
                sliver: SliverPadding(
                  padding: (48, 0, 48, 16).withLTRBPadding(),
                  sliver: SliverToBoxAdapter(
                    child: Image.asset(AppAssets.BismillahImagePNG, width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
              ),

              //Ayahs List
              SuperSliverList.separated(
                listController: viewModel.listController,
                itemCount: viewModel.Ayahs.length,
                itemBuilder: (context, index) {
                  final ayah = viewModel.Ayahs[index];

                  return AyahDisplayCell(ayah: ayah);
                },
                separatorBuilder: (context, index) => 16.toVerticalSpacer(),
              ),

              //Spacer
              24.toVerticalSliverSpacer(),

              // Complete Sura button
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [PageButton(text: "Mark as Read", onPressed: () => viewModel.markSuraAsRead(context))],
                  ),
                ),
              ),

              //Final Spacer
              24.toVerticalSliverSpacer(),
            ],
          ),
        ),
      );
    }

    //Return Empty Page
    return Container();
  }

  SliverAppBar _headerContent(BuildContext context, SuraPageViewModel viewModel) {
    return SliverAppBar(
      //Back Icon
      leadingWidth: 56 - 24,
      leading: GestureDetector(
        onTap: () => context.popPage(),
        child: Container(
          padding: (0, 12, 0, 12).withLTRBPadding(),
          child: SvgPicture.asset(
            AppAssets.BackIcon,
            colorFilter: ColorFilter.mode(AppColors.AppPrimaryColor, BlendMode.srcIn),
          ),
        ),
      ),
      backgroundColor: AppColors.PageBackgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      centerTitle: true,

      title: Text(
        viewModel.sura.arNameLong!,
        style: AppStyles.ArabicHeaderExtraBoldDark24TextStyle.copyWith(color: AppColors.AppPrimaryColor),
      ),
    );
  }
}
