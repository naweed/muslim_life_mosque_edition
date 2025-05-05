import 'package:gap/gap.dart';

extension SizedBoxExtensions on int {
  Gap toHorizontalSpacer() => Gap(toDouble());
  Gap toVerticalSpacer() => Gap(toDouble());

  SliverGap toHorizontalSliverSpacer() => SliverGap(toDouble());
  SliverGap toVerticalSliverSpacer() => SliverGap(toDouble());
}
