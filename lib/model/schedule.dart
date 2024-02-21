import 'package:drift/drift.dart';

class Schedules extends Table {
  //primary key(자동증가)
  IntColumn get id => integer().autoIncrement()();
  //내용
  TextColumn get content => text()();
  //일정 날짜
  DateTimeColumn get date => dateTime()();
  //시작시간
  IntColumn get startTime => integer()();
  //마감시간
  IntColumn get endTime => integer()();
  //색상(카테고리)
  IntColumn get colorID => integer()();
  //생성날짜 (자동생성)
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
}