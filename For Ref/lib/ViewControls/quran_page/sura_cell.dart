import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslimlife/Framework/Extensions/widget_extensions.dart';
import 'package:muslimlife/Models/quran_models.dart';
import 'package:muslimlife/Shared/app_assets.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_styles.dart';

class SuraDisplayCell extends StatelessWidget {
  final Sura sura;

  final void Function() onTapped;

  const SuraDisplayCell({super.key, required this.sura, required this.onTapped});

  @override
  Widget build(BuildContext context) => InkWell(
    splashFactory: NoSplash.splashFactory,
    onTap: onTapped,
    child: Container(
      padding: (0, 4).withSymetricPadding(),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Sura No
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.SuraHolderIcon,
                height: 44,
                colorFilter: ColorFilter.mode(
                  sura.isCompleted ? AppColors.AppPrimaryColor : AppColors.DarkGrayColor.withValues(alpha: 0.8),
                  BlendMode.srcIn,
                ),
              ),
              Text(sura.suraNo!.toString(), style: AppStyles.BoldNarrowLight13TextStyle),
            ],
          ),

          //Spacer
          12.toHorizontalSpacer(),

          //Sura Name English
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(sura.engName!, style: AppStyles.BoldDark16TextStyle, overflow: TextOverflow.ellipsis),
              Text(sura.engTranslation!, style: AppStyles.RegularDark12TextStyle),
            ],
          ).expandWidget(),

          //Spacer
          12.toHorizontalSpacer(),

          //Sura Name Arabic
          Text(sura.arName!, style: AppStyles.ArabicHeaderBoldDark18TextStyle, textDirection: TextDirection.rtl),
        ],
      ),
    ),
  );
}
