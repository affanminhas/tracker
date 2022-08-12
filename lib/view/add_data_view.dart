import 'package:flutter/material.dart';
import 'package:tracker/res/colors.dart';
import 'package:tracker/view_model/AddDataModel/title_field.dart';

import '../animations/textfield_animation/custom_shake_widget.dart';

class AddView extends StatefulWidget {
  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  late GlobalKey<FormState> _formKey;
  late GlobalKey<CustomShakeWidgetState> _titleIDState;
  late TextEditingController _titleEditingController;

  @override
  void initState() {
    _formKey = GlobalKey();
    _titleIDState = GlobalKey();
    _titleEditingController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _formKey.currentState?.dispose();
    _titleIDState.currentState?.dispose();
    _titleEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
    );
  }
}
