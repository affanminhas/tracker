import 'dart:ui';
import 'package:flutter/material.dart';
import '../../animations/textfield_animation/custom_shake_widget.dart';
import '../../controller/textfield_focus.dart';
import '../../utils/Utils.dart';

class TitleField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final GlobalKey<CustomShakeWidgetState> titleIDState;

  TitleField(
      {required this.controller,
      required this.title,
      required this.titleIDState});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        focusNode: TextFieldFocus.titleFocus,
        validator: (currentValue) {
          var nonNullable = currentValue ?? "";
          if (nonNullable.isEmpty) {
            titleIDState.currentState?.shake();
            return "Title field can't be empty!";
          }
          return null;
        },
        onFieldSubmitted: (value) {
          Utils.fieldFocusChange(
              context, TextFieldFocus.titleFocus, TextFieldFocus.descriptionFocus);
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            isDense: true,
            hintText: title,
            hintStyle: const TextStyle(fontFamily: "Poppins"),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20))));
  }
}
