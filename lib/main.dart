import 'package:flutter/material.dart';
import 'package:inflearn_cf_scheduler/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async{
  //플러터가 준비되기전 기다릴수 있다
  // runApp 전에 다른 작업을 해야 할경우 필요한 코드
  WidgetsFlutterBinding.ensureInitialized();
  // 한국어 지원을 위한 초기화
  await initializeDateFormatting();

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotosansKR'
      ),
      home: HomeScreen(),
    )
  );
}