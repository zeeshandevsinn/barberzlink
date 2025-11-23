import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_contact_flow_btn.dart';

class SchoolDetailScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String schoolName;
  final String fullAddress;
  final String city;
  final String about;
  final String phone;
  final String website;
  final List<String>? galleryImages; // local path or network url
  final String? mainImage;

  const SchoolDetailScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.schoolName,
    required this.fullAddress,
    required this.city,
    required this.about,
    required this.phone,
    required this.website,
    this.galleryImages,
    this.mainImage,
  });

  @override
  State<SchoolDetailScreen> createState() => _SchoolDetailScreenState();
}

class _SchoolDetailScreenState extends State<SchoolDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(title: "School Details", isBack: true),
        ),
        body: FadeTransition(
          opacity: _fadeAnim,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ---------------- Main Image ----------------
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28)),
                  child: widget.mainImage != null
                      ? Image.asset(
                          widget.mainImage!,
                          width: double.infinity,
                          height: 260,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: double.infinity,
                          height: 260,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.school,
                              color: Colors.grey, size: 80),
                        ),
                ),

                const SizedBox(height: 20),

                // ---------------- School Name & Contact ----------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        widget.schoolName,
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Hosted by ${widget.firstName} ${widget.lastName}",
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.fullAddress,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${widget.city} | Phone: ${widget.phone}",
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Email: ${widget.email} | Website: ${widget.website}",
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // ---------------- About ----------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "About School",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.about,
                    style: TextStyle(
                        fontSize: 15, height: 1.5, color: Colors.grey.shade800),
                  ),
                ),

                const SizedBox(height: 25),

                // ---------------- Gallery ----------------
                if (widget.galleryImages != null &&
                    widget.galleryImages!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "School Gallery",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 120,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.galleryImages!.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 8),
                            itemBuilder: (_, index) {
                              final img = widget.galleryImages![index];
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(img,
                                    width: 120, height: 120, fit: BoxFit.cover),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomContactFlowBtn(phoneNumber: widget.phone),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
