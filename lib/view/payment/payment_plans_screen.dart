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
              planId: 'barbers',
              title: 'Barbers Register',
              subtitle: 'Limited or Full Access',
              description: 'Start building your professional presence.',
              features: [
                'Limited access: create profile & browse public listings',
                'Full access: unlock unlimited search, messaging & reviews',
                'Switch between tiers anytime',
              ],
              price: 'Free / \$9.99',
              priceSubtext: 'Limited access (free) or full access (\$9.99/month)',
              isPopular: widget.userType == 'barber',
            ),
            SizedBox(height: 16.h),

            _buildPlanCard(
              planId: 'barbershops',
              title: 'BarberShops Register',
              subtitle: 'Limited or Full Access',
              description: 'Showcase your shop and connect with talent.',
              features: [
                'Limited access: list your shop & receive basic inquiries',
                'Full access: post roles, message barbers & track applicants',
                'Promote openings across the BarberzLink network',
              ],
              price: 'Free / \$9.99',
              priceSubtext: 'Limited access (free) or full access (\$9.99/month)',
              isPopular: widget.userType == 'barbershop',
            ),
            SizedBox(height: 16.h),

            _buildPlanCard(
              planId: 'events',
              title: 'Events Register',
              subtitle: 'One-Time Listing',
              description: 'Spotlight shows, product drops, or competitions.',
              features: [
                'Submit event or product details with media',
                'Highlighted placement in the BarberzLink calendar',
                'Shareable landing page for attendees',
              ],
              price: '\$150',
              priceSubtext: 'one-time payment',
              isPopular: widget.userType == 'event',
            ),
            SizedBox(height: 16.h),

            _buildPlanCard(
              planId: 'schools',
              title: 'Schools Register',
              subtitle: 'Full Access Subscription',
              description: 'Grow enrollment and place graduates faster.',
              features: [
                'Create verified school profile & program catalog',
                'Promote enrollment events & open houses',
                'Message barbershops for apprenticeship pipelines',
              ],
              price: '\$50.99/month',
              priceSubtext: 'full access subscription',
              isPopular: widget.userType == 'school',
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
      case 'barbers':
        return 'Barbers Register';
      case 'barbershops':
        return 'BarberShops Register';
      case 'events':
        return 'Events Register';
      case 'schools':
        return 'Schools Register';
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

