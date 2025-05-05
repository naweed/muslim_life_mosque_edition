import 'package:flutter/material.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslimlife/Models/quran_models.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_session.dart';
import 'package:muslimlife/Shared/app_styles.dart';

class AyahDisplayCell extends StatelessWidget {
  final Ayah ayah;

  const AyahDisplayCell({super.key, required this.ayah});

  @override
  Widget build(BuildContext context) => Container(
    padding: (24, 12).withSymetricPadding(),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      //border: Border.all(color: AppColors.DarkGrayColor.withValues(alpha: 0.05)),
      color: Colors.white.withValues(alpha: 0.9),
    ),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Ayah Arabic Text
        Text(
          ayah.cleanAyah,
          style: AppStyles.QuranDark34TextStyle.copyWith(height: 1.7, fontSize: AppSession.QuranFontSize!.toDouble()),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.justify,
        ),

        //Spacer
        Visibility(visible: AppSession.ShowTranslation, child: 12.toVerticalSpacer()),

        //Translation
        Visibility(
          visible: AppSession.ShowTranslation,
          child: Text(
            "${ayah.ayahNo!}. ${ayah.translation!}",
            style: AppStyles.MediumDark16TextStyle.copyWith(fontSize: AppSession.TranslationFontSize!.toDouble()),
            textAlign: TextAlign.justify,
          ),
        ),

        Visibility(visible: AppSession.ShowTransliteration, child: 2.toVerticalSpacer()),

        Visibility(
          visible: AppSession.ShowTransliteration,
          child: Divider(color: AppColors.DarkGrayColor.withValues(alpha: 0.6), thickness: 0.5),
        ),

        //Transliteration
        Visibility(
          visible: AppSession.ShowTransliteration,
          child: Text(
            ayah.transliteration!,
            style: AppStyles.MediumDark14TextStyle.copyWith(
              color: AppColors.DarkTextColor.withValues(alpha: 0.7),
              fontSize: AppSession.TransliterationFontSize!.toDouble(),
            ),
            textAlign: TextAlign.justify,
          ),
        ),

        //Spacer
        4.toVerticalSpacer(),
      ],
    ),
  );
}
