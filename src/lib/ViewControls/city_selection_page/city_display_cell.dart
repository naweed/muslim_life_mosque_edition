import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Models/city.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';

class CityDisplayCell extends StatelessWidget {
  final City city;
  final bool isSelected;
  final void Function() onTapped;
  final FocusNode focusNode;

  const CityDisplayCell({
    super.key,
    required this.city,
    required this.onTapped,
    required this.isSelected,
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
          child: Text(
            city.name!,
            style: isSelected ? AppStyles.RegularLight16TextStyle : AppStyles.RegularDark16TextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ),
  );
}
