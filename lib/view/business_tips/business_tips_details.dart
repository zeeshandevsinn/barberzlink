import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_contact_flow_btn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/business_tips_module.dart';

class BusinessTipsDetailPage extends StatefulWidget {
  final BusinessTipsModel business;

  const BusinessTipsDetailPage({super.key, required this.business});

  @override
  State<BusinessTipsDetailPage> createState() => _BusinessTipsDetailPageState();
}

class _BusinessTipsDetailPageState extends State<BusinessTipsDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeAnim;
  late Animation<Offset> slideAnim;

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

  @override
  Widget build(BuildContext context) {
    final business = widget.business;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: kIsWeb
            ? AppBar(
                title: Text("Business Tip Details"),
                centerTitle: true,
                elevation: 1,
              )
            : PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: CustomAppBar(
                  title: "Business Tip Details",
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
                  // ---------------- Top Logo Section ----------------
                  ClipPath(
                    clipper: CurvedClipper(),
                    child: Container(
                      height: 260,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              business.logoUrl ?? AppStrings.businessTipsImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ---------------- Main Content ----------------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Business Name
                        Text(
                          business.businessName,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Type of Business Tags
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: business.typeOfBusiness
                              .map((e) => tagChip(e))
                              .toList(),
                        ),

                        const SizedBox(height: 25),

                        // ---------------- Business Info ----------------
                        sectionTitle("Business Information"),
                        buildText("Website", business.website),
                        buildText("Contact Name", business.contactName),
                        buildText("Email", business.email),
                        buildText("Phone", business.phone),
                        buildText("Address", business.address),
                        buildText(
                            "States Served", business.statesServed.join(", ")),
                        const SizedBox(height: 25),

                        // ---------------- Services ----------------
                        sectionTitle("Services for Barbers"),
                        buildParagraph(business.serviceOfferedFor),
                        const SizedBox(height: 10),
                        sectionTitle("Ideal Clients"),
                        Wrap(
                          spacing: 10,
                          children: business.idealClients
                              .map((e) => tagChip(e))
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        buildText("Minimum Requirements",
                            business.minimumRequirements.join(", ")),
                        const SizedBox(height: 25),

                        // ---------------- Products ----------------
                        sectionTitle("Products Offered"),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: business.productsOffered
                              .map((e) => tagChip(e))
                              .toList(),
                        ),
                        const SizedBox(height: 15),
                        buildParagraph(business.mainProducts),
                        const SizedBox(height: 25),

                        // ---------------- Special Offers ----------------
                        sectionTitle("Special Offers"),
                        buildText("Discount Available",
                            business.discountAvailable ? "Yes" : "No"),
                        if (business.discountAvailable) ...[
                          buildText("Offer Details", business.specialOffers!),
                          buildText("Promo Code", business.promoCode!),
                          buildText("Valid Dates", business.offerDates!),
                        ],
                        const SizedBox(height: 25),

                        // ---------------- Licensing ----------------
                        sectionTitle("Licensing & Credentials"),
                        buildText("Licensed", business.licensed ? "Yes" : "No"),
                        buildParagraph(business.licenses),
                        const SizedBox(height: 25),

                        // ---------------- Display Preferences ----------------
                        sectionTitle("Display Preferences"),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: business.displayPreferences
                              .map((e) => tagChip(e))
                              .toList(),
                        ),
                        const SizedBox(height: 20),

                        buildText(
                            "Profile Description", business.profileDescription),

                        const SizedBox(height: 30),

                        // ---------------- Contact Button ----------------
                        CustomContactFlowBtn(phoneNumber: business.phone),

                        const SizedBox(height: 30),
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

  // ---------------- Reusable Widgets ----------------
  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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

// ---------------- Curved Image Clipper ----------------
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
