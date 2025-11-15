// lib/routes/app_routes.dart

import 'package:barberzlink/view/authtentication/login/login_screen.dart';
import 'package:barberzlink/view/authtentication/register/register_screen.dart';
import 'package:barberzlink/view/events/event_registration_screen.dart';
import 'package:barberzlink/view/events/event_search_screen.dart';
import 'package:barberzlink/view/main/main_page.dart';
import 'package:barberzlink/view/onboarding/onboarding_screen.dart';
import 'package:barberzlink/view/schools/school_registration_screen.dart';
import 'package:barberzlink/view/schools/school_search_screen.dart';
import 'package:barberzlink/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../view/barbers/barbers_registration_screen.dart';
import '../../view/barbers/barbers_search_screen.dart';
import '../../view/barbers_shop/barbershop_register_screen.dart';
import '../../view/barbers_shop/barbershop_search_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String event_registration = '/event/registration';
  static const String barberShop_registration = '/barberShop/registration';
  static const String barberShop_search = '/barberShop/search';
  static const String barber_registration = '/barber/registration';
  static const String barber_search = '/barber/search';
  static const String school_registration = '/school/registration';
  static const String school_search = '/school/search';
  static const String event_search = '/event/search';

  static const String home = '/home';

  // Route map
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    login: (context) => const LoginScreen(),
    home: (context) => const MainPage(),
    registration: (context) => const RegistrationScreen(),
    event_registration: (context) => const EventRegisterScreen(),
    barberShop_registration: (context) => const BarberShopRegistrationScreen(),
    barber_registration: (context) => const BarberRegistrationScreen(),
    barberShop_search: (context) => const BarbershopSearchScreen(),
    barber_search: (context) => const BarbersSearchScreen(),
    school_registration: (context) => const SchoolRegistrationScreen(),
    event_search: (context) => const EventSearchScreen(),
    school_search: (context) => const SchoolSearchScreen(),
  };

  // Navigate helper
  static void goTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static void goToReplace(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }
}
