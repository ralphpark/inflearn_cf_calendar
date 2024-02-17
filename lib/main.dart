import 'package:flutter/material.dart';
import 'package:inflearn_cf_scheduler/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotosansKR'
      ),
      home: HomeScreen(),
    )
  );
}