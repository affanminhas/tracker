import 'package:flutter/material.dart';
import 'package:tracker/utils/routes/route_name.dart';
import 'package:tracker/view/add_data_view.dart';

import '../../view/home_view.dart';
import '../../view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case RoutesName.addData:
        return MaterialPageRoute(builder: (_) => AddView());
      case RoutesName.home:
        return MaterialPageRoute(builder: (_) => const HomeView());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No Route Defined"),
            ),
          );
        });
    }
  }
}
