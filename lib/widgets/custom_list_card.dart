import 'package:barberzlink/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomListCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String location;
  final VoidCallback onPressed;

  const CustomListCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.location,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 10),

          // Name
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 4),

          // Location
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              location.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                height: 1.3,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Learn More button
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CustomButton(
                onTap: onPressed,
                buttonText: "LEARN MORE",
                fontSize: 13,
              )),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
