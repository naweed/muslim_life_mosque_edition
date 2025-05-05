import 'dart:math';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:muslimlife/CustomPainters/compass_custom_painter.dart';
import 'package:muslimlife/Framework/Extensions/device_extensions.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Shared/app_assets.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_styles.dart';
import 'package:muslimlife/ViewControls/Shared/app_frame.dart';
import 'package:muslimlife/ViewModels/qibla_direction_page_view_model.dart';
import 'package:stacked/stacked.dart';

class QiblaDirectionPage extends StackedView<QiblaDirectionPageViewModel> {
  late QiblaDirectionPageViewModel pageViewModel;
  final EventBus eventBus;

  QiblaDirectionPage(this.eventBus, {super.key});

  @override
  QiblaDirectionPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = QiblaDirectionPageViewModel(eventBus);
    return pageViewModel;
  }

  @override
  void onViewModelReady(QiblaDirectionPageViewModel viewModel) async {
    await viewModel.loadData();
  }

  @override
  Widget builder(BuildContext context, QiblaDirectionPageViewModel viewModel, Widget? child) => AppFrame(
    isErrorState: viewModel.IsErrorState,
    errorMessage: viewModel.ErrorMessage,
    isBusy: viewModel.IsBusy,
    loadingText: viewModel.LoadingText,
    dataLoaded: viewModel.DataLoaded,
    child: _mainContentArea(context, viewModel),
  );

  Widget _mainContentArea(BuildContext context, QiblaDirectionPageViewModel viewModel) {
    final size = context.deviceSize;

    return CustomScrollView(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
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
            preferredSize: const Size.fromHeight(46),
            child: Container(
              height: 38.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.PageBackgroundColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              ),
            ),
          ),
        ),

        SliverFillRemaining(
          child: Padding(
            padding: (16, 0, 16, 16).withLTRBPadding(),
            child: StreamBuilder<CompassEvent>(
              stream: viewModel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error reading direction: ${snapshot.error}', style: AppStyles.RegularDark16TextStyle);
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.AppPrimaryColor));
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                    child: Text("Unable to locate direction of the Qibla!", style: AppStyles.RegularDark16TextStyle),
                  );
                } else {
                  double? direction = snapshot.data!.heading;

                  // if direction is null,
                  // then device does not support this sensor

                  // show error message
                  if (direction == null) {
                    return const Center(
                      child: Text("Sorry, your phone does not have sensors!", style: AppStyles.RegularDark16TextStyle),
                    );
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(size: size, painter: CompassCustomPainter(angle: direction)),
                            Transform.rotate(
                              angle: -2 * pi * (direction / 360),
                              child: Transform(
                                alignment: FractionalOffset.center,
                                transform: Matrix4.rotationZ(viewModel.qiblaDirection * pi / 180),
                                origin: Offset.zero,
                                child: Image.asset(
                                  AppAssets.Kaaba,
                                  width: 112,
                                  // height: 32,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                              radius: 148,
                              child: Transform.rotate(
                                angle: -2 * pi * (direction / 360),
                                child: Transform(
                                  alignment: FractionalOffset.center,
                                  transform: Matrix4.rotationZ(viewModel.qiblaDirection * pi / 180),
                                  origin: Offset.zero,
                                  child: const Align(
                                    alignment: Alignment.topCenter,
                                    child: Icon(Icons.expand_less_outlined, color: AppColors.AppPrimaryColor, size: 48),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const Alignment(0, 0.45),
                              child: Text(
                                viewModel.showHeading(direction, viewModel.qiblaDirection),
                                style: AppStyles.MediumDark16TextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
