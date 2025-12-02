import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_contact_flow_btn.dart';
import 'package:flutter/material.dart';

class FinancialPartnerDetailPage extends StatefulWidget {
  const FinancialPartnerDetailPage({super.key});

  @override
  State<FinancialPartnerDetailPage> createState() =>
      _FinancialPartnerDetailPageState();
}

class _FinancialPartnerDetailPageState extends State<FinancialPartnerDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeAnim;
  late Animation<Offset> slideAnim;

  // ------- DUMMY DATA (Replace with API / DB later) -------
  final Map<String, dynamic> partner = {
    "businessName": "Secure Finance Group",
    "typeOfBusiness": [
      "Business Lending",
      "Equipment Financing",
      "Insurance (Liability / Property)"
    ],
    "website": "www.securefinancegroup.com",
    "contactName": "John Matthews",
    "email": "john@securefinance.com",
    "phone": "+1 310 556 9080",
    "address": "104 Corporate Plaza, Suite 22, California",
    "statesServed": "CA, NY, TX, FL, GA",
    "servicesForBarbers":
        "We provide business loans, equipment financing, and customized liability insurance packages for barbershops.",
    "idealClients": [
      "Barbershops",
      "Multi-location Shops",
      "Individual Barbers"
    ],
    "minRequirements":
        "Minimum credit score 600, at least 6 months in business, minimum monthly revenue \$5,000.",
    "products": [
      "Start-up Loans",
      "Equipment Financing",
      "General Liability Insurance",
      "Tax & Bookkeeping Services"
    ],
    "mainProducts":
        "Barber-focused business loans, affordable insurance bundles, and equipment leasing programs.",
    "offersDiscount": true,
    "offerDescription":
        "10% discount on loan processing fees for Barberz Link members.",
    "promoCode": "BARBERZ10",
    "offerDates": "Jan 10, 2025 – March 10, 2025",
    "licensed": true,
    "licenses": "State Finance License CA-88921, Insurance License CA-55481",
    "displayPreferences": ["Featured Partner", "Financial Services Directory"],
    "shortDescription":
        "Helping barbers and barbershops grow through financing, insurance, and financial guidance.",
    "logo": AppStrings.barberImage,
  };

  // ---------- ANIMATION SETUP ----------
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    slideAnim = Tween<Offset>(begin: const Offset(0, .1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------
  // -----------------------  UI START HERE -----------------------
  // -------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(
            title: "Partner Details",
            isBack: true,
          ),
        ),
        body: FadeTransition(
          opacity: fadeAnim,
          child: SlideTransition(
            position: slideAnim,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top Image Section
                  ClipPath(
                    clipper: CurvedClipper(),
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(partner["logo"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // ---------------- Main Content ----------------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // -------- Business Name --------
                        Text(
                          partner["businessName"],
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // -------- Types of Business Tags --------
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: partner["typeOfBusiness"]
                              .map<Widget>((e) => tagChip(e))
                              .toList(),
                        ),

                        const SizedBox(height: 20),

                        //----------------------------------------------------------------
                        //------------------------ SECTION 1 ------------------------------
                        //----------------------------------------------------------------

                        title("Business Information"),

                        buildText("Website", partner["website"]),
                        buildText("Primary Contact", partner["contactName"]),
                        buildText("Email", partner["email"]),
                        buildText("Phone", partner["phone"]),
                        buildText("Business Address", partner["address"]),
                        buildText("States Served", partner["statesServed"]),

                        const SizedBox(height: 20),

                        //----------------------------------------------------------------
                        //-------------------- SECTION 2: SERVICES ------------------------
                        //----------------------------------------------------------------

                        title("Services for Barbers"),
                        buildParagraph(partner["servicesForBarbers"]),

                        const SizedBox(height: 10),

                        title("Ideal Clients"),
                        Wrap(
                          spacing: 10,
                          children: partner["idealClients"]
                              .map<Widget>((e) => tagChip(e))
                              .toList(),
                        ),

                        const SizedBox(height: 20),

                        buildText(
                            "Minimum Requirements", partner["minRequirements"]),

                        const SizedBox(height: 20),

                        //----------------------------------------------------------------
                        //------------------------ FINANCIAL PRODUCTS ---------------------
                        //----------------------------------------------------------------

                        title("Products Offered"),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: partner["products"]
                              .map<Widget>((e) => tagChip(e))
                              .toList(),
                        ),

                        const SizedBox(height: 20),

                        buildParagraph(partner["mainProducts"]),

                        const SizedBox(height: 25),

                        //----------------------------------------------------------------
                        //------------------------ SPECIAL OFFERS -------------------------
                        //----------------------------------------------------------------

                        title("Special Offers for Barberz Link Users"),
                        buildText("Offer Available",
                            partner["offersDiscount"] ? "Yes" : "No"),
                        if (partner["offersDiscount"]) ...[
                          buildText(
                              "Offer Details", partner["offerDescription"]),
                          buildText("Promo Code", partner["promoCode"]),
                          buildText("Valid Dates", partner["offerDates"]),
                        ],

                        const SizedBox(height: 25),

                        //----------------------------------------------------------------
                        //------------------------ LICENSE INFO ---------------------------
                        //----------------------------------------------------------------

                        title("Licensing & Credentials"),
                        buildText(
                            "Licensed", partner["licensed"] ? "Yes" : "No"),
                        buildParagraph(partner["licenses"]),

                        const SizedBox(height: 25),

                        //----------------------------------------------------------------
                        //------------------------ DISPLAY PREFERENCES --------------------
                        //----------------------------------------------------------------

                        title("Display Preferences"),
                        Wrap(
                          spacing: 10,
                          children: partner["displayPreferences"]
                              .map<Widget>((e) => tagChip(e))
                              .toList(),
                        ),

                        const SizedBox(height: 20),

                        buildText(
                            "Short Description", partner["shortDescription"]),

                        const SizedBox(height: 30),

                        //----------------------------------------------------------------
                        //------------------- CONTACT BUTTON AT END ------------------------
                        //----------------------------------------------------------------

                        CustomContactFlowBtn(
                          phoneNumber: partner["phone"],
                        ),

                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ------------------ Reusable Widgets ------------------

  Widget title(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget buildText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(fontSize: 15, color: Colors.black)),
        ],
      ),
    );
  }

  Widget buildParagraph(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        height: 1.5,
        color: Colors.grey.shade800,
      ),
    );
  }

  Widget tagChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

// ---------------- Curved Image Clipper ------------------
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
