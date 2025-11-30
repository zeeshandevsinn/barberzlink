import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/helper/functions.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountProfileScreen extends StatefulWidget {
  const AccountProfileScreen({super.key});

  @override
  State<AccountProfileScreen> createState() => _AccountProfileScreenState();
}

class _AccountProfileScreenState extends State<AccountProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Offset> _headerSlide;
  late Animation<double> _headerFade;
  late Animation<Offset> _contactSlide;
  late Animation<Offset> _tilesSlide;
  late Animation<Offset> _subscriptionSlide;

  final Color kRed = const Color(0xFFEF5350);
  final Color kBlack = const Color(0xFF121212);

  // You can change this dynamically based on user plan.
  String currentPlan = "Free"; // OR "Premium"

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _headerSlide =
        Tween(begin: const Offset(0, -0.25), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.35, curve: Curves.easeOutBack)),
    );

    _headerFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.35)),
    );

    _contactSlide =
        Tween(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.3, 0.6, curve: Curves.easeOut)),
    );

    _subscriptionSlide =
        Tween(begin: const Offset(0, 0.4), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.45, 0.75, curve: Curves.easeOutBack)),
    );

    _tilesSlide = Tween(begin: const Offset(0, 0.4), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.7, 1.0, curve: Curves.easeOutCubic)),
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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(title: 'Profile')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10),

            /// HEADER
            FadeTransition(
              opacity: _headerFade,
              child: SlideTransition(
                position: _headerSlide,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 58,
                      backgroundImage: const NetworkImage(
                        "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=400",
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Muhammad Zeeshan",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: kBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Flutter Developer",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// CONTACT BUTTONS
            SlideTransition(
              position: _contactSlide,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircleBtn(Icons.phone, kRed, () {}),
                  const SizedBox(width: 20),
                  _buildCircleBtn(Icons.chat_bubble, Colors.black, () {}),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// SUBSCRIPTION CARD (NEW)
            SlideTransition(
              position: _subscriptionSlide,
              child: _buildSubscriptionCard(),
            ),

            const SizedBox(height: 20),

            /// TILES
            SlideTransition(
              position: _tilesSlide,
              child: Column(
                children: [
                  _buildTile(Icons.edit, "Edit Profile", () {
                    AppRoutes.goTo(context, AppRoutes.edit_profile);
                  }),
                  _buildTile(Icons.settings, "Settings", () {}),
                  _buildTile(Icons.privacy_tip, "Privacy Policy", () {
                    AppRoutes.goTo(context, AppRoutes.privacy_policy);
                  }),
                  _buildTile(
                      Icons.verified_user_outlined, "Terms and Conditions", () {
                    AppRoutes.goTo(context, AppRoutes.terms_and_conditions);
                  }),
                  _buildTile(Icons.help_center, "Help Center", () {
                    AppHelper.openAdminEmail(
                        subject: "Help Needed",
                        body:
                            "Hello Barberz Link Team,\n\nI need assistance with...");
                  }),
                  _buildTile(Icons.question_answer, "FAQ", () {
                    AppRoutes.goTo(context, AppRoutes.faq_page);
                  }),
                  _buildTile(Icons.logout, "Logout", () {
                    AppRoutes.goTo(context, AppRoutes.login);
                  }),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleBtn(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.1),
        ),
        child: Icon(icon, size: 26, color: color),
      ),
    );
  }

  /// ---------------- SUBSCRIPTION UI ----------------
  Widget _buildSubscriptionCard() {
    bool isPremium = currentPlan == "Premium";

    return InkWell(
      onTap: () {
        print("Go to subscription screen");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isPremium
                ? [Colors.amber.shade700, Colors.deepOrange.shade400]
                : [Colors.blue.shade400, Colors.blue.shade600],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              isPremium ? Icons.workspace_premium : Icons.lock_open,
              color: Colors.white,
              size: 36,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isPremium ? "Premium Member" : "Free Plan",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isPremium
                        ? "You are enjoying premium benefits"
                        : "Unlock premium features now!",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                print(isPremium ? "Manage Subscription" : "Upgrade to Premium");
                setState(() {
                  currentPlan = isPremium ? "Free" : "Premium";
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  isPremium ? "Manage" : "Upgrade",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: isPremium ? Colors.orange.shade800 : Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.black12,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
            child: Row(
              children: [
                Icon(icon, color: kRed, size: 26),
                const SizedBox(width: 16),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kBlack,
                  ),
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
