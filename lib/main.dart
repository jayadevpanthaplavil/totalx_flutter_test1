import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:statusbarz/statusbarz.dart';
import 'package:totalx_flutter_test1/providers/provider_setup.dart';
import 'package:totalx_flutter_test1/theme/app_theme.dart';
import 'package:totalx_flutter_test1/tools/screen_size.dart';
import 'package:totalx_flutter_test1/tools/smart_dialog_config.dart';
import 'package:totalx_flutter_test1/utils/routes/route_names.dart';
import 'package:totalx_flutter_test1/utils/routes/routes.dart';
import 'package:totalx_flutter_test1/utils/utils.dart';

import 'constants/app_colors.dart';
import 'constants/app_strings.dart';
import 'constants/fonts.gen.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        printLog(
          'appLifeCycleState inactive',
          name: "MainApp",
        );
        break;
      case AppLifecycleState.resumed:
        printLog(
          'appLifeCycleState resumed',
          name: "MainApp",
        );
        // await InternetConnectionCheckerService.instance.start();
        break;
      case AppLifecycleState.paused:
        printLog(
          'appLifeCycleState paused',
          name: "MainApp",
        );
        // await InternetConnectionCheckerService.instance.stop();
        break;
      case AppLifecycleState.detached:
        printLog(
          'appLifeCycleState detached',
          name: "MainApp",
        );
        break;
      case AppLifecycleState.hidden:
        printLog(
          'appLifeCycleState hidden',
          name: "MainApp",
        );
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: providers,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return StatusbarzCapturer(
            theme: AppTheme.kcStatusbarTheme,
            child: MaterialApp(
              title: AppStrings.appName,
              scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
              theme: ThemeData(
                useMaterial3: false,
                primarySwatch: generateMaterialColor(Palette.primary),
                fontFamily: FontFamily.montserrat,
                appBarTheme: AppBarTheme.of(context).copyWith(
                  backgroundColor: Palette.scaffoldBackgroundColor,
                ),
                scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
                bottomSheetTheme: const BottomSheetThemeData(
                  // clipBehavior: Clip.hardEdge,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(20),
                  //     topRight: Radius.circular(20),
                  //   ),
                  // ),
                ),
              ),
              builder:
              FlutterSmartDialog.init(
                builder: (context, child) {
                  ScreenSize.init(context);
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                    child: child!,
                  );
                },
                toastBuilder: toastBuilder,
                loadingBuilder: loadingBuilder,
              ),
              initialRoute: RouteNames.splashScreen,
              onGenerateRoute: Routes.generateRoutes,
              navigatorObservers: [
                Statusbarz.instance.observer,
                FlutterSmartDialog.observer,
              ],
            ),
          );
        },
      ),
    );
  }
}
