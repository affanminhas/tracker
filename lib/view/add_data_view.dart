import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tracker/model/tracker_data_model.dart';
import 'package:tracker/utils/Utils.dart';
import 'package:tracker/utils/routes/route_name.dart';
import '../animations/textfield_animation/custom_shake_widget.dart';
import '../animations/textfield_animation/custom_shake_widget.dart';
import 'package:tracker/res/colors.dart' as app_color;

import '../animations/textfield_animation/custom_shake_widget.dart';
import '../database/db_handler.dart';
import '../provider/add_data_provider.dart';
import '../res/colors.dart';
import '../view_model/AddDataModel/amount_field.dart';
import '../view_model/AddDataModel/amount_keyboard.dart';
import '../view_model/AddDataModel/date_field.dart';
import '../view_model/AddDataModel/description_field.dart';
import '../view_model/AddDataModel/expense_field.dart';
import '../view_model/AddDataModel/time_field.dart';
import '../view_model/AddDataModel/title_field.dart';
import 'home_view.dart';

class AddView extends StatefulWidget {
  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  late GlobalKey<FormState> _formKey;
  late GlobalKey<CustomShakeWidgetState> _titleIDKeyState;
  late GlobalKey<CustomShakeWidgetState> _descriptionIDState;
  late GlobalKey<CustomShakeWidgetState> _amountIDKeyState;
  late TextEditingController _titleEditingController;
  late TextEditingController _descriptionEditingController;
  late TextEditingController _amountEditingController;
  DBHelper? dbHelper;

  @override
  void initState() {
    _formKey = GlobalKey();
    _titleIDKeyState = GlobalKey();
    _descriptionIDState = GlobalKey();
    _amountIDKeyState = GlobalKey();
    _titleEditingController = TextEditingController(text: "");
    _descriptionEditingController = TextEditingController(text: "");
    _amountEditingController = TextEditingController(text: "");
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _formKey.currentState?.dispose();
    _titleIDKeyState.currentState?.dispose();
    _descriptionIDState.currentState?.dispose();
    _amountIDKeyState.currentState?.dispose();
    _titleEditingController.dispose();
    _descriptionEditingController.dispose();
    _amountEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addDataProvider = Provider.of<AddDataProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            if (addDataProvider.dateController.text != "" &&
                addDataProvider.timeController.text != "") {
              dbHelper
                  ?.insert(TrackerDataModel(
                      title: _titleEditingController.text,
                      description: _descriptionEditingController.text,
                      date: addDataProvider.dateController.text,
                      time: addDataProvider.timeController.text,
                      expense: addDataProvider.expenseField,
                      amount: addDataProvider.amountController.text))
                  .then((value) {
                Navigator.pushNamed(context, RoutesName.home);
              });
            } else {
              Utils.showFlushBarErrorMessages(
                  "Date and time required!", context);
            }
          }
        },
        child: const Icon(
          Icons.check,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomShakeWidget(
                  key: _titleIDKeyState,
                  duration: const Duration(milliseconds: 800),
                  shakeCount: 4,
                  shakeOffset: 10,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TitleField(
                          controller: _titleEditingController,
                          title: "Title",
                          titleIDStateKeyVal: _titleIDKeyState)),
                ),
                CustomShakeWidget(
                  key: _descriptionIDState,
                  duration: const Duration(milliseconds: 800),
                  shakeCount: 4,
                  shakeOffset: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: DescriptionField(
                        controller: _descriptionEditingController,
                        title: "Description",
                        descriptionIDState: _descriptionIDState),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          pickDate(context);
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.date_range,
                            color: AppColor.greyColor,
                            size: 33,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(child: DateField(title: 'Date')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          pickTime(context);
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Image(
                            color: AppColor.greyColor,
                            image: AssetImage("images/clock_icon.png"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TimeField(
                        title: 'Time',
                      )),
                    ],
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.white),
                      child: ExpenseField(),
                    )),
                CustomShakeWidget(
                  key: _amountIDKeyState,
                  duration: const Duration(milliseconds: 800),
                  shakeCount: 4,
                  shakeOffset: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: AmountField(
                        controller: addDataProvider.amountController,
                        title: "Amount",
                        amountIDState: _amountIDKeyState),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: AmountKeyboard(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getFormatDate(DateTime date) {
    String convertedDateTime =
        '${date.day.toString()} ${DateFormat.LLLL().format(date)}, ${date.year.toString()}';
    return convertedDateTime;
  }

  Future pickDate(BuildContext context) async {
    final addDataProvider =
        Provider.of<AddDataProvider>(context, listen: false);
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate != null) {
      addDataProvider.setDate(getFormatDate(newDate));
    } else {
      return;
    }
  }

  Future pickTime(BuildContext context) async {
    final addDataProvider =
        Provider.of<AddDataProvider>(context, listen: false);
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (newTime != null) {
      addDataProvider.setTime(newTime.format(context));
    } else {
      return;
    }
  }
}
