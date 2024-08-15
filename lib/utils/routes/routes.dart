import 'package:flutter/material.dart';
import 'package:totalx_flutter_test1/utils/routes/route_names.dart';


class Routes {

  static const homeView = '/home-view';

  static const splashView = '/splash-view';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // case (RouteNames.home):
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const HomeScreen());
      // case (RouteNames.login):
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const LoginScreen());
      // case (RouteNames.signupScreen):
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const SignUpScreen());
      // case (RouteNames.splashScreen):
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const SplashScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No route is configured"),
            ),
          ),
        );
    }
  }
}