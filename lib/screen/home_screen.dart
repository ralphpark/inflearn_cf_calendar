
import 'package:flutter/material.dart';
import 'package:inflearn_cf_scheduler/component/calendar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Calendar(),
          ],
        ),
      ),
    );
  }
}
