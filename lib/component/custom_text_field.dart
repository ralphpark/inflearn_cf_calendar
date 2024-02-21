import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inflearn_cf_scheduler/const/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.label, required this.isTime, required this.onSaved, required this.initialValue});
  final String label;
  final String initialValue;
  final bool isTime;
  final FormFieldSetter<String> onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(
          color: PrimaryColor,
          fontWeight: FontWeight.w600,
        ),),
        if(isTime) renderTextField(),
        if(!isTime) Expanded(child: renderTextField()),
      ],
    );
  }
  Widget renderTextField() {
    return TextFormField( // Form을 사용하면 입력값을 검증할 수 있다
      onSaved: onSaved,
      validator: (String? value) {
        if(value == null || value.isEmpty){
          return '내용을 입력해주세요';
        }
        if(isTime){
          int time = int.parse(value);
          if(time < 0 || time > 24){
            return '0~24 사이의 숫자를 입력해주세요';
          }
        }else{
          if(value.length > 600){
            return '600자 이내로 입력해주세요';
          }
        }

        return null;
      },
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      maxLength: 600,
      inputFormatters: isTime ? [
        FilteringTextInputFormatter.digitsOnly,
      ] : [],
      cursorColor: Colors.grey,
      maxLines: isTime ? 1 : null,
      expands: !isTime,
      initialValue: initialValue,
      decoration: InputDecoration(
        suffixText: isTime ? '시' : null,
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
      ),
    );
  }
}
