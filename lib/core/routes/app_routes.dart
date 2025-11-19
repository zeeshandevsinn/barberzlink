// lib/routes/app_routes.dart

import 'package:barberzlink/view/authtentication/login/login_screen.dart';
import 'package:barberzlink/view/authtentication/register/register_screen.dart';
import 'package:barberzlink/view/events/event_registration_screen.dart';
import 'package:barberzlink/view/events/event_search_screen.dart';
import 'package:barberzlink/view/main/main_page.dart';
import 'package:barberzlink/view/new_product/new_product_registration.dart';
import 'package:barberzlink/view/new_product/new_product_search_screen.dart';
import 'package:barberzlink/view/new_product/product_details.dart';
import 'package:barberzlink/view/onboarding/onboarding_screen.dart';
import 'package:barberzlink/view/payment/barbers/barber_payment_plan_screen.dart';
import 'package:barberzlink/view/schools/school_registration_screen.dart';
import 'package:barberzlink/view/schools/school_search_screen.dart';
import 'package:barberzlink/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../view/barbers/barbers_registration_screen.dart';
import '../../view/barbers/barbers_search_screen.dart';
import '../../view/barbers_shop/barbershop_register_screen.dart';
import '../../view/barbers_shop/barbershop_search_screen.dart';
import '../../view/payment/barbershop/barbershop_payment_plan_screen.dart';
import '../../view/payment/events/event_payment_plan_screen.dart';
import '../../view/payment/payment_plans_screen.dart';
import '../../view/payment/schools/school_payment_plan_screen.dart';

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
  static const String payment_plans = '/payment/plans';
  static const String barber_payment = '/payment/barber';
  static const String event_payment = '/payment/event';
  static const String school_payment = '/payment/school';
  static const String barberShop_payment = '/payment/barberShop';
  static const String newProductRegister = '/new_product/register';
  static const String newProductSearch = '/new_product/search';
  static const String productDetails = '/product/details';

  static const String dashboard = '/dashboard';

  // Route map
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    login: (context) => const LoginScreen(),
    dashboard: (context) => const MainPage(),
    registration: (context) => const RegistrationScreen(),
    event_registration: (context) => const EventRegisterScreen(),
    barberShop_registration: (context) => const BarberShopRegistrationScreen(),
    barber_registration: (context) => const BarberRegistrationScreen(),
    barberShop_search: (context) => const BarbershopSearchScreen(),
    barber_search: (context) => const BarbersSearchScreen(),
    school_registration: (context) => const SchoolRegistrationScreen(),
    event_search: (context) => const EventSearchScreen(),
    school_search: (context) => const SchoolSearchScreen(),
    payment_plans: (context) {
      // Get user type from arguments if provided
      final args = ModalRoute.of(context)?.settings.arguments;
      final userType = args is String ? args : null;
      return PaymentPlansScreen(userType: userType);
    },
    barber_payment: (context) => const BarberPaymentPlanScreen(),
    event_payment: (context) => const EventPaymentPlanScreen(),
    school_payment: (context) => const SchoolPaymentPlanScreen(),
    barberShop_payment: (context) => const BarberShopPaymentPlanScreen(),
    newProductRegister: (context) => const NewProductRegistration(),
    newProductSearch: (context) => const NewProductSearchScreen(),
    productDetails: (context) => const ProductDetailsPage(),
  };

  // Navigate helper
  static void goTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static void goToReplace(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  static void goToPaymentPlans(BuildContext context, {String? userType}) {
    Navigator.pushNamed(
      context,
      payment_plans,
      arguments: userType,
    );
  }
}
