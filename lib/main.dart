import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/injections.dart';
import 'dart:io' as io;

import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize all dependencies and data
  await Injections.instance.initialize();

  // ✅ Platform-specific system UI setup
  await _setSystemUIOverlayStyle();

  runApp(const MyApp());
}

/// Set system UI overlay style (supports both Web and native platforms)
Future<void> _setSystemUIOverlayStyle() async {
  // For Web platform, skip these settings
  if (kIsWeb) {
    return;
  }

  // Only import and use dart:io on native platforms
  // Using conditional import to avoid compile errors
  // ignore: conditional_uri_directives
  if (!kIsWeb) {
    // ignore: uri_does_not_exist

    if (io.Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else if (io.Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ));
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BarberzLink',
            theme: AppTheme.lightTheme,
            initialRoute: AppRoutes.splash,
            routes: AppRoutes.routes,
          );
        });
      },
    );
  }
}

// Import your widget file
