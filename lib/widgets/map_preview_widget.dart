import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPreviewWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  final double height;
  final double borderRadius;

  const MapPreviewWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    this.height = 300,
    this.borderRadius = 20,
  });

  Future<void> openGoogleMapsDirect() async {
    // Dummy coordinates - New York City
    const double lat = 40.7128;
    const double lng = -74.0060;

    final String url =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    final staticMap =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFbnWBNdcgp57afDWs5UXUY2Kp1mNVdp5b4A&s";
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: GestureDetector(
          onTap: openGoogleMapsDirect,
          child: Image.network(
            staticMap,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red.shade600,
                ),
              );
            },
            errorBuilder: (context, _, __) => Container(
              color: Colors.grey.shade300,
              child: const Center(
                child: Icon(Icons.map, size: 80, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
