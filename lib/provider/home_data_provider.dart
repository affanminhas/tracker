import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tracker/database/db_handler.dart';
import 'package:tracker/model/tracker_data_model.dart';
class HomeProvider extends ChangeNotifier{
  DBHelper? dbHelper = DBHelper();
  Future<List<TrackerDataModel>>? _trackData;
  int _income = 0;
  int _expense = 0;

  Future<List<TrackerDataModel>>? get getDataFromDevice{
    _trackData = dbHelper!.getNotesList();
    return _trackData;
  }

  int get totalExpense{
    getNumber();
    return _expense;
  }

  int get totalIncome{
    getNumber();
    return _income;
  }

  void getNumberChart(){
    //var data = dbHelper?.getNotesListOnly();
    int expense = 0;
    int income = 0;
    dbHelper?.getNotesListOnly().then((value){
      for(int i=0; i<(value.length); i++){
        if(value[i]['expense'] == "Expense"){
          expense = expense + 1;
        }else if(value[i]['expense'] == "Income"){
          income = income + 1;
        }
      }
      setExpense(expense);
      setIncome(income);
    });
  }

  void getNumber(){
    //var data = dbHelper?.getNotesListOnly();
    int expense = 0;
    int income = 0;
    dbHelper?.getNotesList().then((value){
      for(int i=0; i<(value.length); i++){
        if(value[i].expense == "Expense"){
          expense = expense + 1;
        }else if(value[i].expense == "Income"){
          income = income + 1;
        }
      }
      setExpense(expense);
      setIncome(income);
    });
  }

  void setExpense(int expense){
    _expense = expense;
    notifyListeners();
  }
  void setIncome(int income){
    _income = income;
    notifyListeners();
  }
}