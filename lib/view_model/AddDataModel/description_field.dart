import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracker/res/colors.dart';
import '../../animations/textfield_animation/custom_shake_widget.dart';
import '../../controller/textfield_focus.dart';
import '../../utils/Utils.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final GlobalKey<CustomShakeWidgetState> descriptionIDState;

  DescriptionField(
      {required this.controller,
        required this.title,
        required this.descriptionIDState});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: (currentValue) {
          var nonNullable = currentValue ?? "";
          if (nonNullable.isEmpty) {
            descriptionIDState.currentState?.shake();
            return "Description field can't be empty!";
          }
          return null;
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(100),
        ],
        onChanged: (value){
          if (value.length == 100) {
            Utils.showFlushBarErrorMessages("You can't write more than 100 letters", context);
          }
        },
        maxLines: 5,
        // onFieldSubmitted: (value) {
        //   Utils.fieldFocusChange(
        //       context, TextFieldFocus.titleFocus, TextFieldFocus.descriptionFocus);
        // },
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
