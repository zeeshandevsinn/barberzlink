// lib/routes/app_routes.dart

import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/models/job_model.dart';
import 'package:barberzlink/view/authtentication/login/login_screen.dart';
import 'package:barberzlink/view/authtentication/register/register_screen.dart';
import 'package:barberzlink/view/business_tips/business_tips_registration.dart';
import 'package:barberzlink/view/events/event_registration_screen.dart';
import 'package:barberzlink/view/events/event_search_screen.dart';
import 'package:barberzlink/view/main/job_board/job_board_barber_screen.dart';
import 'package:barberzlink/view/main/main_page.dart';
import 'package:barberzlink/view/main/job_board/job_detail_screen.dart';
import 'package:barberzlink/view/main/job_board/job_post_screen.dart';
import 'package:barberzlink/view/new_product/new_product_registration.dart';
import 'package:barberzlink/view/new_product/new_product_search_screen.dart';
import 'package:barberzlink/view/new_product/product_details.dart';
import 'package:barberzlink/view/onboarding/onboarding_screen.dart';
import 'package:barberzlink/view/payment/barbers/barber_payment_plan_screen.dart';
import 'package:barberzlink/view/security/privacy_policy_page.dart';
import 'package:barberzlink/view/security/term_condition_page.dart';
import 'package:barberzlink/view/schools/school_detailed_page.dart';
import 'package:barberzlink/view/schools/school_registration_screen.dart';
import 'package:barberzlink/view/schools/school_search_screen.dart';
import 'package:barberzlink/view/splash/splash_screen.dart';
import 'package:barberzlink/view/state_by_state/state_by_state_search_screen.dart';
import 'package:barberzlink/view/state_by_state/state_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../view/barbers/barber_detailed_page.dart';
import '../../view/barbers/barbers_registration_screen.dart';
import '../../view/barbers/barbers_search_screen.dart';
import '../../view/barbers_shop/barbershop_detail.dart';
import '../../view/barbers_shop/barbershop_register_screen.dart';
import '../../view/barbers_shop/barbershop_search_screen.dart';
import '../../view/events/event_detail_page.dart';
import '../../view/faq/faq_page.dart';
import '../../view/payment/barbershop/barbershop_payment_plan_screen.dart';
import '../../view/payment/events/event_payment_plan_screen.dart';
import '../../view/payment/payment_plans_screen.dart';
import '../../view/payment/schools/school_payment_plan_screen.dart';
import '../../view/main/search_explore/search_explore_screen.dart';
import 'package:barberzlink/view/main/profile/edit_profile_screen.dart';

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
  static const String edit_profile = '/profile/edit';
  static const String dashboard = '/dashboard';
  static const String job_board = '/jobs/board';
  static const String job_detail = '/jobs/detail';
  static const String job_post = '/jobs/post';
  static const String barber_detail = '/barber/detail';
  static const String barberShop_detail = '/barberShop/detail';
  static const String school_detail = '/school/detail';
  static const String event_detail = '/event/detail';
  static const String search_explore = '/search/explore';
  static const String state_by_state_details = "/state/details";
  static const String terms_and_conditions = "/terms_and_conditions";
  static const String privacy_policy = "/privacy_policy";
  static const String faq_page = "/faq";
  static const String state_by_state_search = "/state/search";
  static const String business_registration = "/business/registration";
  static const String business_search = "/business/search";
  static const String business_detail = "/business/detail";

  // Route map
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    login: (context) => const LoginScreen(),
    dashboard: (context) => MainPage(
          index: ModalRoute.of(context)!.settings.arguments as int? ?? 0,
        ),
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
    job_board: (context) => const JobBoardBarberScreen(),
    job_post: (context) => const JobPostScreen(),
    edit_profile: (context) => const EditProfileScreen(),
    job_detail: (context) {
      final job = ModalRoute.of(context)?.settings.arguments as JobModel?;
      return JobDetailsScreen(
        job: job ?? Injections.instance.jobsFeed.first,
      );
    },
    barber_detail: (context) => const BarberDetailPage(),
    barberShop_detail: (context) => const BarberShopDetailScreen(
          shopName: "Red Blade Barbershop",
          about:
              "At Red Blade Barbershop, we bring precision, style, and grooming excellence. "
              "With professional barbers and premium tools, our aim is to deliver a clean, modern, "
              "and sharp haircut experience that fits every personality.",
          address:
              "123 Main Street, Near Central Mall, West Avenue, Downtown Area, Lahore, Pakistan",
          city: "Lahore",
          state: "Punjab",
          phone: "+92 300 1234567",
          website: "www.redblade.com",
          instagram: "@redbladebarbers",
          services: [
            "Fade Cut",
            "Beard Trim",
            "Shave",
            "Hair Color",
            "Kids Cut",
            "Hot Towel",
          ],
          mainImage: AppStrings.barbershopImage, // dummy
          galleryImages: [
            AppStrings.barbershopImage,
            AppStrings.barbershopImage,
            AppStrings.barbershopImage,
            AppStrings.barbershopImage,
            AppStrings.barbershopImage,
            AppStrings.barbershopImage,
          ],
        ),
    event_detail: (context) => EventDetailScreen(
          eventName: "Flutter Dev Meetup",
          hostName: "Muhammad Zeeshan",
          startDate: DateTime(2025, 12, 25),
          endDate: DateTime(2025, 12, 25),
          startTime: const TimeOfDay(hour: 10, minute: 30),
          endTime: const TimeOfDay(hour: 15, minute: 0),
          imageUrl: AppStrings.eventImage, // sample image
        ),
    school_detail: (context) => const SchoolDetailScreen(
          firstName: "John",
          lastName: "Doe",
          email: "contact@barberacademy.com",
          username: "john_doe123",
          schoolName: "Barber Academy USA",
          fullAddress: "1234 Main Street, Suite 101",
          city: "Los Angeles, CA",
          about:
              "Barber Academy USA is a premier institution for professional barber training, offering courses in hair cutting, styling, and grooming. Our certified instructors provide hands-on experience to ensure students excel in the barber industry.",
          phone: "+1 310-555-1234",
          website: "https://www.barberacademyusa.com",
          mainImage: AppStrings.schoolImage, // local asset path
          galleryImages: [
            AppStrings.schoolImage,
            AppStrings.schoolImage,
            AppStrings.schoolImage,
          ],
        ),
    search_explore: (context) => const SearchExploreScreen(),
    state_by_state_details: (context) =>
        StateDetailScreen(state: Injections.instance.statesData.first),
    terms_and_conditions: (context) => const TermsAndConditionPage(),
    privacy_policy: (context) => const PrivacyPolicyPage(),
    faq_page: (context) => const FAQPage(),
    state_by_state_search: (context) => const StateByStateSearchScreen(),
    business_registration: (context) => const BusinessTipsRegistration(),
  };

  // Navigate helper
  static void goTo(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void goToReplace(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static void goToPaymentPlans(BuildContext context, {String? userType}) {
    Navigator.pushNamed(
      context,
      payment_plans,
      arguments: userType,
    );
  }
}
