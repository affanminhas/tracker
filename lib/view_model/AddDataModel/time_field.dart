import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../animations/textfield_animation/custom_shake_widget.dart';
import '../../controller/textfield_focus.dart';
import '../../utils/Utils.dart';

class TimeField extends StatelessWidget {
  final String title;

  TimeField({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: TextFieldFocus.titleFocus,
        enabled: false,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            isDense: true,
            hintText: title,
            hintStyle: const TextStyle(fontFamily: "Poppins"),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15))));
  }
}
