import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomContactFlowBtn extends StatelessWidget {
  final String phoneNumber;

  const CustomContactFlowBtn({
    super.key,
    required this.phoneNumber,
  });

  // ------------------ CALL ------------------
  Future<void> _callNumber() async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(callUri, mode: LaunchMode.externalApplication);
  }

  // ------------------ MESSAGE ------------------
  Future<void> _sendMessage() async {
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
    await launchUrl(smsUri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ------------------ CALL BUTTON ------------------
        Expanded(
          child: ElevatedButton(
            onPressed: _callNumber,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Call Me",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // ------------------ MESSAGE BUTTON ------------------
        Expanded(
          child: ElevatedButton(
            onPressed: _sendMessage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Message Me",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
