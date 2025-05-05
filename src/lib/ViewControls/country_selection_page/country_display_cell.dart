import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/widget_extensions.dart';
import 'package:muslim_life_mosque_edition/Models/country.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_constants.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';

class CountryDisplayCell extends StatelessWidget {
  final Country country;
  final bool isSelected;
  final void Function() onTapped;

  const CountryDisplayCell({super.key, required this.country, required this.onTapped, required this.isSelected});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTapped,
    child: Container(
      padding: (16, 16).withSymetricPadding(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.DarkGrayColor.withValues(alpha: 0.7)),
        color: isSelected ? AppColors.DarkGreenColor.withValues(alpha: 0.65) : AppColors.LightGreenColor,
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? AppColors.PageBackgroundColor : AppColors.AppPrimaryColor,
                width: 0.5,
              ),
            ),
            child: SvgPicture.asset(
              "${AppConstants.FlagsPath}/${country.id!.toLowerCase()}.svg",
              height: 18,
              width: 24,
            ),
          ),
          12.toHorizontalSpacer(),
          Text(
            country.name!,
            style: isSelected ? AppStyles.RegularLight16TextStyle : AppStyles.RegularDark16TextStyle,
            overflow: TextOverflow.ellipsis,
          ).expandWidget(),
        ],
      ),
    ),
  );
}
