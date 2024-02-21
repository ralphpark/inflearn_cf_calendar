import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:inflearn_cf_scheduler/database/drift_database.dart';
import 'package:inflearn_cf_scheduler/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

const DefaultColors = [
  //빨강
  'F44336',
  //주황
  'FF9800',
  //노랑
  'FFEB3B',
  //초록
  '4CAF50',
  //파랑
  '2196F3',
  //남색
  '03A9F4',
  //보라
  '9C27B0',
];

void main() async{
  //플러터가 준비되기전 기다릴수 있다
  // runApp 전에 다른 작업을 해야 할경우 필요한 코드
  WidgetsFlutterBinding.ensureInitialized();
  // 한국어 지원을 위한 초기화
  await initializeDateFormatting();

  //데이터베이스
  final database = LocalDatabase();
  GetIt.I.registerSingleton<LocalDatabase>(database);

  final colors = await database.getCategoryColors();
  if(colors.isEmpty){
    for(final color in DefaultColors){
      await database.createCategoryColor(CategoryColorsCompanion(
        hexCode: Value(color),
      ));
    }
  }

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotosansKR'
      ),
      home: HomeScreen(),
    )
  );
}