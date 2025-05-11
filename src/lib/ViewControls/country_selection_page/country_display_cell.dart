import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslim_life_mosque_edition/Models/country.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_constants.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';

class CountryDisplayCell extends StatelessWidget {
  final Country country;
  final bool isSelected;
  final VoidCallback onTapped;
  final FocusNode focusNode;

  const CountryDisplayCell({
    super.key,
    required this.country,
    required this.isSelected,
    required this.onTapped,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) => Focus(
    focusNode: focusNode,
    onKeyEvent: (node, event) {
      if (event is KeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.select || event.logicalKey == LogicalKeyboardKey.enter) {
          onTapped();
          return KeyEventResult.handled;
        }
      }
      return KeyEventResult.ignored;
    },
    child: GestureDetector(
      onTap: onTapped,
      child: Container(
        padding: 8.withAllPadding(),
        decoration: BoxDecoration(
          border: Border.all(
            color: focusNode.hasFocus ? AppColors.ButtonBackgroundColor.withValues(alpha: 0.8) : Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Container(
          padding: (16, 16).withSymetricPadding(),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.ButtonBackgroundColor.withValues(alpha: 0.65) : AppColors.DarkAppColor,
            border: Border.all(
              color:
                  focusNode.hasFocus
                      ? AppColors.ButtonBackgroundColor
                      : AppColors.ButtonBackgroundColor.withValues(alpha: 0.5),
              width: focusNode.hasFocus ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? AppColors.ButtonBackgroundColor : AppColors.DarkGrayColor,
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
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
