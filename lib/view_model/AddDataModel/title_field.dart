import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracker/res/colors.dart';
import '../../animations/textfield_animation/custom_shake_widget.dart';
import '../../controller/textfield_focus.dart';
import '../../utils/Utils.dart';

class TitleField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final GlobalKey<CustomShakeWidgetState> titleIDStateKeyVal;

  TitleField(
      {required this.controller,
        required this.title,
        required this.titleIDStateKeyVal});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: (currentValue) {
          var nonNullable = currentValue ?? "";
          if (nonNullable.isEmpty) {
            titleIDStateKeyVal.currentState?.shake();
            return "Title field can't be empty!";
          }
          return null;
        },
        // onFieldSubmitted: (value) {
        //   Utils.fieldFocusChange(
        //       context, TextFieldFocus.titleFocus, TextFieldFocus.descriptionFocus);
        // },
        inputFormatters: [
          LengthLimitingTextInputFormatter(30),
        ],
        onChanged: (value){
          if (value.length == 30) {
            Utils.showFlushBarErrorMessages("You can't write more than 30 characters", context);
          }
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            isDense: true,
            hintText: title,
            hintStyle: const TextStyle(fontFamily: "Poppins", color: AppColor.greyColor, fontSize: 16),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15))));
  }
}
