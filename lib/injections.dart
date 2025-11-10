import 'package:barberzlink/core/routes/app_routes.dart';

class Injections {
  // Private constructor
  Injections._privateConstructor();

  // Singleton instance
  static final Injections _instance = Injections._privateConstructor();

  // Getter for singleton
  static Injections get instance => _instance;

  // ========================
  // ✅ App State Data
  // ========================

  final List<String> states = [
    'All States',
    'AL',
    'AK',
    'AZ',
    'AR',
    'CA',
    'CO',
    'CT',
    'DE',
    'FL',
    'GA',
    'HI',
    'ID',
    'IL',
    'IN',
    'IA',
    'KS',
    'KY',
    'LA',
    'ME',
    'MD',
    'MA',
    'MI',
    'MN',
    'MS',
    'MO',
    'MT',
    'NE',
    'NV',
    'NH',
    'NJ',
    'NM',
    'NY',
    'NC',
    'ND',
    'OH',
    'OK',
    'OR',
    'PA',
    'RI',
    'SC',
    'SD',
    'TN',
    'TX',
    'UT',
    'VT',
    'VA',
    'WA',
    'WV',
    'WI',
    'WY'
  ];

  final List<Map<String, String>> registrationOptions = const [
    {
      'title': 'BARBERSHOPS',
      'subtitle': 'Looking to hire a barber? Post your job openings.',
      'image': 'assets/images/barber_shop.jpg',
      'route': AppRoutes.barberShop_registration,
    },
    {
      'title': 'BARBERS',
      'subtitle': 'Are you a Barber? Looking for work?',
      'image': 'assets/images/barbers.jpg',
      'route': AppRoutes.onboarding,
    },
    {
      'title': 'SCHOOLS',
      'subtitle': 'Feature your students for job opportunities.',
      'image': 'assets/images/schools.jpg',
      'route': AppRoutes.onboarding,
    },
    {
      'title': 'EVENTS',
      'subtitle': 'Register your events and workshops.',
      'image': 'assets/images/events.jpg',
      'route': AppRoutes.event_registration,
    },
  ];
}
