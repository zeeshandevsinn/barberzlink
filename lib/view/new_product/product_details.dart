import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(
            title: 'Product Details',
            isBack: true,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                const SizedBox(height: 20),

                // Product Image
                Center(
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      AppStrings.newProductImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Product Details Card with Light Purple Background
                Card(
                  color: Colors.grey.shade50, // Light purple color
                  elevation: 0, // Remove shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand Name
                        const Text(
                          'BaBylissPRO®',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF666666),
                            letterSpacing: 0.5,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Product Name
                        const Text(
                          'LITHIUMFX+',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1.5,
                            height: 1.1,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Features List
                        _buildFeatureText('Cord/Cordless'),
                        _buildFeatureText('s Lithium'),
                        _buildFeatureText('Ergonomic'),
                        _buildFeatureText('Clipper'),

                        const SizedBox(height: 30),

                        // Rating Section
                        Row(
                          children: [
                            // Stars
                            Row(
                              children: List.generate(5, (index) {
                                return const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 24,
                                );
                              }),
                            ),
                            const SizedBox(width: 8),
                            // Rating Text
                            const Text(
                              '(5/5)',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Product Description
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Description',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'The BabylissPRO LithiumFX is back and better than ever! Get yours today at Babylisspro.com, your local barber distributor or Amazon. The LithiumFX+ Cord/Cordless Clipper features a long-life ball bearing DC 6500 RPM motor and an ergonomic grip housing. You can use it corded or cordless – the lithium-ion battery provides sustained power and performance at all charge levels.',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20), // Extra space at bottom
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.4,
        ),
      ),
    );
  }
}
