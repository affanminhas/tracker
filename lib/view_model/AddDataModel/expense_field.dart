import 'package:flutter/material.dart';
import 'package:tracker/res/colors.dart';

class ExpenseField extends StatefulWidget {
  @override
  State<ExpenseField> createState() => _ExpenseFieldState();
}

class _ExpenseFieldState extends State<ExpenseField> {
  final entries = [
    "Expense",
    "Income"
  ];

  String? currentValue = "Expense";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(15)
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentValue,
              isExpanded: true,
              iconSize: 36,
              icon: const Icon(Icons.keyboard_arrow_down_sharp),
              items: entries.map(buildMenuItems).toList(),
              onChanged: (value){
                setState(() {
                  currentValue = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItems(String item){
    return DropdownMenuItem(
      value: item,
      child: Text(item, style: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        color: AppColor.greyColor
      ),),
    );
  }
}
