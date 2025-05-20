import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muslim_life_mosque_edition/Actions/enter_button_action.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/device_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/widget_extensions.dart';
import 'package:muslim_life_mosque_edition/Intents/enter_button_intent.dart';
import 'package:muslim_life_mosque_edition/Shared/app_assets.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/page_button.dart';
import 'package:muslim_life_mosque_edition/ViewModels/mosque_code_selection_page_view_model.dart';
import 'package:stacked/stacked.dart';

class MosqueCodeSelectionPage extends StackedView<MosqueCodeSelectionPageViewModel> {
  late MosqueCodeSelectionPageViewModel pageViewModel;

  MosqueCodeSelectionPage({super.key});

  @override
  MosqueCodeSelectionPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = MosqueCodeSelectionPageViewModel();
    pageViewModel.screenContext = context;
    return pageViewModel;
  }

  @override
  void onViewModelReady(MosqueCodeSelectionPageViewModel viewModel) async {
    viewModel.requestFocus();
  }

  Widget _buildOtpField(int index, MosqueCodeSelectionPageViewModel viewModel) {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color:
              viewModel.otpFocusNodes[index].hasFocus
                  ? AppColors.ButtonBackgroundColor
                  : AppColors.ButtonBackgroundColor.withValues(alpha: 0.2),
          width: viewModel.otpFocusNodes[index].hasFocus ? 2.0 : 1.0,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Focus(
        focusNode: viewModel.otpFocusNodes[index],
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowRight && index < 4) {
              viewModel.otpFocusNodes[index + 1].requestFocus();
              return KeyEventResult.handled;
            } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft && index > 0) {
              viewModel.otpFocusNodes[index - 1].requestFocus();
              return KeyEventResult.handled;
            } else if (event.logicalKey == LogicalKeyboardKey.select || event.logicalKey == LogicalKeyboardKey.enter) {
              // Move to next field on D-pad select
              viewModel.moveToNextField(index);
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
        child: TextField(
          autofocus: true,
          controller: viewModel.otpControllers[index],
          textAlign: TextAlign.center,
          maxLength: 1,
          style: AppStyles.OnboardingSubTitleTextStyle,
          textCapitalization: TextCapitalization.characters,
          keyboardType: TextInputType.text,
          textInputAction: index < 4 ? TextInputAction.next : TextInputAction.done,
          decoration: const InputDecoration(counterText: '', border: InputBorder.none),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Z]'))],
          onChanged: (value) => viewModel.handleOtpInput(value, index),
        ),
      ),
    );
  }

  @override
  Widget builder(BuildContext context, MosqueCodeSelectionPageViewModel viewModel, Widget? child) => Scaffold(
    body: Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{LogicalKeySet(LogicalKeyboardKey.select): EnterButtonIntent()},
      child: Container(
        padding: (48, 48, 48, 48).withLTRBPadding(),
        width: double.infinity,
        height: double.infinity,
        color: AppColors.AppPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppAssets.MosqueImagePNG, width: context.width * 0.3),
            48.toHorizontalSpacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(viewModel.Title, style: AppStyles.OnboardingTitleTextStyle),
                12.toVerticalSpacer(),
                Text(
                  viewModel.Description,
                  style: AppStyles.OnboardingSubTitleTextStyle.copyWith(height: 1.25),
                  textAlign: TextAlign.center,
                ),
                32.toVerticalSpacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) => _buildOtpField(index, viewModel)),
                ),
                32.toVerticalSpacer(),
                Container(
                  padding: 8.withAllPadding(),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          viewModel.continueButtonFocus.hasFocus ? AppColors.ButtonBackgroundColor : Colors.transparent,
                      width: viewModel.continueButtonFocus.hasFocus ? 2.0 : 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Actions(
                    actions: <Type, Action<Intent>>{
                      EnterButtonIntent: EnterButtonAction(() async => await viewModel.continueWithMosqueCode()),
                    },
                    child: Focus(
                      focusNode: viewModel.continueButtonFocus,
                      child: PageButton(
                        text: viewModel.ButtonText,
                        isEnabled: viewModel.isButtonEnabled,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ).expandWidget(),
          ],
        ),
      ),
    ),
  );
}
