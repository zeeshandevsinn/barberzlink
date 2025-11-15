import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/routes/app_routes.dart';

class Injections {
  // 🔒 Private constructor
  Injections._privateConstructor();

  // 🧠 Singleton instance
  static final Injections _instance = Injections._privateConstructor();

  // 🌍 Public getter
  static Injections get instance => _instance;

  // ========================
  // ✅ App Initialization
  // ========================
  bool _isInitialized = false;

  /// Call this once in main.dart before running the app
  Future<void> initialize() async {
    if (_isInitialized) return;

    // 🧩 Example of future setup (you can expand as needed)
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate setup

    // Any API, Firebase, SharedPreferences or dependency setup can go here
    print("✅ Injections initialized successfully");

    _isInitialized = true;
  }

  // ========================
  // ✅ Static App Data
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
      'image': AppStrings.barbershopImage,
      'route': AppRoutes.barberShop_registration,
      'route_search': AppRoutes.barberShop_search
    },
    {
      'title': 'BARBERS',
      'subtitle': 'Are you a Barber? Looking for work?',
      'image': AppStrings.barberImage,
      'route': AppRoutes.barber_registration,
      "route_search": AppRoutes.barber_search
    },
    {
      'title': 'SCHOOLS',
      'subtitle': 'Feature your students for job opportunities.',
      'image': AppStrings.schoolImage,
      'route': AppRoutes.school_registration,
      'route_search': AppRoutes.school_search
    },
    {
      'title': 'EVENTS',
      'subtitle': 'Register your events and workshops.',
      'image': AppStrings.eventImage,
      'route': AppRoutes.event_registration,
      'route_search': AppRoutes.event_search
    },
  ];

  final List<Map<String, String>> barbersData = [
    {
      "name": "J.R. Jean",
      "image": AppStrings.barberImage,
      "location": "Boca Raton / Fort Lauderdale / Miami, FL",
    },
    {
      "name": "Marcus Fadez",
      "image": AppStrings.barberImage,
      "location": "Downtown Los Angeles, CA",
    },
    {
      "name": "Tony Sharp",
      "image": AppStrings.barberImage,
      "location": "Brooklyn, New York, NY",
    },
    {
      "name": "Chris The Clipper",
      "image": AppStrings.barberImage,
      "location": "Houston, TX",
    },
    {
      "name": "Fade Master Jay",
      "image": AppStrings.barberImage,
      "location": "Chicago, IL",
    },
    {
      "name": "Luis Blendz",
      "image": AppStrings.barberImage,
      "location": "San Diego, CA",
    },
    {
      "name": "Nate Fresh",
      "image": AppStrings.barberImage,
      "location": "Orlando, FL",
    },
    {
      "name": "Dre The Barber",
      "image": AppStrings.barberImage,
      "location": "Atlanta, GA",
    },
  ];

  final List<Map<String, dynamic>> eventsData = [
    {
      "title": "GROOMING ADAM ATELIER",
      "address": "225 Liberty St Unit 222, New York, NY",
      "image": AppStrings.eventImage,
      "jobDetails":
          "Licensed barbers with experience on all hair types. Appointment-only and walk-in barbers welcome.",
    },
    {
      "title": "URBAN CUTS EXPO 2025",
      "address": "Miami Convention Center, FL",
      "image": AppStrings.eventImage,
      "jobDetails":
          "Join the biggest barber event of the year! Showcases, live battles, and training sessions.",
    },
    {
      "title": "THE FADE MASTERS WORKSHOP",
      "address": "Downtown Los Angeles, CA",
      "image": AppStrings.eventImage,
      "jobDetails":
          "Hands-on training for advanced fade techniques. Hosted by Marcus Fadez and Chris The Clipper.",
    },
    {
      "title": "LEGENDS BARBER COMPETITION",
      "address": "Atlanta Barber Lounge, GA",
      "image": AppStrings.eventImage,
      "jobDetails":
          "Watch top barbers compete live for the title of Barber King 2025. Open for public viewing.",
    },
    {
      "title": "MODERN MAN SEMINAR",
      "address": "The Groom Studio, Chicago, IL",
      "image": AppStrings.eventImage,
      "jobDetails":
          "A day-long seminar focused on grooming, beard styling, and modern men’s fashion trends.",
    },
    {
      "title": "SHARP CUTS ACADEMY DAY",
      "address": "Brooklyn Barber School, NY",
      "image": AppStrings.eventImage,
      "jobDetails":
          "An educational event for students to learn from professionals and showcase their talent.",
    },
    {
      "title": "BARBER CONNECT 2025",
      "address": "Orlando Convention Center, FL",
      "image": AppStrings.eventImage,
      "jobDetails":
          "Meet brands, barbers, and educators. The largest networking event for barbers in the U.S.",
    },
    {
      "title": "FRESH LOOK SHOWCASE",
      "address": "San Diego Groom Hub, CA",
      "image": AppStrings.eventImage,
      "jobDetails":
          "An exclusive event celebrating creativity, artistry, and innovation in modern barbering.",
    },
  ];
}
