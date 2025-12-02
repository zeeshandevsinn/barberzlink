import 'package:barberzlink/view/main/search_explore/search_explore_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/injections.dart';
import 'dart:io' as io;

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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BarberzLink',
          theme: AppTheme.lightTheme,
          initialRoute: AppRoutes.splash,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}

// Import your widget file

// class FindCatGamePage extends StatelessWidget {
//   const FindCatGamePage({super.key});

//   // Example images
//   final String catImage =
//       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safecartnewtheme-kk5z3w/assets/faozts170ung/0l3oah.png';
//   final String otherImage =
//       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safecartnewtheme-kk5z3w/assets/cr0d4zh4slh1/5088ru.png';
//   final String bucketClosed =
//       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safecartnewtheme-kk5z3w/assets/88q1alhvl7p9/image_2025-11-03_172522851-removebg-preview_(1).png';
//   final String bucketOpen =
//       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safecartnewtheme-kk5z3w/assets/88q1alhvl7p9/image_2025-11-03_172522851-removebg-preview_(1).png';

//   Future<void> onWin() async {
//     // Show a dialog or navigate to next level
//     print('You found the cat!');
//   }

//   Future<void> onFail() async {
//     // Show a dialog or retry
//     print('Oops! Wrong choice.');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Find the Cat Game'),
//       ),
//       body: Center(
//         child: FindCatLevel2(
//           catImage: catImage,
//           otherImage: otherImage,
//           bucketClosed: bucketClosed,
//           bucketOpen: bucketOpen,
//           onWin: onWin,
//           onFail: onFail,
//         ),
//       ),
//     );
//   }
// }
