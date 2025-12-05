import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_contact_flow_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_buildContactRow.dart';

class BarberShopDetailScreen extends StatefulWidget {
  final String shopName;
  final String about;
  final String address;
  final String city;
  final String state;
  final String phone;
  final String website;
  final String instagram;
  final List<String> services;
  final String mainImage;
  final List<String> galleryImages;

  const BarberShopDetailScreen({
    super.key,
    required this.shopName,
    required this.about,
    required this.address,
    required this.city,
    required this.state,
    required this.phone,
    required this.website,
    required this.instagram,
    required this.services,
    required this.mainImage,
    required this.galleryImages,
  });

  @override
  State<BarberShopDetailScreen> createState() => _BarberShopDetailScreenState();
}

class _BarberShopDetailScreenState extends State<BarberShopDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    // Smooth fade-in animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: kIsWeb
            ? AppBar(
                title: Text("Barbershop Details"),
                centerTitle: true,
                elevation: 1)
            : PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: CustomAppBar(title: "Barbershop Details", isBack: true)),
        body: FadeTransition(
          opacity: _fadeAnim,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ------------------ Header Image ------------------
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                  child: Image.asset(
                    widget.mainImage,
                    width: double.infinity,
                    height: 260,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 18),

                // ------------------ Shop Name & City ------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.shopName,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${widget.city}, ${widget.state}",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // ------------------ SERVICES TAGS ------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "About us",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),
                // ------------------ ABOUT SECTION ------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.about,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.grey.shade800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                const SizedBox(height: 25),

                // ------------------ LOCATION ------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.red.shade600, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.address,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.4,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ------------------ CONTACT INFORMATION ------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      buildContactRow(icon: Icons.phone, value: widget.phone),
                      const SizedBox(height: 10),
                      buildContactRow(
                          icon: Icons.language, value: widget.website),
                      const SizedBox(height: 10),
                      buildContactRow(
                          icon: FontAwesomeIcons.instagram,
                          value: widget.instagram),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: widget.services.map((service) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: Colors.red.shade600.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.red.shade600,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        child: Text(
                          service,
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 25),
                // ------------------ GALLERY ------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Work Gallery",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.galleryImages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(widget.galleryImages[index]),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 4,
                              offset: const Offset(1, 2),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(15.0),
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
