import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddDataProvider extends ChangeNotifier{
  static final DateTime currentDate = DateTime.now();
  String? _date;
  String? time;
  String totalAmount = "";
  String _currentValue = "Expense";
  TextEditingController _amountEditingController = TextEditingController(text: "");
  final TextEditingController _dateEditingController = TextEditingController(text: "");
  final TextEditingController _timeEditingController = TextEditingController(text: "");


  String get currentDateNow => formatDate(currentDate);

  /// --- Getting amount from text field ---
  TextEditingController get amountController => _amountEditingController;

  /// --- Getting date ---
  TextEditingController get dateController => _dateEditingController;

  /// --- Getting time ---
  TextEditingController get timeController => _timeEditingController;

  /// --- Getting expense ---
  String get expenseField => _currentValue;

  /// --- Setting date ---
  void setDate(String dateTime){
    _dateEditingController.text = dateTime;
    notifyListeners();
  }

  /// --- Setting time ---
  void setTime(String dateTime){
    _timeEditingController.text = dateTime;
    notifyListeners();
  }

  /// --- Setting expense field ---
  void setExpenseField(String newValue){
    _currentValue = newValue;
    notifyListeners();
  }

  /// --- Setting amount field to null ---
  void setAmountFieldEmpty(){
    _amountEditingController.text = "";
    totalAmount = "";
    notifyListeners();
  }

  /// --- Setting amount in text field ---
  void setAmountField(String amount){
    if (checkCursorPosition() == -1){
      totalAmount += amount;
      _amountEditingController.text = totalAmount;
      notifyListeners();
    }else{
      final cursorPosition = checkCursorPosition();
      /// --- Get the left text of the cursor ---
      String prefixText = _amountEditingController.text.substring(0,checkCursorPosition());
      /// --- Get the right text of the cursor ---
      String suffixText = _amountEditingController.text.substring(checkCursorPosition());
      /// --- New text to add ---
      String newText = amount;
      totalAmount = prefixText + newText + suffixText;
      _amountEditingController.text = totalAmount;
      _amountEditingController.selection = TextSelection(
        baseOffset: cursorPosition + 1,
        extentOffset: cursorPosition + 1,
      );
      notifyListeners();
    }
  }

  void setAmountFieldOnDelete(){
    if(_amountEditingController.text != "" && checkCursorPosition() == -1){
      totalAmount = totalAmount.substring(0, totalAmount.length - 1);
      _amountEditingController.text = totalAmount;
      notifyListeners();
    }else if(_amountEditingController.text != "" && checkCursorPosition() != 0){
      final cursorPosition = checkCursorPosition();
      /// --- Get the left text of the cursor ---
      String prefixText = _amountEditingController.text.substring(0,checkCursorPosition()-1);
      /// --- Get the right text of the cursor --- 
      String suffixText = _amountEditingController.text.substring(checkCursorPosition());
      totalAmount = prefixText + suffixText;
      _amountEditingController.text = totalAmount;
      _amountEditingController.selection = TextSelection(
        baseOffset: cursorPosition - 1,
        extentOffset: cursorPosition - 1,
      );
      notifyListeners();
    }
  }

  checkCursorPosition(){
    var cursorPos =  _amountEditingController.selection.base.offset;
    return cursorPos;
  }


  String formatDate(DateTime date){
    String convertedDateTime = '${date.day.toString()} ${date.month.toString()},${date.year.toString()}';
    return convertedDateTime;
  }
}