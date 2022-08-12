import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/utils/routes/route_name.dart';

import '../utils/routes/routes.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(),
      initialRoute: RoutesName.addData,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
