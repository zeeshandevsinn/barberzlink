import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/models/state_profile_model.dart';

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

  final products = [
    {
      "image": AppStrings.newProductImage,
      "name": "Hair Wax",
      "type": "Styling Product",
    },
    {
      "image": AppStrings.newProductImage,
      "name": "Beard Oil",
      "type": "Grooming",
    },
    {
      "image": AppStrings.newProductImage,
      "name": "Shampoo",
      "type": "Hair Care",
    },
  ];
  final List<Map<String, dynamic>> featuredProducts = [
    {
      "image": AppStrings.newProductImage,
      "title": "Register a New Product",
      "subtitle": "Submit your product to appear in the list",
      "route": AppRoutes.productDetails,
    },
    {
      "image": AppStrings.newProductImage,
      "title": "Product Promotion",
      "subtitle": "Run promotions & highlight your product",
      "route": AppRoutes.productDetails,
    },
  ];

// Complete dummy data for StateProfileModel
  List<StateProfileModel> statesData = [
    StateProfileModel(
      boardName: 'California Board of Barbering and Cosmetology',
      stateCode: 'CA',
      licenseInfo:
          'Barber License requires 1500 hours of training and passing written & practical exams.',
      requirements: '''
• Minimum 1500 hours at accredited barber school
• Must be at least 17 years old
• High school diploma or GED equivalent
• Pass California State Board written exam
• Pass practical demonstration exam
• Complete application with fees
• Submit passport-style photos
• Provide proof of training completion
''',
      stateName: 'California',
      websiteLink: 'https://www.barbering.ca.gov',
      transferLink: 'https://www.barbering.ca.gov/license_transfer',
      testingSiteLink: 'https://www.barbering.ca.gov/testing_locations',
      militaryPolicyLink: 'https://www.barbering.ca.gov/military_policy',
    ),
    StateProfileModel(
      boardName: 'New York State Board for Barbering',
      stateCode: 'NY',
      licenseInfo:
          'Barber license requires 900 hours of approved training and successful examination completion.',
      requirements: '''
• Complete 900 hours at NYS-approved school
• Must be 17 years or older
• Pass NYS written examination
• Pass practical skills test
• Submit completed application
• Pay applicable fees
• Provide proof of identity
• Background check clearance
''',
      stateName: 'New York',
      websiteLink: 'https://www.dos.ny.gov/barbering',
      transferLink: 'https://www.dos.ny.gov/barbering/transfer',
      testingSiteLink: 'https://www.dos.ny.gov/barbering/testing',
      militaryPolicyLink: 'https://www.dos.ny.gov/barbering/military',
    ),
    StateProfileModel(
      boardName: 'Texas Department of Licensing and Regulation - Barbering',
      stateCode: 'TX',
      licenseInfo:
          'Barber license requires 1500 hours of training and passing state examinations.',
      requirements: '''
• 1500 hours at licensed barber school
• Minimum age: 16 years
• High school diploma or equivalent
• Pass TDLR written exam
• Pass TDLR practical exam
• Complete application process
• Submit fingerprint background check
• Provide social security number
''',
      stateName: 'Texas',
      websiteLink: 'https://www.tdlr.texas.gov/barbers',
      transferLink: 'https://www.tdlr.texas.gov/barbers/reciprocity',
      testingSiteLink: 'https://www.tdlr.texas.gov/barbers/exams',
      militaryPolicyLink: 'https://www.tdlr.texas.gov/military',
    ),
    StateProfileModel(
      boardName: 'Florida Board of Barbering',
      stateCode: 'FL',
      licenseInfo:
          'Barber license requires completion of 1200 hours at approved barber school.',
      requirements: '''
• 1200 hours at Florida-approved school
• Must be at least 16 years old
• Pass Florida barber exam
• Complete HIV/AIDS course
• Submit application with fees
• Provide proof of education
• Pass background screening
• Submit electronic fingerprints
''',
      stateName: 'Florida',
      websiteLink: 'https://www.floridasbarbering.gov',
      transferLink: 'https://www.floridasbarbering.gov/endorsement',
      testingSiteLink: 'https://www.floridasbarbering.gov/exam_locations',
      militaryPolicyLink: 'https://www.floridasbarbering.gov/military',
    ),
    StateProfileModel(
      boardName:
          'Illinois Department of Financial and Professional Regulation - Barbering',
      stateCode: 'IL',
      licenseInfo:
          'Barber license requires 1500 hours of training and successful examination.',
      requirements: '''
• 1500 hours at approved barber school
• Minimum age: 16 years
• High school diploma or GED
• Pass Illinois barber exam
• Complete application process
• Pay required fees
• Submit school transcripts
• Provide identification documents
''',
      stateName: 'Illinois',
      websiteLink: 'https://www.idfpr.com/barbering',
      transferLink: 'https://www.idfpr.com/barbering/reciprocity',
      testingSiteLink: 'https://www.idfpr.com/barbering/testing',
      militaryPolicyLink: 'https://www.idfpr.com/military',
    ),
    StateProfileModel(
      boardName: 'Georgia State Board of Barbers',
      stateCode: 'GA',
      licenseInfo:
          'Barber license requires 1500 hours of training and passing state board exams.',
      requirements: '''
• Complete 1500 hours of training
• Must be 16 years or older
• Pass Georgia barber exams
• Submit completed application
• Pay all applicable fees
• Provide proof of training
• Pass background investigation
• Submit passport photos
''',
      stateName: 'Georgia',
      websiteLink: 'https://sos.ga.gov/barbering',
      transferLink: 'https://sos.ga.gov/barbering/reciprocity',
      testingSiteLink: 'https://sos.ga.gov/barbering/exam_sites',
      militaryPolicyLink: 'https://sos.ga.gov/barbering/military',
    ),
    StateProfileModel(
      boardName: 'Pennsylvania Board of Barber Examiners',
      stateCode: 'PA',
      licenseInfo:
          'Barber license requires 1250 hours of training and successful examination.',
      requirements: '''
• 1250 hours at approved school
• Minimum age: 16 years
• Pass Pennsylvania barber exam
• Complete application process
• Pay required fees
• Submit school certificate
• Provide identification proof
• Pass background check
''',
      stateName: 'Pennsylvania',
      websiteLink: 'https://www.dos.pa.gov/barbering',
      transferLink: 'https://www.dos.pa.gov/barbering/reciprocity',
      testingSiteLink: 'https://www.dos.pa.gov/barbering/testing',
      militaryPolicyLink: 'https://www.dos.pa.gov/barbering/military',
    ),
    StateProfileModel(
      boardName: 'Ohio State Barber Board',
      stateCode: 'OH',
      licenseInfo:
          'Barber license requires 1800 hours of training and passing state examinations.',
      requirements: '''
• Complete 1800 hours of training
• Must be at least 16 years old
• Pass Ohio barber examinations
• Submit application package
• Pay all required fees
• Provide training completion proof
• Submit background check
• Provide recent photographs
''',
      stateName: 'Ohio',
      websiteLink: 'https://barber.ohio.gov',
      transferLink: 'https://barber.ohio.gov/reciprocity',
      testingSiteLink: 'https://barber.ohio.gov/exam_locations',
      militaryPolicyLink: 'https://barber.ohio.gov/military',
    ),
    StateProfileModel(
      boardName: 'Michigan Board of Barber Examiners',
      stateCode: 'MI',
      licenseInfo:
          'Barber license requires 1800 hours of training and successful exam completion.',
      requirements: '''
• 1800 hours at licensed school
• Minimum age: 17 years
• Pass Michigan barber exams
• Complete application process
• Pay applicable fees
• Submit proof of education
• Provide identification
• Pass criminal background check
''',
      stateName: 'Michigan',
      websiteLink: 'https://www.michigan.gov/barbering',
      transferLink: 'https://www.michigan.gov/barbering/reciprocity',
      testingSiteLink: 'https://www.michigan.gov/barbering/testing',
      militaryPolicyLink: 'https://www.michigan.gov/barbering/military',
    ),
    StateProfileModel(
      boardName: 'Arizona Board of Barbers',
      stateCode: 'AZ',
      licenseInfo:
          'Barber license requires 1500 hours of training and passing state board exams.',
      requirements: '''
• 1500 hours at approved school
• Must be 16 years or older
• Pass Arizona barber exams
• Submit completed application
• Pay all required fees
• Provide training certificate
• Submit fingerprint cards
• Pass background investigation
''',
      stateName: 'Arizona',
      websiteLink: 'https://barber.az.gov',
      transferLink: 'https://barber.az.gov/reciprocity',
      testingSiteLink: 'https://barber.az.gov/exam_sites',
      militaryPolicyLink: 'https://barber.az.gov/military',
    ),
    StateProfileModel(
      boardName: 'North Carolina Board of Barber Examiners',
      stateCode: 'NC',
      licenseInfo:
          'Barber license requires 1528 hours of training and successful examination.',
      requirements: '''
• Complete 1528 hours of training
• Minimum age: 16 years
• Pass NC barber examinations
• Submit application package
• Pay applicable fees
• Provide school transcripts
• Submit background check
• Provide passport photos
''',
      stateName: 'North Carolina',
      websiteLink: 'https://www.ncbarboard.org',
      transferLink: 'https://www.ncbarboard.org/reciprocity',
      testingSiteLink: 'https://www.ncbarboard.org/testing',
      militaryPolicyLink: 'https://www.ncbarboard.org/military',
    ),
    StateProfileModel(
      boardName: 'Colorado Office of Barbering',
      stateCode: 'CO',
      licenseInfo:
          'Barber license requires 1500 hours of training and passing required exams.',
      requirements: '''
• 1500 hours at approved school
• Must be 16 years or older
• Pass Colorado barber exams
• Complete application process
• Pay required fees
• Submit proof of training
• Provide identification
• Pass background screening
''',
      stateName: 'Colorado',
      websiteLink: 'https://dpo.colorado.gov/Barbering',
      transferLink: 'https://dpo.colorado.gov/Barbering/reciprocity',
      testingSiteLink: 'https://dpo.colorado.gov/Barbering/testing',
      militaryPolicyLink: 'https://dpo.colorado.gov/Barbering/military',
    ),
  ];

  final List<Map<String, dynamic>> schoolsData = [
    {
      'image': AppStrings.schoolImage,
      "name": "American Barber Institute",
      "location": "48 West 39th Street New York, NY 10018",
    },
    {
      'image': AppStrings.schoolImage,
      "name": "American Barber Institute",
      "location": "48 West 39th Street New York, NY 10018",
    },
    {
      'image': AppStrings.schoolImage,
      "name": "American Barber Institute",
      "location": "48 West 39th Street New York, NY 10018",
    },
    {
      'image': AppStrings.schoolImage,
      "name": "American Barber Institute",
      "location": "48 West 39th Street New York, NY 10018",
    },
    {
      'image': AppStrings.schoolImage,
      "name": "American Barber Institute",
      "location": "48 West 39th Street New York, NY 10018",
    },
  ];

  final List<Map<String, dynamic>> barberShopsData = [
    {
      "name": "The Fade Factory",
      "owner": "Marcus Fadez",
      "location": "Downtown Los Angeles, CA",
      "image": AppStrings.barbershopImage,
      "rating": 4.8,
      "description":
          "Modern fades, beard trims, and premium grooming in a luxury studio setting.",
    },
    {
      "name": "Sharp Cuts Barbershop",
      "owner": "Tony Sharp",
      "location": "Brooklyn, New York, NY",
      "image": AppStrings.barbershopImage,
      "rating": 4.9,
      "description":
          "Classic New York barbershop offering expert fades and lineups.",
    },
    {
      "name": "Blend Masters",
      "owner": "Chris The Clipper",
      "location": "Houston, TX",
      "image": AppStrings.barbershopImage,
      "rating": 4.7,
      "description":
          "Top-notch barbers known for precision blends and detailed beard shaping.",
    },
    {
      "name": "Fresh Look Studio",
      "owner": "Luis Blendz",
      "location": "San Diego, CA",
      "image": AppStrings.barbershopImage,
      "rating": 4.8,
      "description":
          "Stylish studio offering modern cuts and grooming with a chill vibe.",
    },
    {
      "name": "Legends Grooming Lounge",
      "owner": "Dre The Barber",
      "location": "Atlanta, GA",
      "image": AppStrings.barbershopImage,
      "rating": 4.9,
      "description":
          "Luxury men’s grooming experience with beard and hair care treatments.",
    },
    {
      "name": "Urban Fades",
      "owner": "J.R. Jean",
      "location": "Fort Lauderdale / Miami, FL",
      "image": AppStrings.barbershopImage,
      "rating": 4.6,
      "description":
          "Popular spot for clean fades, sharp edge-ups, and smooth atmosphere.",
    },
    {
      "name": "King’s Chair Barbershop",
      "owner": "Nate Fresh",
      "location": "Orlando, FL",
      "image": AppStrings.barbershopImage,
      "rating": 4.9,
      "description":
          "Barbering excellence meets comfort — where every client feels royal.",
    },
    {
      "name": "Modern Man Studio",
      "owner": "Fade Master Jay",
      "location": "Chicago, IL",
      "image": AppStrings.barbershopImage,
      "rating": 4.8,
      "description":
          "Modern grooming lounge specializing in fades, tapers, and facial styling.",
    },
  ];
}
