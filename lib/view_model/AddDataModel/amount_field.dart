import 'package:flutter/material.dart';
import 'package:tracker/res/colors.dart';
import '../../animations/textfield_animation/custom_shake_widget.dart';

class AmountField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final GlobalKey<CustomShakeWidgetState> amountIDState;

  AmountField(
      {required this.controller,
        required this.title,
        required this.amountIDState});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: (currentValue) {
          var nonNullable = currentValue ?? "";
          if (nonNullable.isEmpty) {
            amountIDState.currentState?.shake();
            return "Amount field can't be empty!";
          }
          return null;
        },
        readOnly: true,
        showCursor: true,
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
