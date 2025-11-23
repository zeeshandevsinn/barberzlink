import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_buildContactRow.dart';
import 'package:barberzlink/widgets/custom_contact_flow_btn.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BarberDetailPage extends StatefulWidget {
  const BarberDetailPage({super.key});

  @override
  State<BarberDetailPage> createState() => _BarberDetailPageState();
}

class _BarberDetailPageState extends State<BarberDetailPage>
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: CustomAppBar(
              title: "Barber Details",
              isBack: true,
            )),
        body: FadeTransition(
          opacity: fadeAnim,
          child: SlideTransition(
            position: slideAnim,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header Image With Curved Bottom
                  ClipPath(
                    clipper: CurvedClipper(),
                    child: Container(
                      height: 350,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              AppStrings.barberImage), // Replace your image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // Main Content
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        const Text(
                          "Barber Name",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // Specialization
                        Text(
                          "Professional Hair Stylist",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Specialty Tags
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            tagChip("Fade Expert"),
                            tagChip("Beard Styling"),
                            tagChip("Hair Artist"),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // About Title
                        const Text(
                          "ABOUT",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // About Description
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                          "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                          "Ut enim ad minim veniam, quis nostrud exercitation ullamco.",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Colors.grey.shade700,
                          ),
                        ),
// Location Section
                        const SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Location Icon
                            Icon(
                              Icons.location_on,
                              color: Colors.red.shade600,
                              size: 22,
                            ),
                            const SizedBox(width: 8),

                            // Responsive text (no overflow)
                            Expanded(
                              child: Text(
                                '123 Barber St, Cityville, Country',
                                style: TextStyle(
                                    fontSize: 15,
                                    height: 1.4,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w600),
                                maxLines: 3,
                                overflow:
                                    TextOverflow.ellipsis, // Prevent overflow
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            buildContactRow(
                                icon: Icons.phone, value: '+923097325208'),
                            const SizedBox(height: 10),
                            buildContactRow(
                                icon: Icons.language,
                                value: 'www.barberwebsite.com'),
                            const SizedBox(height: 10),
                            buildContactRow(
                                icon: FontAwesomeIcons.instagram,
                                value: '@barberinsta'),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // Gallery Section
                        // Gallery Section
                        Text(
                          "Work Gallery",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 15),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 items per row
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio:
                                0.85, // Adjust for better card shape
                          ),
                          itemCount: 9,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeOut,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.grey.shade100,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.07),
                                      blurRadius: 4,
                                      offset: const Offset(1, 2),
                                    )
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage(AppStrings.barberImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 30),
                        CustomContactFlowBtn(phoneNumber: '+923097325208'),
                        // // Book Appointment Button
                        // SizedBox(
                        //   width: double.infinity,
                        //   height: 55,
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.red.shade600,
                        //       foregroundColor: Colors.white,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(14),
                        //       ),
                        //     ),
                        //     onPressed: () {},
                        //     child: const Text(
                        //       "Book Appointment",
                        //       style: TextStyle(
                        //         fontSize: 17,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        const SizedBox(height: 20),
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

  // Specialty Tag Chip
  Widget tagChip(String text) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

// Custom Curved Clipper for the top image
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
