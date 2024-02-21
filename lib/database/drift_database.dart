//private은 불러올 수 없다
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:inflearn_cf_scheduler/model/category_color.dart';
import 'package:inflearn_cf_scheduler/model/schedule.dart';
import 'package:inflearn_cf_scheduler/model/schedule_with_color.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';

//private도 다 불러온다(같은 파일의 개념)
part 'drift_database.g.dart'; // g는 generated를 의미

@DriftDatabase(tables: [Schedules, CategoryColors])

class LocalDatabase extends _$LocalDatabase { // _$LocalDatabase는 Drift에서 생성된 클래스
  LocalDatabase() : super(_openConnection());

  Future<Schedule> getScheduleById(int id) =>
      (select(schedules)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<int> creatSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  removeSchedule(int id) => (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> updateSchedule(int id, SchedulesCompanion data) =>
      (update(schedules)..where((tbl) => tbl.id.equals(id))).write(data);

  Stream<List<ScheduleWithColor>> watchSchedules(DateTime date) {
    final query = select(schedules).join([
      innerJoin(categoryColors, categoryColors.id.equalsExp(schedules.colorID))
    ]);
    query.where(schedules.date.equals(date));
    query.orderBy([OrderingTerm(expression: schedules.startTime)]);
    return query.watch().map((rows) => rows.map((row) {
      return ScheduleWithColor(
        schedule: row.readTable(schedules),
        categoryColor: row.readTable(categoryColors),
      );
    }).toList());
    // return (select(schedules)
    //   ..where((tbl) => tbl.date.equals(date))) // ..은 리턴대상이 select(schedules)로 만들어 주는 역할이다
    //   .watch();
  }


  @override
  int get schemaVersion => 1; // 데이터베이스 스키마 버전
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}