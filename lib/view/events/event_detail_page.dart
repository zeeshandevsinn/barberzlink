import 'package:barberzlink/widgets/custom_contact_flow_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_app_bar.dart';

class EventDetailScreen extends StatefulWidget {
  final String eventName;
  final String hostName;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? imageUrl; // network or local path

  const EventDetailScreen({
    super.key,
    required this.eventName,
    required this.hostName,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    this.imageUrl,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen>
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(title: 'Event Details', isBack: true),
        ),
        body: FadeTransition(
          opacity: _fadeAnim,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ------------------ Event Image ------------------
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                  child: widget.imageUrl != null
                      ? Image.asset(
                          widget.imageUrl!,
                          width: double.infinity,
                          height: 260,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: double.infinity,
                          height: 260,
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.event,
                            color: Colors.grey,
                            size: 80,
                          ),
                        ),
                ),

                const SizedBox(height: 20),

                // ------------------ Event Name & Host ------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        widget.eventName,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Hosted by ${widget.hostName}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // ------------------ Event Date & Time ------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _buildInfoCard(
                        icon: Icons.calendar_today,
                        label: "Start Date",
                        value:
                            "${widget.startDate.day}/${widget.startDate.month}/${widget.startDate.year}",
                      ),
                      const SizedBox(width: 12),
                      _buildInfoCard(
                        icon: Icons.access_time,
                        label: "Start Time",
                        value: widget.startTime.format(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _buildInfoCard(
                        icon: Icons.calendar_today_outlined,
                        label: "End Date",
                        value:
                            "${widget.endDate.day}/${widget.endDate.month}/${widget.endDate.year}",
                      ),
                      const SizedBox(width: 12),
                      _buildInfoCard(
                        icon: Icons.access_time_filled,
                        label: "End Time",
                        value: widget.endTime.format(context),
                      ),
                    ],
                  ),
                ),

                // const SizedBox(height: 30),
                // MapPreviewWidget(
                //   latitude: 31.5204,
                //   longitude: 74.3587,
                //   height: 300,
                // ),

                const SizedBox(height: 30),
                // ------------------ Description ------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Event Details",
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
                    "This is a sample description for the event. You can provide any details here about the event agenda, speakers, location instructions, or special notes for attendees.",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomContactFlowBtn(phoneNumber: '+923097325208'),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.red.shade600, size: 22),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
