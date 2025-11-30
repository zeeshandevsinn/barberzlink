import 'package:flutter/material.dart';

class TermsAndConditionPage extends StatefulWidget {
  const TermsAndConditionPage({super.key});

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget section(String title, String text) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 3),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.grey[600],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Terms & Conditions"), centerTitle: true),
      body: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                section("Agreement to Terms",
                    "By accessing Barberz Link LLC, you agree to these Terms & Conditions."),
                section("Description of Service",
                    "Barberz Link is a platform connecting barbers, shops, schools, brands, and providers. We do not verify user-submitted data."),
                section("User Responsibilities",
                    "You must provide accurate information and avoid fraud, spam, or harmful activities."),
                section("No Warranties",
                    "Barberz Link LLC provides all services 'as-is' without warranties."),
                section("Limitation of Liability",
                    "We are not responsible for inaccurate information, losses, damages, or third-party disputes."),
                section("Indemnification",
                    "Users agree to indemnify Barberz Link LLC against claims caused by user behavior."),
                section("Termination",
                    "We may suspend or terminate accounts that violate rules."),
                section("Governing Law",
                    "These Terms follow the laws of the State of Florida."),
                section("Contact Us",
                    "Email: contact@barberzlink.com\nPhone: 904-319-3632\nWebsite: www.BarberzLink.com"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
