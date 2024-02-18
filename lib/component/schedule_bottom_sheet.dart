import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inflearn_cf_scheduler/component/custom_text_field.dart';
import 'package:inflearn_cf_scheduler/const/colors.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom; // 키보드가 올라오면서 생기는 공간
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding:  EdgeInsets.only(bottom: bottomInset),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Time(),
                  const SizedBox(height: 16.0),
                  _Content(),
                  const SizedBox(height: 16.0),
                  ColorPicker(),
                  const SizedBox(height: 8.0),
                  _SaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class _Time extends StatelessWidget {
  const _Time({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CustomTextField(label: '시작시간',isTime: true,)),
        const SizedBox(width: 16.0),
        Expanded(child: CustomTextField(label: '마감시간',isTime: true,)),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: CustomTextField(label: '내용', isTime: false,));
  }
}
class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: [
        renderColor(Colors.red),
        renderColor(Colors.orange),
        renderColor(Colors.yellow),
        renderColor(Colors.green),
        renderColor(Colors.blue),
        renderColor(Colors.indigo),
        renderColor(Colors.purple),
      ],
    );
  }
  Widget renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 32,
      height: 32,
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PrimaryColor,
            ),
            onPressed: () {},
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}

