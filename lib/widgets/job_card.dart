import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theme/app_theme.dart';
import '../models/job_model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final bool isSaved;
  final bool isApplied;
  final VoidCallback onTap;
  final VoidCallback onToggleSave;
  final VoidCallback onApply;
  final EdgeInsetsGeometry? margin;

  const JobCard({
    super.key,
    required this.job,
    required this.isSaved,
    required this.isApplied,
    required this.onTap,
    required this.onToggleSave,
    required this.onApply,
    this.margin,
  });

  Color get _borderColor =>
      job.isPromoted ? const Color(0xFF5468FF) : Colors.grey.shade200;

  @override
  Widget build(BuildContext context) {
    final tags = job.tags.take(4).toList();

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: margin ?? EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border:
              Border.all(color: _borderColor, width: job.isPromoted ? 1.4 : 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            if (job.isPromoted) ...[
              SizedBox(height: 8.h),
              _buildBadge('Promoted spotlight'),
            ],
            SizedBox(height: 12.h),
            Text(
              job.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.regular(
                  color: Colors.grey.shade700, fontSize: 13.sp),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: tags
                  .map(
                    (tag) => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: const Color(0xFFF3F4F6),
                      ),
                      child: Text(
                        tag,
                        style: AppTextStyle.medium(
                            fontSize: 11.sp, color: Colors.black87),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16.h),
            _buildMetaRow(),
            SizedBox(height: 14.h),
            _buildActionRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 56.w,
          width: 56.w,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F1F5),
            borderRadius: BorderRadius.circular(16.r),
            image: DecorationImage(
              image: AssetImage(job.logo),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.title,
                style: AppTextStyle.bold(fontSize: 16.sp),
              ),
              SizedBox(height: 4.h),
              Text(
                job.companyName,
                style: AppTextStyle.medium(
                    fontSize: 13.sp, color: Colors.grey.shade800),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 14.sp, color: Colors.grey),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      job.location,
                      style: AppTextStyle.regular(
                          fontSize: 12.sp, color: Colors.grey.shade600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: onToggleSave,
              icon: Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: isSaved ? Colors.black : Colors.grey.shade500,
              ),
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
            SizedBox(height: 8.h),
            Text(
              job.postedLabel,
              style: AppTextStyle.regular(
                  fontSize: 11.sp, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetaRow() {
    return Row(
      children: [
        _buildMetaChip(Icons.attach_money, job.salaryRange),
        SizedBox(width: 12.w),
        _buildMetaChip(
          Icons.work_outline,
          job.employmentType,
        ),
        SizedBox(width: 12.w),
        _buildMetaChip(
          Icons.people_alt_outlined,
          '${job.applicants} applicants',
        ),
      ],
    );
  }

  Widget _buildMetaChip(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16.sp, color: Colors.black87),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                label,
                style:
                    AppTextStyle.medium(fontSize: 11.sp, color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionRow() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onToggleSave,
            icon: Icon(
              isSaved ? Icons.check_circle : Icons.bookmark_add_outlined,
              color: Colors.black87,
            ),
            label: Text(
              isSaved ? 'Saved' : 'Save',
              style: AppTextStyle.medium(fontSize: 13.sp),
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: isApplied ? null : onApply,
            icon: Icon(
              isApplied
                  ? Icons.verified
                  : (job.isEasyApply ? Icons.flash_on : Icons.send),
              size: 18.sp,
            ),
            label: Text(
              isApplied
                  ? 'Applied'
                  : job.isEasyApply
                      ? 'Easy apply'
                      : 'Apply',
              style:
                  AppTextStyle.semiBold(fontSize: 13.sp, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: isApplied ? Colors.grey.shade600 : Colors.black,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EBFF),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: AppTextStyle.medium(
            fontSize: 11.sp, color: const Color(0xFF4A5DFF)),
      ),
    );
  }
}
