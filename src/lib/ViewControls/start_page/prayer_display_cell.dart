import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';

class PrayerDisplayCell extends StatelessWidget {
  final String prayerName;
  final DateTime prayerTime;
  bool isCurrent;
  bool isNext;

  PrayerDisplayCell({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.isCurrent,
    required this.isNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      width: 130,
      decoration: BoxDecoration(
        color: isNext
            ? const Color(0xFFFFC107).withOpacity(0.2) // background-color [cite: 20]
            : const Color(0xFF37474F).withOpacity(0.6), // background-color [cite: 18]
        borderRadius: BorderRadius.circular(12.0), // border-radius [cite: 18]
        border: Border.all(
          color: isNext ? const Color(0xFFFFC107) : const Color(0xFF607D8B), // border [cite: 19, 20]
          width: isNext ? 2.0 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isNext
                ? const Color(0xFFFFC107).withOpacity(0.3) // box-shadow [cite: 21]
                : Colors.black.withOpacity(0.1), // box-shadow [cite: 19]
            blurRadius: isNext ? 20.0 : 8.0,
            offset: Offset(0, isNext ? 0 : 2),
          ),
        ],
      ),
      child: Text(prayerName),
    );
  }
}
