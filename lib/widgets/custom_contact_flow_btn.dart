import 'package:barberzlink/ui/primary_button.dart';
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
          child: PrimaryButton(
            onPressed: _callNumber,
            backgroundColor: Colors.red.shade600,
            borderRadius: 14,
            title: "Call Me",
            hMargin: 0,
            height: 40,
            vMargin: 0,
          ),
        ),

        const SizedBox(width: 12),

        // ------------------ MESSAGE BUTTON ------------------
        Expanded(
          child: PrimaryButton(
            onPressed: _sendMessage,
            backgroundColor: Colors.red.shade600,
            borderRadius: 14,
            title: "Message Me",
            hMargin: 0,
            height: 40,
            vMargin: 0,
          ),
        ),
      ],
    );
  }
}
