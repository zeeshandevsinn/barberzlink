import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage>
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
          ? AppBar(
              title: const Text("Privacy Policy"),
              centerTitle: true,
              elevation: 1,
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: CustomAppBar(title: "Privacy Policy", isBack: true),
            ),
      body: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSection(
                  "Introduction",
                  "Barberz Link LLC is committed to protecting your privacy. This Privacy Policy explains how we collect, use, and safeguard your data.",
                ),
                buildSection(
                  "Information We Collect",
                  "We may collect your name, email, phone, resumes, licenses, barbershop info, device data, IP address, usage logs, and cookies.",
                ),
                buildSection(
                  "How We Use Information",
                  "We create accounts, connect users, show profiles, send notifications, and improve the app. We do NOT sell your information.",
                ),
                buildSection(
                  "User-Generated Content Disclaimer",
                  "We are not responsible for false, misleading, or incomplete information submitted by users.",
                ),
                buildSection(
                  "State Board & Licensing Disclaimer",
                  "We DO NOT guarantee accuracy of any licensing information. Verify with your official state regulators.",
                ),
                buildSection(
                  "Business & Financial Disclaimer",
                  "We are not responsible for any financial or business information from third-party providers.",
                ),
                buildSection(
                  "Product Information Disclaimer",
                  "We do not take responsibility for product accuracy, usage issues, or refunds.",
                ),
                buildSection(
                  "Data Security",
                  "We use reasonable protection but cannot guarantee 100% security.",
                ),
                buildSection(
                  "Children's Privacy",
                  "Barberz Link LLC is not intended for users under 16.",
                ),
                buildSection(
                  "Your Rights",
                  "You may update or delete your information by contacting: contact@barberzlink.com",
                ),
                buildSection(
                  "Limitation of Liability",
                  "We are not liable for any disputes, damages, or losses caused by user content or third-party information.",
                ),
                buildSection(
                  "Updates",
                  "We may update this Privacy Policy at any time.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSection(String title, String subtitle) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
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
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
