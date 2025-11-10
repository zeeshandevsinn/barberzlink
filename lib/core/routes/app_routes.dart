// lib/routes/app_routes.dart

import 'package:barberzlink/view/authtentication/login/login_screen.dart';
import 'package:barberzlink/view/events/event_registration_screen.dart';
import 'package:barberzlink/view/onboarding/onboarding_screen.dart';
import 'package:barberzlink/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../view/authtentication/register/selection/registeration_selection_screen.dart';
import '../../view/barbers_shop/barbershop_register_screen.dart';
import '../../view/home/home_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register_selection = '/register_selection';
  static const String event_registration = '/event/registration';
  static const String barberShop_registration = '/barberShop/registration';

  static const String home = '/home';

  // Route map
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    register_selection: (context) => const RegistrationSelectionScreen(),
    event_registration: (context) => const EventRegisterScreen(),
    barberShop_registration: (context) => const BarberShopRegistrationScreen(),
  };

  // Navigate helper
  static void goTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static void goToReplace(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }
}
