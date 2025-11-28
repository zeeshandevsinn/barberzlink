import 'package:barberzlink/models/job_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

class JobDetailsScreen extends StatefulWidget {
  final JobModel job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final bool shouldShowTitle = _scrollController.offset > 100;
    if (shouldShowTitle != _showAppBarTitle) {
      setState(() {
        _showAppBarTitle = shouldShowTitle;
      });
    }
  }

  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });

    // Haptic feedback
    // HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildHeroHeader(),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildChipRow()
                      .animate(delay: 200.ms)
                      .fadeIn()
                      .slideY(begin: 0.1),
                  SizedBox(height: 28.h),
                  _buildSection(
                    title: 'About the Role',
                    child: Text(
                      widget.job.description,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey.shade700,
                        height: 1.6,
                      ),
                    ),
                  ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1),
                  SizedBox(height: 24.h),
                  _buildBulletedSection(
                    'Key Responsibilities',
                    widget.job.responsibilities,
                    icon: Icons.checklist_rounded,
                  ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.1),
                  SizedBox(height: 24.h),
                  _buildBulletedSection(
                    'Must Haves',
                    widget.job.mustHaves,
                    icon: Icons.verified_rounded,
                    color: Colors.red.shade50,
                    textColor: Colors.red.shade700,
                  ).animate(delay: 500.ms).fadeIn().slideY(begin: 0.1),
                  SizedBox(height: 24.h),
                  _buildBulletedSection(
                    'Good to Haves',
                    widget.job.goodToHaves,
                    icon: Icons.star_border_rounded,
                    color: Colors.blue.shade50,
                    textColor: Colors.blue.shade700,
                  ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.1),
                  SizedBox(height: 24.h),
                  _buildBulletedSection(
                    'Perks & Benefits',
                    widget.job.perks,
                    icon: Icons.celebration_rounded,
                    color: Colors.green.shade50,
                    textColor: Colors.green.shade700,
                  ).animate(delay: 700.ms).fadeIn().slideY(begin: 0.1),
                  SizedBox(height: 24.h),
                  _buildBulletedSection(
                    'Culture Highlights',
                    widget.job.cultureHighlights,
                    icon: Icons.people_alt_rounded,
                    color: Colors.purple.shade50,
                    textColor: Colors.purple.shade700,
                  ).animate(delay: 800.ms).fadeIn().slideY(begin: 0.1),
                  SizedBox(height: 24.h),
                  _buildSection(
                    title: 'About ${widget.job.companyName}',
                    child: Text(
                      widget.job.aboutCompany,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey.shade700,
                        height: 1.6,
                      ),
                    ),
                  ).animate(delay: 900.ms).fadeIn().slideY(begin: 0.1),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
      // floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _showAppBarTitle
          ? Colors.white.withOpacity(0.95)
          : Colors.transparent,
      elevation: _showAppBarTitle ? 4 : 0,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child:
              Icon(Icons.arrow_back_rounded, color: Colors.black, size: 20.sp),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: AnimatedOpacity(
        opacity: _showAppBarTitle ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Text(
          widget.job.title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      actions: [
        // IconButton(
        //   icon: Container(
        //     padding: EdgeInsets.all(8.w),
        //     decoration: BoxDecoration(
        //       color: Colors.white.withOpacity(0.9),
        //       shape: BoxShape.circle,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.black.withOpacity(0.1),
        //           blurRadius: 8,
        //           offset: const Offset(0, 2),
        //         ),
        //       ],
        //     ),
        //     child: Icon(
        //       Icons.share_rounded,
        //       color: Colors.black,
        //       size: 20.sp,
        //     ),
        //   ),
        //   onPressed: _shareJob,
        // ),

        SizedBox(width: 8.w),
      ],
    );
  }

  Widget _buildHeroHeader() {
    return Stack(
      children: [
        // Background Gradient
        Container(
          height: 280.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF1A1A1A),
                const Color(0xFF1A1A1A).withOpacity(0.9),
              ],
            ),
          ),
        ),

        // Content
        Container(
          height: 300.h,
          padding: EdgeInsets.fromLTRB(20.w, 80.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Logo and Basic Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Icon(
                      Icons.business_center_rounded,
                      color: Colors.white,
                      size: 32.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.job.title,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          widget.job.companyName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded,
                                size: 16.sp,
                                color: Colors.white.withOpacity(0.7)),
                            SizedBox(width: 4.w),
                            Text(
                              widget.job.location,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3),

              SizedBox(height: 20.h),

              // Salary and Employment Type
              Row(
                children: [
                  _buildInfoPill(
                    Icons.attach_money_rounded,
                    widget.job.salaryRange,
                  ),
                  SizedBox(width: 12.w),
                  _buildInfoPill(
                    Icons.schedule_rounded,
                    widget.job.employmentType,
                  ),
                  if (widget.job.isRemoteFriendly) ...[
                    SizedBox(width: 12.w),
                    _buildInfoPill(
                      Icons.work_outline_rounded,
                      'Remote OK',
                    ),
                  ],
                ],
              )
                  .animate(delay: 100.ms)
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.2),

              const Spacer(),
              SizedBox(
                height: 20,
              ),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16.r),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _toggleSave,
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _isSaved
                                      ? Icons.bookmark_rounded
                                      : Icons.bookmark_border_rounded,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  _isSaved ? 'Saved' : 'Save Job',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF667EEA).withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _applyToJob,
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  widget.job.isEasyApply
                                      ? Icons.flash_on_rounded
                                      : Icons.send_rounded,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  widget.job.isEasyApply
                                      ? 'Easy Apply'
                                      : 'Apply Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.1),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoPill(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: Colors.white.withOpacity(0.8)),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipRow() {
    final chips = [
      _buildDetailChip(Icons.schedule_rounded, widget.job.postedLabel),
      _buildDetailChip(
          Icons.people_alt_rounded, '${widget.job.applicants} applicants'),
      if (widget.job.isRemoteFriendly)
        _buildDetailChip(Icons.work_outline_rounded, 'Remote friendly'),
      _buildDetailChip(Icons.leaderboard_rounded, widget.job.experienceLevel),
      if (widget.job.isEasyApply)
        _buildDetailChip(Icons.flash_on_rounded, 'Easy apply'),
    ];

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: chips,
    );
  }

  Widget _buildDetailChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: const Color(0xFF1A1A1A)),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        child,
      ],
    );
  }

  Widget _buildBulletedSection(
    String title,
    List<String> items, {
    IconData? icon,
    Color? color,
    Color? textColor,
  }) {
    return _buildSection(
      title: title,
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  margin: EdgeInsets.only(right: 12.w, top: 2.h),
                  decoration: BoxDecoration(
                    color: color ?? const Color(0xFF1A1A1A).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon ?? Icons.circle_rounded,
                    size: 8.sp,
                    color: textColor ?? const Color(0xFF1A1A1A),
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: textColor ?? Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ).animate(delay: (100 + index * 50).ms).fadeIn().slideX(begin: 0.3),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _toggleSave,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    side: BorderSide(
                      color: _isSaved ? Colors.green : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isSaved
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        color: _isSaved ? Colors.green : Colors.grey.shade700,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _isSaved ? 'Saved' : 'Save for later',
                        style: TextStyle(
                          color: _isSaved ? Colors.green : Colors.grey.shade700,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: _applyToJob,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.job.isEasyApply
                            ? Icons.flash_on_rounded
                            : Icons.send_rounded,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.job.isEasyApply ? 'Easy Apply' : 'Apply Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildFloatingActionButton() {
  //   return FloatingActionButton(
  //     onPressed: _shareJob,
  //     backgroundColor: Colors.white,
  //     elevation: 4,
  //     child: Icon(
  //       Icons.share_rounded,
  //       color: const Color(0xFF1A1A1A),
  //       size: 24.sp,
  //     ),
  //   )
  //       .animate(onPlay: (controller) => controller.repeat(reverse: true))
  //       .shake(duration: 2000.ms, hz: 2);
  // }

  // void _shareJob() {
  //   // Implement share functionality
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Sharing ${widget.job.title}'),
  //       behavior: SnackBarBehavior.floating,
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
  //     ),
  //   );
  // }

  void _applyToJob() {
    // Implement apply functionality
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(top: 100.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 20.h),
                Icon(Icons.celebration_rounded,
                    size: 48.sp, color: Colors.green),
                SizedBox(height: 16.h),
                Text(
                  'Application Started!',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Your application for ${widget.job.title} has been received.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'Got It',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ).animate().slideY(begin: 1, end: 0).fadeIn();
      },
    );
  }
}
