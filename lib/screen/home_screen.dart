import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inflearn_cf_scheduler/component/calendar.dart';
import 'package:inflearn_cf_scheduler/component/schedule_bottom_sheet.dart';
import 'package:inflearn_cf_scheduler/component/schedule_card.dart';
import 'package:inflearn_cf_scheduler/component/today_banner.dart';
import 'package:inflearn_cf_scheduler/const/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              onDaySelected:onDaySelected,
              selectedDay: selectedDay,
              focusedDay: focusedDay,
            ),
            const SizedBox(height: 8.0),
            TodayBanner(
              selectedDay: selectedDay,
              scheduleCount: 3,
            ),
            const SizedBox(height: 8.0),
            _ScheduleList(),
          ],
        ),
      ),
    );
  }
  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return ScheduleBottomSheet();
          },
        );
      },
      backgroundColor: PrimaryColor,
      child: Icon(Icons.add),
    );
  }

  onDaySelected (DateTime selectedDay,DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}
class _ScheduleList extends StatelessWidget {
  const _ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8.0);
            },
            itemBuilder: (context, index) {
              return ScheduleCard(
                startTime: 8,
                endTime: 9,
                content: '프로그래밍 공부하기',
                color: Colors.blue,
              );
            },
          )
      ),
    );
  }
}
