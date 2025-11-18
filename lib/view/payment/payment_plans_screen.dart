import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:barberzlink/widgets/plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentPlansScreen extends StatefulWidget {
  final String? userType; // 'barber', 'barbershop', 'school', or null

  const PaymentPlansScreen({super.key, this.userType});

  @override
  State<PaymentPlansScreen> createState() => _PaymentPlansScreenState();
}

class _PaymentPlansScreenState extends State<PaymentPlansScreen> {
  String? _selectedPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pay & Play Options'),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Center(
              child: Column(
                children: [
                  Text(
                    'BarberzLink.com',
                    style: AppTextStyle.bold(
                      fontSize: 24.sp,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Choose Your Plan',
                    style: AppTextStyle.medium(
                      fontSize: 16.sp,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Plan Cards
            _buildPlanCard(
              planId: 'free',
              title: 'Free Access',
              subtitle: 'Basic Plan',
              description: 'Perfect for getting started.',
              features: [
                'Create a basic profile (Barber, BarberShop, or School)',
                'Upload profile photo & short bio',
                'View limited job posts',
                'Search local listings (City, State, Zip)',
                'Message up to 3 new connections per month',
              ],
              price: 'Free',
              isPopular: false,
            ),
            SizedBox(height: 16.h),

            _buildPlanCard(
              planId: 'premium',
              title: 'Premium Access',
              subtitle: 'Monthly Plan',
              description: 'Unlock full visibility and connections.',
              features: [
                'Full profile customization (photos, portfolio, videos)',
                'Unlimited job searches & applications',
                'Direct message any user or shop',
                'Appear in top search results',
                'Get access to Shop Reviews & Ratings',
              ],
              price: widget.userType == 'barbershop'
                  ? '\$19.99/month'
                  : '\$9.99/month',
              priceSubtext: widget.userType == 'barbershop'
                  ? 'For Barbershops'
                  : 'For Barbers',
              isPopular: true,
            ),
            SizedBox(height: 16.h),

            _buildPlanCard(
              planId: 'spotlight',
              title: 'Spotlight Access',
              subtitle: 'Promote & Play',
              description: 'Designed for serious professionals and shops.',
              features: [
                'Everything in Premium, plus:',
                'Feature your profile or shop on the homepage',
                'Display banner ads in the "Featured Barbers" or "Hot Shops" section',
                'Get early access to new job listings & events',
                'Access analytics (views, messages, and engagement stats)',
              ],
              price: '\$29.99/month',
              isPopular: false,
            ),
            SizedBox(height: 16.h),

            _buildPlanCard(
              planId: 'event',
              title: 'Event & Product Listings',
              subtitle: 'One-Time Fee',
              description: 'Promote your brand or event directly to the BarberzLink network.',
              features: [
                'Post trade shows, competitions, training events, or product launches',
                'Includes a custom event flyer on the homepage',
              ],
              price: '\$150',
              priceSubtext: 'one-time listing',
              isPopular: false,
            ),
            SizedBox(height: 16.h),

            _buildPlanCard(
              planId: 'school',
              title: 'School & Training Partnerships',
              subtitle: 'Monthly Plan',
              description: 'Grow your student network.',
              features: [
                'Create verified training school profiles',
                'Post internship or job placement opportunities',
                'Connect with barbershops seeking trainees',
              ],
              price: '\$19.99/month',
              isPopular: false,
            ),
            SizedBox(height: 32.h),

            // Payment Method Section
            Text(
              'Payment Options',
              style: AppTextStyle.bold(
                fontSize: 20.sp,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 16.h),
            _buildPaymentMethodSelector(),
            SizedBox(height: 32.h),

            // Continue Button
            CustomButton(
              buttonText: _selectedPlan == null
                  ? 'Select a Plan'
                  : 'Continue with ${_getPlanName(_selectedPlan!)}',
              onTap: _selectedPlan == null
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a plan to continue'),
                        ),
                      );
                    }
                  : () {
                      // Handle payment continuation
                      _handlePayment();
                    },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String planId,
    required String title,
    required String subtitle,
    required String description,
    required List<String> features,
    required String price,
    String? priceSubtext,
    required bool isPopular,
  }) {
    final isSelected = _selectedPlan == planId;
    return PlanCard(
      title: title,
      subtitle: subtitle,
      description: description,
      features: features,
      price: price,
      priceSubtext: priceSubtext,
      isPopular: isPopular,
      isSelected: isSelected,
      onTap: () {
        setState(() {
          _selectedPlan = planId;
        });
      },
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.credit_card, color: AppColors.black, size: 24.sp),
              SizedBox(width: 12.w),
              Text(
                'Debit/Credit Card',
                style: AppTextStyle.semiBold(
                  fontSize: 16.sp,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              SizedBox(width: 36.w),
              _buildPaymentIcon('Visa'),
              SizedBox(width: 8.w),
              _buildPaymentIcon('MasterCard'),
              SizedBox(width: 8.w),
              _buildPaymentIcon('AmEx'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentIcon(String type) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        type,
        style: AppTextStyle.medium(
          fontSize: 12.sp,
          color: AppColors.black,
        ),
      ),
    );
  }

  String _getPlanName(String planId) {
    switch (planId) {
      case 'free':
        return 'Free Access';
      case 'premium':
        return 'Premium Access';
      case 'spotlight':
        return 'Spotlight Access';
      case 'event':
        return 'Event & Product Listings';
      case 'school':
        return 'School & Training Partnerships';
      default:
        return 'Plan';
    }
  }

  void _handlePayment() {
    // Navigate to payment processing screen or handle payment
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Confirm Payment',
          style: AppTextStyle.bold(fontSize: 20.sp),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plan: ${_getPlanName(_selectedPlan!)}',
              style: AppTextStyle.medium(fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              'Payment Method: Debit/Credit Card',
              style: AppTextStyle.regular(fontSize: 14.sp),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyle.medium(
                fontSize: 14.sp,
                color: AppColors.grey,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Payment processing for ${_getPlanName(_selectedPlan!)}'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text(
              'Confirm',
              style: AppTextStyle.medium(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

