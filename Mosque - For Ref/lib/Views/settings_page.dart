import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslimlife/Framework/Extensions/widget_extensions.dart';
import 'package:muslimlife/Models/asr_calc_methods.dart';
import 'package:muslimlife/Models/prayer_calc_methods.dart';
import 'package:muslimlife/Shared/app_assets.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_constants.dart';
import 'package:muslimlife/Shared/app_styles.dart';
import 'package:muslimlife/ViewControls/Shared/app_frame.dart';
import 'package:muslimlife/ViewControls/Shared/bulleted_item.dart';
import 'package:muslimlife/ViewControls/Shared/hyper_linked_buletted_item.dart';
import 'package:muslimlife/ViewControls/Shared/section_header.dart';
import 'package:muslimlife/ViewControls/Shared/sub_section_header.dart';
import 'package:muslimlife/ViewModels/settings_page_view_model.dart';
import 'package:stacked/stacked.dart';

class SettingsPage extends StackedView<SettingsPageViewModel> {
  late SettingsPageViewModel pageViewModel;
  final EventBus eventBus;

  SettingsPage(this.eventBus, {super.key});

  @override
  SettingsPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = SettingsPageViewModel(eventBus);
    return pageViewModel;
  }

  @override
  void onViewModelReady(SettingsPageViewModel viewModel) async {
    await viewModel.loadData();
  }

  @override
  Widget builder(BuildContext context, SettingsPageViewModel viewModel, Widget? child) => AppFrame(
    isErrorState: viewModel.IsErrorState,
    errorMessage: viewModel.ErrorMessage,
    isBusy: viewModel.IsBusy,
    loadingText: viewModel.LoadingText,
    dataLoaded: viewModel.DataLoaded,
    child: DefaultTabController(length: 2, child: _mainContentArea(context, viewModel)),
  );

  Widget _mainContentArea(BuildContext context, SettingsPageViewModel viewModel) {
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
            preferredSize: const Size.fromHeight(76),
            child: Container(
              height: 68.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.PageBackgroundColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              ),
              child: SizedBox(
                height: 44,
                child: TabBar(
                  labelColor: AppColors.LightTextColor,
                  labelStyle: AppStyles.BoldLight16TextStyle,
                  labelPadding: 2.withTopPadding(),
                  unselectedLabelColor: AppColors.DarkTextColor,
                  unselectedLabelStyle: AppStyles.RegularDark16TextStyle,
                  dividerHeight: 0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    color: AppColors.TabbarSelectedColor,
                  ),
                  tabs: const [Tab(text: "About"), Tab(text: "Settings")],
                ).withLTRBPadding(24, 8, 24, 0),
              ),
            ),
          ),
        ),

        //Spacer
        12.toVerticalSliverSpacer(),

        //Tab Views
        SliverFillRemaining(
          child: Padding(
            padding: (16, 0).withSymetricPadding(),
            child: TabBarView(
              children: [
                //About
                _aboutPageUI(context),

                //Settings
                _settingsPageUI(context, viewModel),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _settingsPageUI(BuildContext context, SettingsPageViewModel viewModel) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        //Prayer Settings
        SliverToBoxAdapter(child: SectionHeader(text: "Prayer Settings")),

        16.toVerticalSliverSpacer(),

        //Prayer Calculation Method
        SliverToBoxAdapter(child: SubSectionHeader(text: "Calculation method to use")),

        8.toVerticalSliverSpacer(),

        SliverToBoxAdapter(
          child: Container(
            padding: (12, 8, 6, 8).withLTRBPadding(),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.LightGreenColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.AppPrimaryColor.withValues(alpha: 0.6), width: 1),
            ),
            child: DropdownButton(
              underline: Container(height: 0),
              elevation: 8,
              dropdownColor: AppColors.BlurBoxBackgroundColor,
              padding: 0.withAllPadding(),
              borderRadius: BorderRadius.circular(8),
              value: viewModel.prayerCalcMethod,
              items:
                  PrayerCalcMethod.getPrayerCalcMethods()
                      .map(
                        (PrayerCalcMethod calcMethod) =>
                            DropdownMenuItem(value: calcMethod.id, child: _prayerLineItem(calcMethod)),
                      )
                      .toList(),
              onChanged: (value) => viewModel.setSelectedPrayerCalcMethod(value!),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down_rounded),
              iconSize: 32,
              iconEnabledColor: AppColors.AppPrimaryColor,
            ),
          ),
        ),

        16.toVerticalSliverSpacer(),

        //Asr Calculation Method
        SliverToBoxAdapter(child: SubSectionHeader(text: "Asr time preference")),

        8.toVerticalSliverSpacer(),

        SliverToBoxAdapter(
          child: Container(
            padding: (12, 8, 6, 8).withLTRBPadding(),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.LightGreenColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.AppPrimaryColor.withValues(alpha: 0.6), width: 1),
            ),
            child: DropdownButton(
              underline: Container(height: 0),
              elevation: 8,
              dropdownColor: AppColors.BlurBoxBackgroundColor,
              padding: 0.withAllPadding(),
              borderRadius: BorderRadius.circular(8),
              value: viewModel.asrCalcMethod,
              items:
                  AsrCalcMethod.getAsrCalcMethods()
                      .map(
                        (AsrCalcMethod calcMethod) =>
                            DropdownMenuItem(value: calcMethod.id, child: _asrLineItem(calcMethod)),
                      )
                      .toList(),
              onChanged: (value) => viewModel.setSelectedAsrCalcMethod(value!),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down_rounded),
              iconSize: 32,
              iconEnabledColor: AppColors.AppPrimaryColor,
            ),
          ),
        ),

        16.toVerticalSliverSpacer(),

        //Manual Adjustments
        SliverToBoxAdapter(child: SubSectionHeader(text: "Apply manual adjustments")),

        8.toVerticalSliverSpacer(),

        SliverToBoxAdapter(
          child: GestureDetector(
            onTap:
                () => showModalBottomSheet(
                  isScrollControlled: false,
                  elevation: 0,
                  backgroundColor: AppColors.PageBackgroundColor,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  context: context,
                  builder:
                      (context) => Wrap(
                        children: [
                          Container(
                            padding: (36, 36, 36, 0).withLTRBPadding(),
                            height: 420,
                            child: _showManualPrayerAdjustmentsPage(viewModel, context),
                          ),
                        ],
                      ),
                ),
            child: Container(
              padding: (12, 8, 6, 8).withLTRBPadding(),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.LightGreenColor.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.AppPrimaryColor.withValues(alpha: 0.6), width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    viewModel.ManualPrayerAdjustments,
                    style: AppStyles.MediumDark14TextStyle,
                    overflow: TextOverflow.ellipsis,
                  ).expandWidget(),
                  const Icon(Icons.arrow_right_rounded, size: 32, color: AppColors.AppPrimaryColor),
                ],
              ),
            ),
          ),
        ),

        16.toVerticalSliverSpacer(),

        //Prayer Notifications
        SliverToBoxAdapter(child: SubSectionHeader(text: "Notify me at Adhan time")),

        8.toVerticalSliverSpacer(),

        SliverToBoxAdapter(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: (12, 8, 6, 8).withLTRBPadding(),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.LightGreenColor.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.AppPrimaryColor.withValues(alpha: 0.6), width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coming Soon (Insha'Allah)",
                    style: AppStyles.MediumDark14TextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Icon(Icons.arrow_right_rounded, size: 32, color: AppColors.AppPrimaryColor),
                ],
              ),
            ),
          ),
        ),

        36.toVerticalSliverSpacer(),

        //Quran Settings
        SliverToBoxAdapter(child: SectionHeader(text: "Quran Settings")),

        16.toVerticalSliverSpacer(),

        //Prayer Calculation Method
        SliverToBoxAdapter(child: SubSectionHeader(text: "I want to see")),

        8.toVerticalSliverSpacer(),

        //Show Translation Checkbox
        SliverToBoxAdapter(
          child: Container(
            padding: (12, 8, 6, 8).withLTRBPadding(),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.LightGreenColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.AppPrimaryColor.withValues(alpha: 0.6), width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Translation", style: AppStyles.MediumDark14TextStyle, overflow: TextOverflow.ellipsis),
                Transform.scale(
                  scale: 0.85,
                  child: Switch(
                    value: viewModel.showTranslation,
                    activeColor: AppColors.AppPrimaryColor,
                    onChanged: (bool value) => viewModel.setShowTranslationFlag(value),
                  ),
                ),
              ],
            ),
          ),
        ),

        8.toVerticalSliverSpacer(),

        //Show Transliteration Checkbox
        SliverToBoxAdapter(
          child: Container(
            padding: (12, 8, 6, 8).withLTRBPadding(),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.LightGreenColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.AppPrimaryColor.withValues(alpha: 0.6), width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Transliteration", style: AppStyles.MediumDark14TextStyle, overflow: TextOverflow.ellipsis),
                Transform.scale(
                  scale: 0.85,
                  child: Switch(
                    //padding: (0, 18).withSymetricPadding(),
                    value: viewModel.showTransliteration,
                    activeColor: AppColors.AppPrimaryColor,
                    onChanged: (bool value) => viewModel.setShowTransliterationFlag(value),
                  ),
                ),
              ],
            ),
          ),
        ),

        8.toVerticalSliverSpacer(),

        //Continuous Quran Reading Checkbox
        SliverToBoxAdapter(
          child: Container(
            padding: (12, 8, 6, 8).withLTRBPadding(),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.LightGreenColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.AppPrimaryColor.withValues(alpha: 0.6), width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Continuous Quran", style: AppStyles.MediumDark14TextStyle, overflow: TextOverflow.ellipsis),
                Transform.scale(
                  scale: 0.85,
                  child: Switch(
                    //padding: (0, 18).withSymetricPadding(),
                    value: viewModel.continuousQuranReading,
                    activeColor: AppColors.AppPrimaryColor,
                    onChanged: (bool value) => viewModel.setContinuousQuranReadingFlag(value),
                  ),
                ),
              ],
            ),
          ),
        ),

        16.toVerticalSliverSpacer(),

        //Font Sizes
        SliverToBoxAdapter(child: SubSectionHeader(text: "Font sizes")),

        8.toVerticalSliverSpacer(),

        SliverToBoxAdapter(
          child: GestureDetector(
            onTap:
                () => showModalBottomSheet(
                  isScrollControlled: false,
                  elevation: 0,
                  backgroundColor: AppColors.PageBackgroundColor,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  context: context,
                  builder:
                      (context) => Wrap(
                        children: [
                          Container(
                            padding: (36, 36, 36, 0).withLTRBPadding(),
                            height: 280,
                            child: _showFontSizeAdjustmentsPage(viewModel, context),
                          ),
                        ],
                      ),
                ),
            child: Container(
              padding: (12, 8, 6, 8).withLTRBPadding(),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.LightGreenColor.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.AppPrimaryColor.withValues(alpha: 0.6), width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    viewModel.FontSizes,
                    style: AppStyles.MediumDark14TextStyle,
                    overflow: TextOverflow.ellipsis,
                  ).expandWidget(),
                  const Icon(Icons.arrow_right_rounded, size: 32, color: AppColors.AppPrimaryColor),
                ],
              ),
            ),
          ),
        ),

        //FinalSpacer
        24.toVerticalSliverSpacer(),
      ],
    );
  }

  Widget _aboutPageUI(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        //Iamge
        SliverToBoxAdapter(child: Image.asset(AppAssets.AppLogo, height: 140)),

        //Header
        SliverToBoxAdapter(
          child: Text(
            "Muslim Life",
            style: AppStyles.BoldDark22TextStyle.copyWith(height: 1),
            textAlign: TextAlign.center,
          ),
        ),

        //Spacer
        30.toVerticalSliverSpacer(),

        //Our Mission
        SliverToBoxAdapter(child: SectionHeader(text: "Our Mission")),

        4.toVerticalSliverSpacer(),

        SliverToBoxAdapter(
          child: Text(
            "Muslim Life is dedicated to helping Muslims around the world strengthen their faith and maintain their daily Islamic practices with ease. We strive to be your trusted companion in your spiritual journey, providing accurate, reliable, and user-friendly tools for your daily worship needs.",
            style: AppStyles.RegularDark14TextStyle.copyWith(height: 1.3),
            textAlign: TextAlign.justify,
          ),
        ),

        12.toVerticalSliverSpacer(),

        SliverToBoxAdapter(
          child: Text(
            "As part of our commitment to serve the Ummah, Muslim Life is and will always remain 100% FREE with NO ADS. We believe that tools for worship and spiritual growth should be accessible to everyone without distractions or monetary barriers. This is our way of seeking Allah's pleasure and contributing to the Muslim community worldwide.",
            style: AppStyles.RegularDark14TextStyle.copyWith(height: 1.3),
            textAlign: TextAlign.justify,
          ),
        ),

        //Spacer
        24.toVerticalSliverSpacer(),

        //Privacy Committment
        SliverToBoxAdapter(child: SectionHeader(text: "Privacy Commitment")),

        4.toVerticalSliverSpacer(),

        SliverToBoxAdapter(
          child: Text(
            "Your privacy matters to us. Muslim Life operates with complete transparency and ensures your personal data remains secure on your device. We do not collect any information or share your data with third parties.",
            style: AppStyles.RegularDark14TextStyle.copyWith(height: 1.3),
            textAlign: TextAlign.justify,
          ),
        ),

        //Spacer
        24.toVerticalSliverSpacer(),

        //Disclaimer
        SliverToBoxAdapter(child: SectionHeader(text: "Disclaimer")),

        4.toVerticalSliverSpacer(),

        SliverToBoxAdapter(
          child: Text(
            "While we strive for accuracy in prayer times and Qibla direction, please do verify critical information with your local mosque or Islamic authority.",
            style: AppStyles.RegularDark14TextStyle.copyWith(height: 1.3),
            textAlign: TextAlign.justify,
          ),
        ),

        //Spacer
        24.toVerticalSliverSpacer(),

        //Support & Feedback
        SliverToBoxAdapter(child: SectionHeader(text: "Support & Feedback")),

        4.toVerticalSliverSpacer(),

        SliverToBoxAdapter(
          child: Text(
            "We are constantly working to improve Muslim Life. Your feedback helps us create a better experience for our community. Please feel free to contact us and send your suggestions using the channels mentioned below:",
            style: AppStyles.RegularDark14TextStyle.copyWith(height: 1.3),
            textAlign: TextAlign.justify,
          ),
        ),

        12.toVerticalSliverSpacer(),

        SliverToBoxAdapter(
          child: HyperlinkedBulettedList(
            headerText: 'Email',
            bodyText: AppConstants.SupportEmailAddress,
            actionType: 'email',
          ),
        ),
        // 4.toVerticalSliverSpacer(),
        // SliverToBoxAdapter(
        //   child: HyperlinkedBulettedList(
        //     headerText: 'Web',
        //     bodyText: AppConstants.AppWebsite,
        //     actionType: 'url',
        //   ),
        // ),
        4.toVerticalSliverSpacer(),
        SliverToBoxAdapter(
          child: HyperlinkedBulettedList(
            headerText: 'Twitter/X',
            bodyText: AppConstants.TwitterHandle,
            actionType: 'twitter',
          ),
        ),

        //Spacer
        24.toVerticalSliverSpacer(),

        //Disclaimer
        SliverToBoxAdapter(child: SectionHeader(text: "Credits")),

        4.toVerticalSliverSpacer(),

        SliverToBoxAdapter(
          child: Text(
            "We extend our heartfelt gratitude to all the scholars, translators, Qaris, and technical experts who have contributed to making this app possible. Their dedication to preserving and sharing Islamic knowledge has helped create this valuable resource for Muslims all over the world.",
            style: AppStyles.RegularDark14TextStyle.copyWith(height: 1.3),
            textAlign: TextAlign.justify,
          ),
        ),

        12.toVerticalSliverSpacer(),

        SliverToBoxAdapter(child: BulettedList(headerText: 'Quran', bodyText: "King Fahd Quran Complex")),
        4.toVerticalSliverSpacer(),
        SliverToBoxAdapter(child: BulettedList(headerText: 'Translations', bodyText: "Tanzil.net")),
        4.toVerticalSliverSpacer(),
        SliverToBoxAdapter(child: BulettedList(headerText: 'Recitations', bodyText: "Coming soon")),
        4.toVerticalSliverSpacer(),
        SliverToBoxAdapter(child: BulettedList(headerText: 'UI Design', bodyText: "Haroon Marwat")),

        //FinalSpacer
        36.toVerticalSliverSpacer(),
      ],
    );
  }

  Widget _asrLineItem(AsrCalcMethod calcMethod) =>
      Text(calcMethod.description!, style: AppStyles.MediumDark14TextStyle, overflow: TextOverflow.ellipsis);

  Widget _prayerLineItem(PrayerCalcMethod calcMethod) =>
      Text(calcMethod.description!, style: AppStyles.MediumDark14TextStyle, overflow: TextOverflow.ellipsis);

  Widget _showManualPrayerAdjustmentsPage(SettingsPageViewModel viewModel, BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //Header
      SizedBox(
        width: double.infinity,
        child: Text(
          "Manual Adjustments",
          style: AppStyles.BoldDark22TextStyle.copyWith(
            decoration: TextDecoration.none,
            color: AppColors.DarkTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),

      //Spacer
      36.toVerticalSpacer(),

      //Fajr Adjustment
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Fajr", style: AppStyles.BoldDark18TextStyle),
          InputQty.int(
            onQtyChanged: (val) => viewModel.setFajrAdjustment(val),
            maxVal: 30,
            minVal: -30,
            steps: 1,
            initVal: viewModel.fajrAdjustment,
            qtyFormProps: QtyFormProps(enableTyping: false, style: AppStyles.MediumDark16TextStyle),
            decoration: const QtyDecorationProps(
              isBordered: false,
              borderShape: BorderShapeBtn.circle,
              width: 14,
              btnColor: AppColors.AppPrimaryColor,
            ),
          ),
        ],
      ),

      //Spacer
      16.toVerticalSpacer(),

      //Sunrise Adjustment
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Sunrise", style: AppStyles.BoldDark18TextStyle),
          InputQty.int(
            onQtyChanged: (val) => viewModel.setSunriseAdjustment(val),
            maxVal: 30,
            minVal: -30,
            steps: 1,
            initVal: viewModel.sunriseAdjustment,
            qtyFormProps: QtyFormProps(enableTyping: false, style: AppStyles.MediumDark16TextStyle),
            decoration: const QtyDecorationProps(
              isBordered: false,
              borderShape: BorderShapeBtn.circle,
              width: 14,
              btnColor: AppColors.AppPrimaryColor,
            ),
          ),
        ],
      ),

      //Spacer
      16.toVerticalSpacer(),

      //Dhuhr Adjustment
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Dhuhr", style: AppStyles.BoldDark18TextStyle),
          InputQty.int(
            onQtyChanged: (val) => viewModel.setDhuhrAdjustment(val),
            maxVal: 30,
            minVal: -30,
            steps: 1,
            initVal: viewModel.dhuhrAdjustment,
            qtyFormProps: QtyFormProps(enableTyping: false, style: AppStyles.MediumDark16TextStyle),
            decoration: const QtyDecorationProps(
              isBordered: false,
              borderShape: BorderShapeBtn.circle,
              width: 14,
              btnColor: AppColors.AppPrimaryColor,
            ),
          ),
        ],
      ),

      //Spacer
      16.toVerticalSpacer(),

      //Asr Adjustment
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Asr", style: AppStyles.BoldDark18TextStyle),
          InputQty.int(
            onQtyChanged: (val) => viewModel.setAsrAdjustment(val),
            maxVal: 30,
            minVal: -30,
            steps: 1,
            initVal: viewModel.asrAdjustment,
            qtyFormProps: QtyFormProps(enableTyping: false, style: AppStyles.MediumDark16TextStyle),
            decoration: const QtyDecorationProps(
              isBordered: false,
              borderShape: BorderShapeBtn.circle,
              width: 14,
              btnColor: AppColors.AppPrimaryColor,
            ),
          ),
        ],
      ),

      //Spacer
      16.toVerticalSpacer(),

      //Maghrib Adjustment
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Maghrib", style: AppStyles.BoldDark18TextStyle),
          InputQty.int(
            onQtyChanged: (val) => viewModel.setMaghribAdjustment(val),
            maxVal: 30,
            minVal: -30,
            steps: 1,
            initVal: viewModel.maghribAdjustment,
            qtyFormProps: QtyFormProps(enableTyping: false, style: AppStyles.MediumDark16TextStyle),
            decoration: const QtyDecorationProps(
              isBordered: false,
              borderShape: BorderShapeBtn.circle,
              width: 14,
              btnColor: AppColors.AppPrimaryColor,
            ),
          ),
        ],
      ),

      //Spacer
      16.toVerticalSpacer(),

      //Isha Adjustment
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Isha", style: AppStyles.BoldDark18TextStyle),
          InputQty.int(
            onQtyChanged: (val) => viewModel.setIshaAdjustment(val),
            maxVal: 30,
            minVal: -30,
            steps: 1,
            initVal: viewModel.ishaAdjustment,
            qtyFormProps: QtyFormProps(enableTyping: false, style: AppStyles.MediumDark16TextStyle),
            decoration: const QtyDecorationProps(
              isBordered: false,
              borderShape: BorderShapeBtn.circle,
              width: 14,
              btnColor: AppColors.AppPrimaryColor,
            ),
          ),
        ],
      ),

      // //Spacer
      // 24.toVerticalSpacer(),
    ],
  );

  Widget _showFontSizeAdjustmentsPage(SettingsPageViewModel viewModel, BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //Header
      SizedBox(
        width: double.infinity,
        child: Text(
          "Font Sizes",
          style: AppStyles.BoldDark22TextStyle.copyWith(
            decoration: TextDecoration.none,
            color: AppColors.DarkTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),

      //Spacer
      36.toVerticalSpacer(),

      //Quran Font Size Adjustment
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Ayah", style: AppStyles.BoldDark18TextStyle),
          InputQty.int(
            onQtyChanged: (val) => viewModel.setQuranFontSize(val),
            maxVal: 38,
            minVal: 24,
            steps: 2,
            initVal: viewModel.quranFontSize,
            qtyFormProps: QtyFormProps(enableTyping: false, style: AppStyles.MediumDark16TextStyle),
            decoration: const QtyDecorationProps(
              isBordered: false,
              borderShape: BorderShapeBtn.circle,
              width: 14,
              btnColor: AppColors.AppPrimaryColor,
            ),
          ),
        ],
      ),

      //Spacer
      16.toVerticalSpacer(),

      //Translation Font Size Adjustment
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Translation", style: AppStyles.BoldDark18TextStyle),
          InputQty.int(
            onQtyChanged: (val) => viewModel.setTranslationFontSize(val),
            maxVal: 22,
            minVal: 12,
            steps: 1,
            initVal: viewModel.translationFontSize,
            qtyFormProps: QtyFormProps(enableTyping: false, style: AppStyles.MediumDark16TextStyle),
            decoration: const QtyDecorationProps(
              isBordered: false,
              borderShape: BorderShapeBtn.circle,
              width: 14,
              btnColor: AppColors.AppPrimaryColor,
            ),
          ),
        ],
      ),

      //Spacer
      16.toVerticalSpacer(),

      //Transliteration Font Size Adjustment
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Transliteration", style: AppStyles.BoldDark18TextStyle),
          InputQty.int(
            onQtyChanged: (val) => viewModel.setTransliterationFontSize(val),
            maxVal: 20,
            minVal: 10,
            steps: 1,
            initVal: viewModel.transliterationFontSize,
            qtyFormProps: QtyFormProps(enableTyping: false, style: AppStyles.MediumDark16TextStyle),
            decoration: const QtyDecorationProps(
              isBordered: false,
              borderShape: BorderShapeBtn.circle,
              width: 14,
              btnColor: AppColors.AppPrimaryColor,
            ),
          ),
        ],
      ),

      // //Spacer
      // 24.toVerticalSpacer(),
    ],
  );
}
