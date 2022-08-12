import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red
    );
  }

  static void showFlushBarErrorMessages(String message, BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      message: message,
      forwardAnimationCurve: Curves.decelerate,
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: const EdgeInsets.all(15),
      reverseAnimationCurve: Curves.easeInOut,
      positionOffset: 20,
      icon: const Icon(Icons.error, color: Colors.white,),
      backgroundColor: const Color(0xffC0945A),
      borderRadius: BorderRadius.circular(15),
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context));
  }

  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}