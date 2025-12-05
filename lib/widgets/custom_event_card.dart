import 'package:barberzlink/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEventCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String address;
  final String jobDetails;
  final VoidCallback onPressed;

  const CustomEventCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.address,
    required this.jobDetails,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 380.spMax,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Large Rectangular Image
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// 🔹 Event Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 4),

              /// 🔹 Address
              Text(
                address,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              /// 🔹 Job Details Section
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Job Details:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 60,
                          child: SingleChildScrollView(
                            child: Text(
                              jobDetails,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                                height: 1.3,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// 🔹 View Details Button
                    CustomButton(
                      onTap: onPressed,
                      buttonText: "View Details",
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
