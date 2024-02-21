import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:inflearn_cf_scheduler/const/colors.dart';
import 'package:inflearn_cf_scheduler/database/drift_database.dart';
import 'package:inflearn_cf_scheduler/model/schedule_with_color.dart';

class TodayBanner extends StatelessWidget {
  const TodayBanner({super.key, required this.selectedDay, });
  final DateTime selectedDay;

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
            StreamBuilder<List<ScheduleWithColor>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDay), // watchSchedules는 해당 날짜의 일정을 가져오는 메서드
              builder: (context, snapshot) {
                int count = 0;
                if(snapshot.hasData){
                  count = snapshot.data!.length;
                }
                return Text('일정 ${count}개', style: textStyle);
              }
            ),
          ],
        ),
      ),
    );
  }
}
