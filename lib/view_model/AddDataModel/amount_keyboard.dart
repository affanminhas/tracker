import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/add_data_provider.dart';
import 'package:tracker/res/colors.dart';

class AmountKeyboard extends StatelessWidget {
  const AmountKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final amountProvider = Provider.of<AddDataProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                amountProvider.setAmountField("1");
              },
              child: keyboardButton("1"),
            ),
            const SizedBox(width: 10,),
            InkWell(
              onTap: (){
                amountProvider.setAmountField("2");
              },
              child: keyboardButton("2"),
            ),
            const SizedBox(width: 10,),
            InkWell(
              onTap: (){
                amountProvider.setAmountField("3");
              },
              child: keyboardButton("3"),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                amountProvider.setAmountField("4");
              },
              child: keyboardButton("4"),
            ),
            const SizedBox(width: 10,),
            InkWell(
              onTap: (){
                amountProvider.setAmountField("5");
              },
              child: keyboardButton("5"),
            ),
            const SizedBox(width: 10,),
            InkWell(
              onTap: (){
                amountProvider.setAmountField("6");
              },
              child: keyboardButton("6"),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                amountProvider.setAmountField("7");
              },
              child: keyboardButton("7"),
            ),
            const SizedBox(width: 10,),
            InkWell(
              onTap: (){
                amountProvider.setAmountField("8");
              },
              child: keyboardButton("8"),
            ),
            const SizedBox(width: 10,),
            InkWell(
              onTap: (){
                amountProvider.setAmountField("9");
              },
              child: keyboardButton("9"),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                amountProvider.setAmountField("0");
              },
              child: keyboardButton("0"),
            ),
            const SizedBox(width: 10,),
            InkWell(
              onTap: (){
                amountProvider.setAmountFieldOnDelete();
              },
              child: DeleteButton(title: "Delete")
            ),
          ],
        )
      ],
    );
  }
  Container keyboardButton(String number){
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: AppColor.greyColor.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(1, 4),
            )
          ]
      ),
      child: Center(
          child: Text(number, style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 20,
            color: AppColor.greyColor
          ),)
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  String title;
  DeleteButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 55,
      decoration: BoxDecoration(
          color: AppColor.redColor,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(1, 4),
            )
          ]
      ),
      child: Center(
          child: Text(title, style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 20,
              color: AppColor.whiteColor
          ),)
      ),
    );
  }
}

