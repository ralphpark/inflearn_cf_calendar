import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inflearn_cf_scheduler/const/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.label, required this.isTime});
  final String label;
  final bool isTime;

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
    return TextField(
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime ? [
        FilteringTextInputFormatter.digitsOnly,
      ] : [],
      cursorColor: Colors.grey,
      maxLines: isTime ? 1 : null,
      expands: !isTime,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
      ),
    );
  }
}
