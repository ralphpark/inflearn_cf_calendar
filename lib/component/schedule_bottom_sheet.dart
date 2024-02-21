import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:inflearn_cf_scheduler/component/custom_text_field.dart';
import 'package:inflearn_cf_scheduler/const/colors.dart';
import 'package:inflearn_cf_scheduler/model/category_color.dart';

import '../database/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key, required this.selectedDay, this.scheduleId});
  final DateTime selectedDay;
  final int? scheduleId;

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorID;

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        MediaQuery.of(context).viewInsets.bottom; // 키보드가 올라오면서 생기는 공간
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: FutureBuilder<Schedule>(
          future: widget.scheduleId == null
              ? null
              : GetIt.I<LocalDatabase>().getScheduleById(widget.scheduleId!),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Text('스케줄을 불러올수 없습니다.'),
            );
          }
          if(snapshot.connectionState != ConnectionState.none &&
              !snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData && startTime == null){
            startTime = snapshot.data!.startTime;
            endTime = snapshot.data!.endTime;
            content = snapshot.data!.content;
            selectedColorID = snapshot.data!.colorID;
          }
              return SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5 + bottomInset,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: bottomInset),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Time(
                              onStartSaved: (String? value) {
                                startTime = int.parse(value!);
                              },
                              onEndSaved: (String? value) {
                                endTime = int.parse(value!);
                              },
                              startInitialValue: startTime?.toString() ?? '',
                              endInitialValue: endTime?.toString() ?? '',
                            ),
                            const SizedBox(height: 16.0),
                            _Content(
                              initialContent: content ?? '',
                              onSaved: (String? value) {
                                content = value;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            FutureBuilder<List<CategoryColor>>(
                              future: GetIt.I<LocalDatabase>().getCategoryColors(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    selectedColorID == null &&
                                    snapshot.data!.isNotEmpty) {
                                  selectedColorID = snapshot.data![0].id;
                                }
                                return ColorPicker(
                                  selectedColorID: selectedColorID,
                                  colorIdSetter: (int id) {
                                    setState(() {
                                      selectedColorID = id;
                                    });
                                  },
                                  colors: snapshot.hasData ? snapshot.data! : [],
                                );
                              },
                            ),
                            const SizedBox(height: 8.0),
                            _SaveButton(
                              onPressed: onSavePressed,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
    );
  }

  void onSavePressed() async {
    if (formKey.currentState == null) {
      return;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print('에러가 없습니다');
      if(widget.scheduleId == null){
        await GetIt.I<LocalDatabase>().creatSchedule(SchedulesCompanion(
          date: Value(widget.selectedDay),
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          colorID: Value(selectedColorID!),
        ));
      } else {
        await GetIt.I<LocalDatabase>().updateSchedule(widget.scheduleId!, SchedulesCompanion(date: Value(widget.selectedDay),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorID: Value(selectedColorID!)
        ));
      }

      Navigator.of(context).pop();
    } else {
      print('에러가 있습니다');
      formKey.currentState!.validate();
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final String startInitialValue;
  final String endInitialValue;

  const _Time(
      {super.key, required this.onStartSaved, required this.onEndSaved, required this.startInitialValue, required this.endInitialValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          initialValue: startInitialValue,
          label: '시작시간',
          isTime: true,
          onSaved: onStartSaved,
        )),
        const SizedBox(width: 16.0),
        Expanded(
            child: CustomTextField(
          initialValue: endInitialValue,
          label: '마감시간',
          isTime: true,
          onSaved: onEndSaved,
        )),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key, required this.onSaved, required this.initialContent});

  final FormFieldSetter<String> onSaved;
  final String initialContent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CustomTextField(
      initialValue: initialContent,
      onSaved: onSaved,
      label: '내용',
      isTime: false,
    ));
  }
}

typedef ColorIdSetter = void Function(int id);

class ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;
  final int? selectedColorID;
  final ColorIdSetter colorIdSetter;

  const ColorPicker(
      {super.key, required this.colors, required this.selectedColorID, required this.colorIdSetter});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: colors
          .map(
            (color) => GestureDetector(
              onTap: () {
                colorIdSetter(color.id);
              },
              child: renderColor(color, selectedColorID == color.id),
            ),
          )
          .toList(),
    );
  }

  Widget renderColor(CategoryColor color, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: Color(
          int.parse(
            'FF${color.hexCode}',
            radix: 16,
          ),
        ),
        border: isSelected
            ? Border.all(
                color: Colors.black,
                width: 4.0,
              )
            : null,
        shape: BoxShape.circle,
      ),
      width: 32,
      height: 32,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PrimaryColor,
            ),
            onPressed: onPressed,
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}
