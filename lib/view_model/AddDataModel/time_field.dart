import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/add_data_provider.dart';
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
    final addDataProvider =
        Provider.of<AddDataProvider>(context, listen: false);
    return TextFormField(
        controller: addDataProvider.timeController,
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
