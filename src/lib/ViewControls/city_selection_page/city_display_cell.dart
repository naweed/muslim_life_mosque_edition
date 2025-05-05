import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Models/city.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';

class CityDisplayCell extends StatelessWidget {
  final City city;
  final bool isSelected;
  final void Function() onTapped;

  const CityDisplayCell({super.key, required this.city, required this.onTapped, required this.isSelected});

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
      child: Text(
        city.name!,
        style: isSelected ? AppStyles.RegularLight16TextStyle : AppStyles.RegularDark16TextStyle,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
