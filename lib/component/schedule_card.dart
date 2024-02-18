import 'package:flutter/material.dart';
import 'package:inflearn_cf_scheduler/const/colors.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.content,
      required this.color});

  final int startTime;
  final int endTime;
  final String content;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width:1,color: PrimaryColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight( // 자식 위젯의 높이를 부모 위젯의 높이에 맞춰주는 위젯
          //가장 큰 위젯의 높이와 동일하게 맞춰주는 역할
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(
                startTime: startTime,
                endTime: endTime,
              ),
              const SizedBox(width: 16.0),
              _Content(content: content),
              const SizedBox(width: 16.0),
              _Category(color: color),
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({super.key, required this.startTime, required this.endTime});

  final int startTime;
  final int endTime;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: PrimaryColor,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${startTime.toString().padLeft(2,'0')}:00', style: textStyle),
        Text('${endTime.toString().padLeft(2,'0')}:00', style: textStyle.copyWith(fontSize: 10)),
      ],
    );
  }
}
class _Content extends StatelessWidget {
  final String content;
  const _Content({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(content));
  }
}
class _Category extends StatelessWidget {
  final Color color;
  const _Category({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 16,
      height: 16,
    );
  }
}

