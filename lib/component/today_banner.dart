import 'package:flutter/material.dart';
import 'package:inflearn_cf_scheduler/const/colors.dart';

class TodayBanner extends StatelessWidget {
  const TodayBanner({super.key, required this.selectedDay, required this.scheduleCount});
  final DateTime selectedDay;
  final int scheduleCount;

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );

    return Container(
      color: PrimaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일', style: textStyle),
            Text('일정 ${scheduleCount}개', style: textStyle),
          ],
        ),
      ),
    );
  }
}
