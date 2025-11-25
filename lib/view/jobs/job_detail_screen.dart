import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/models/job_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobDetailsScreen extends StatelessWidget {
  final JobModel job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share_outlined, color: Colors.black87),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            SizedBox(height: 18.h),
            _buildChipRow(),
            SizedBox(height: 24.h),
            _buildSection(
              title: 'About the role',
              child: Text(
                job.description,
                style: AppTextStyle.regular(
                    fontSize: 14.sp, color: Colors.black87),
              ),
            ),
            SizedBox(height: 18.h),
            _buildBulletedSection('Key responsibilities', job.responsibilities),
            SizedBox(height: 18.h),
            _buildBulletedSection('Must haves', job.mustHaves),
            SizedBox(height: 18.h),
            _buildBulletedSection('Good to haves', job.goodToHaves),
            SizedBox(height: 18.h),
            _buildBulletedSection('Perks & benefits', job.perks),
            SizedBox(height: 18.h),
            _buildBulletedSection('Culture highlights', job.cultureHighlights),
            SizedBox(height: 18.h),
            _buildSection(
              title: 'About ${job.companyName}',
              child: Text(
                job.aboutCompany,
                style: AppTextStyle.regular(fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 72.w,
            width: 72.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              image: DecorationImage(
                image: AssetImage(job.logo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.title, style: AppTextStyle.bold(fontSize: 18.sp)),
                SizedBox(height: 4.h),
                Text(job.companyName,
                    style: AppTextStyle.medium(fontSize: 14.sp)),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 16.sp, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        job.location,
                        style: AppTextStyle.regular(
                            fontSize: 12.sp, color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  '${job.salaryRange} · ${job.employmentType}',
                  style: AppTextStyle.medium(
                      fontSize: 12.sp, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipRow() {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        _infoChip(Icons.schedule, job.postedLabel),
        _infoChip(Icons.people_alt_outlined, '${job.applicants} applicants'),
        if (job.isRemoteFriendly)
          _infoChip(Icons.wifi_tethering, 'Remote friendly'),
        _infoChip(Icons.leaderboard_outlined, job.experienceLevel),
        if (job.isEasyApply) _infoChip(Icons.flash_on, 'Easy apply'),
      ],
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: Colors.black87),
          SizedBox(width: 6.w),
          Text(
            label,
            style: AppTextStyle.medium(fontSize: 12.sp, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.semiBold(fontSize: 16.sp)),
        SizedBox(height: 10.h),
        child,
      ],
    );
  }

  Widget _buildBulletedSection(String title, List<String> items) {
    return _buildSection(
      title: title,
      child: Column(
        children: items
            .map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(
                      child: Text(
                        item,
                        style: AppTextStyle.regular(
                            fontSize: 13.sp, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: const Text('Save for later'),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  job.isEasyApply ? 'Easy apply' : 'Apply',
                  style: AppTextStyle.semiBold(
                      fontSize: 14.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
