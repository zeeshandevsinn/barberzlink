import 'package:url_launcher/url_launcher.dart';

class AppHelper {
  static const String adminEmail = "contact@barberzlink.com";

  /// Opens Gmail or default email app with prefilled fields
  static Future<void> openAdminEmail({
    String subject = "Barberz Link App Inquiry",
    String body = "Hello Barberz Link Team,",
  }) async {
    final Uri gmailUri = Uri(
      scheme: 'mailto',
      path: adminEmail,
      query: Uri.encodeQueryComponent(
        "subject=$subject&body=$body",
      ),
    );

    if (await canLaunchUrl(gmailUri)) {
      await launchUrl(gmailUri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback (if Gmail not available)
      final Uri fallbackUri = Uri(
        scheme: 'mailto',
        path: adminEmail,
      );

      await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> openJobCompanyEmail({
    String subject = "Job Inquiry - Barberz Link",
    String body = "Hello,",
    required String companyEmail,
  }) async {
    final Uri gmailUri = Uri(
      scheme: 'mailto',
      path: companyEmail,
      query: Uri.encodeQueryComponent(
        "subject=$subject&body=$body",
      ),
    );

    if (await canLaunchUrl(gmailUri)) {
      await launchUrl(gmailUri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback (if Gmail not available)
      final Uri fallbackUri = Uri(
        scheme: 'mailto',
        path: adminEmail,
      );

      await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
    }
  }
}
