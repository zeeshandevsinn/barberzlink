import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barberzlink/widgets/custom_button.dart'; // adjust import path if needed

class ConfirmationDialog extends StatelessWidget {
  final String message;
  final VoidCallback onDone;

  const ConfirmationDialog({
    super.key,
    required this.message,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Icon or Emoji with Title Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Info Text (Optional)
            Text(
              "You’ll receive a confirmation email once approved.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 24),

            // Custom Done Button
            CustomButton(
              onTap: onDone,
              buttonText: "Done",
            ),
          ],
        ),
      ),
    );
  }
}
