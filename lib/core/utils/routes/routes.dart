import 'package:flutter/material.dart';
import 'package:totalx_flutter_test1/core/utils/routes/route_names.dart';
import 'package:totalx_flutter_test1/ui/screens/home/home_view.dart';
import 'package:totalx_flutter_test1/ui/screens/login_and_verify_otp/login_and_verify_otp_view.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case (RouteNames.home):
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());
      case (RouteNames.login):
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginAndVerifyOtpView());

      // default:
      //   return MaterialPageRoute(
      //     builder: (_) => const Scaffold(
      //       body: Center(
      //         child: Text("No route is configured"),
      //       ),
      //     ),
      //   );
    }
    // If the route is not found, throw an error or handle it as needed
    throw Exception('Route not found: ${settings.name}');
  }
}
