import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/models/job_model.dart';
import 'package:barberzlink/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobBoardBarberScreen extends StatefulWidget {
  const JobBoardBarberScreen({super.key});

  @override
  State<JobBoardBarberScreen> createState() => _JobBoardBarberScreenState();
}

class _JobBoardBarberScreenState extends State<JobBoardBarberScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _keywordController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final List<String> _tabs = const [
    'All Jobs',
    'Nearby',
    'Saved',
  ];
  final List<String> _filters = const [
    'Remote',
    'Full-time',
    'Part-time',
    'Senior',
    'Junior',
    'Urgent Hire',
    'High Salary'
  ];

  final Set<String> _selectedFilters = {'Full-time'};
  final Map<String, bool> _savedState = {};
  final Map<String, bool> _appliedState = {};
  int _activeTabIndex = 0;
  bool showFilters = true;

  List<JobModel> get _allJobs => Injections.instance.jobsFeed;

  List<JobModel> get _filteredJobs {
    final base = _filterByTab(_allJobs);
    final query = _searchController.text.trim().toLowerCase();

    return base.where((job) {
      // Filter logic
      if (_selectedFilters.contains('Remote') && !job.isRemoteFriendly) {
        return false;
      }
      if (_selectedFilters.contains('Full-time') &&
          !job.employmentType.toLowerCase().contains('full')) {
        return false;
      }
      if (_selectedFilters.contains('Part-time') &&
          !job.employmentType.toLowerCase().contains('part')) {
        return false;
      }
      if (_selectedFilters.contains('Senior') &&
          !job.experienceLevel.toLowerCase().contains('senior')) {
        return false;
      }
      if (_selectedFilters.contains('Junior') &&
          !job.experienceLevel.toLowerCase().contains('junior')) {
        return false;
      }
      if (_selectedFilters.contains('Urgent Hire') && !job.isPromoted) {
        return false;
      }
      if (_selectedFilters.contains('High Salary') &&
          !job.salaryRange.contains('\$80')) {
        return false;
      }

      // Search logic
      if (query.isNotEmpty) {
        final haystack =
            '${job.title} ${job.companyName} ${job.location} ${job.tags.join(' ')}'
                .toLowerCase();
        return haystack.contains(query);
      }

      return true;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = _filteredJobs;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
            await Future.delayed(const Duration(milliseconds: 600));
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverToBoxAdapter(child: _buildHeroHeader()),
              SliverToBoxAdapter(child: _buildSearchField()),
              SliverToBoxAdapter(
                  child: showFilters ? _buildTabs() : SizedBox.shrink()),
              SliverToBoxAdapter(
                  child: showFilters ? _buildFilters() : SizedBox.shrink()),
              SliverToBoxAdapter(child: _buildFeaturedJobs()),
              jobs.isEmpty
                  ? SliverFillRemaining(
                      hasScrollBody: false,
                      child: _buildEmptyState(),
                    )
                  : SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      sliver: SliverList.separated(
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          final job = jobs[index];
                          return InkWell(
                            onTap: () {
                              AppRoutes.goTo(context, AppRoutes.job_detail,
                                  arguments: job);
                            },
                            borderRadius: BorderRadius.circular(20.r),
                            child: _buildJobCard(job),
                          );
                        },
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      ),
                    ),
              SliverToBoxAdapter(child: SizedBox(height: 90.h)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF1A1A1A),
        onPressed: _showPostJobDialog,
        icon: Icon(Icons.add, color: Colors.white, size: 20.sp),
        label: Text('Post a Job',
            style: TextStyle(color: Colors.white, fontSize: 14.sp)),
      ),
    );
  }

  Widget _buildHeroHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A1A), Color(0xFF2D2D2D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Barber Jobs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.notifications_outlined,
                    color: Colors.white, size: 22.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Find your next chair in top barbershops',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 25.h),
          Row(
            children: [
              _buildStatCard(
                value: '${_allJobs.length}',
                label: 'Active Jobs',
                icon: Icons.work_outline,
              ),
              SizedBox(width: 12.w),
              _buildStatCard(
                value:
                    '${_allJobs.where((job) => job.location.contains('NY')).length}',
                label: 'Near You',
                icon: Icons.location_on_outlined,
              ),
              SizedBox(width: 12.w),
              _buildStatCard(
                value: '${_allJobs.where((job) => job.isPromoted).length}',
                label: 'Hiring Urgently',
                icon: Icons.access_time_filled,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 18.sp),
            SizedBox(height: 8.h),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String selectedStates = 'All States';

  Widget _buildSearchField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
        child: CustomSearchBar(
            keywordController: _keywordController,
            cityController: _cityController,
            zipController: _zipCodeController,
            selectedState: selectedStates,
            states: Injections.instance.states,
            onStateChanged: (e) {
              setState(() {
                selectedStates = e ?? '';
              });
            },
            onSearch: () {}));
  }

  Widget _buildTabs() {
    return SizedBox(
      height: 50.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final selected = _activeTabIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _activeTabIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF1A1A1A) : Colors.transparent,
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(
                  color:
                      selected ? const Color(0xFF1A1A1A) : Colors.grey.shade300,
                ),
              ),
              child: Text(
                _tabs[index],
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : Colors.grey.shade700,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemCount: _tabs.length,
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: _filters
            .map(
              (filter) => GestureDetector(
                onTap: () => _toggleFilter(filter),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: _selectedFilters.contains(filter)
                        ? const Color(0xFF1A1A1A)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: _selectedFilters.contains(filter)
                          ? const Color(0xFF1A1A1A)
                          : Colors.grey.shade300,
                    ),
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
                      Text(
                        filter,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: _selectedFilters.contains(filter)
                              ? Colors.white
                              : Colors.grey.shade700,
                        ),
                      ),
                      if (_selectedFilters.contains(filter)) ...[
                        SizedBox(width: 4.w),
                        Icon(Icons.check, size: 14.sp, color: Colors.white),
                      ],
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildFeaturedJobs() {
    // Get featured jobs (promoted jobs)
    final featuredJobs =
        _allJobs.where((job) => job.isPromoted).take(3).toList();

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 0, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.h, right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Featured Jobs',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                // Text(
                //   'See All',
                //   style: TextStyle(
                //     fontSize: 14.sp,
                //     color: const Color(0xFF1A1A1A),
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 300.spMax,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final job = featuredJobs[index];
                return InkWell(
                  onTap: () {
                    AppRoutes.goTo(context, AppRoutes.job_detail,
                        arguments: job);
                  },
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    width: 280.w,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.red.shade100,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with Featured tag
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: Colors.red.shade100),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star_rounded,
                                      size: 12.sp, color: Colors.red),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Featured',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              job.postedLabel,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),

                        // Job title and company
                        Text(
                          job.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          job.companyName,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),

                        // Location and salary
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 14.sp, color: Colors.grey.shade500),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                job.location,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(Icons.attach_money_rounded,
                                size: 14.sp, color: Colors.green.shade600),
                            SizedBox(width: 4.w),
                            Text(
                              job.salaryRange,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),

                        // Job details chips
                        Wrap(
                          spacing: 6.w,
                          runSpacing: 6.h,
                          children: [
                            _buildFeaturedChip(
                                job.employmentType, Icons.schedule_rounded),
                            _buildFeaturedChip(
                                job.experienceLevel, Icons.leaderboard_rounded),
                            if (job.isRemoteFriendly)
                              _buildFeaturedChip(
                                  'Remote', Icons.work_outline_rounded),
                          ],
                        ),
                        SizedBox(height: 12.h),

                        // Tags
                        Wrap(
                          spacing: 4.w,
                          runSpacing: 4.h,
                          children: job.tags
                              .take(2)
                              .map((tag) => Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.w, vertical: 3.h),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Text(
                                      tag,
                                      style: TextStyle(
                                        fontSize: 9.sp,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        SizedBox(height: 12.h),

                        // Footer with applicants and apply button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${job.applicants} applicants',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                AppRoutes.goTo(context, AppRoutes.job_detail,
                                    arguments: job);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1A1A1A),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 6.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                'Apply Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemCount: featuredJobs.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedChip(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A).withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10.sp, color: const Color(0xFF1A1A1A)),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 9.sp,
              color: const Color(0xFF1A1A1A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(JobModel job) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                job.postedLabel,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey.shade500,
                ),
              ),
              if (job.isPromoted)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.red.shade100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.flash_on, size: 10.sp, color: Colors.red),
                      SizedBox(width: 4.w),
                      Text(
                        'Urgent',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: AssetImage(
                      job.logo,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      job.companyName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 14.sp, color: Colors.grey.shade500),
                        SizedBox(width: 4.w),
                        Text(
                          job.location,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _toggleSave(job),
                child: Icon(
                  _isSaved(job) ? Icons.bookmark : Icons.bookmark_border,
                  color: _isSaved(job)
                      ? const Color(0xFF1A1A1A)
                      : Colors.grey.shade400,
                  size: 22.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildJobChip(job.salaryRange, Icons.attach_money),
                SizedBox(width: 8.w),
                _buildJobChip(job.employmentType, Icons.schedule),
                if (job.isRemoteFriendly) ...[
                  SizedBox(width: 8.w),
                  _buildJobChip('Remote', Icons.work_outline),
                ],
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: job.tags
                .take(3)
                .map((tag) => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 16.h),
          Text(
            '${job.applicants} applicants',
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => _toggleApply(job),
                style: OutlinedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  side: BorderSide(
                    color: _isApplied(job)
                        ? Colors.green
                        : const Color(0xFF1A1A1A),
                  ),
                ),
                child: Text(
                  _isApplied(job) ? 'Applied' : 'Apply Now',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: _isApplied(job)
                        ? Colors.green
                        : const Color(0xFF1A1A1A),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              if (!_isApplied(job) && job.isEasyApply)
                ElevatedButton(
                  onPressed: () => _showQuickApply(job),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Quick Apply',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobChip(String text, IconData icon, {bool isUrgent = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isUrgent
            ? const Color(0xFFFFE6E6)
            : const Color(0xFF1A1A1A).withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 12.sp,
              color: isUrgent ? Colors.red : const Color(0xFF1A1A1A)),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: isUrgent ? Colors.red : const Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work_outline, size: 80.sp, color: Colors.grey.shade300),
          SizedBox(height: 20.h),
          Text(
            'No jobs found',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your filters or search terms to find more barber opportunities.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedFilters.clear();
                _searchController.clear();
                _activeTabIndex = 0;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A1A1A),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Clear All Filters',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  List<JobModel> _filterByTab(List<JobModel> jobs) {
    switch (_activeTabIndex) {
      case 1: // Nearby
        return jobs.where((job) => job.location.contains('NY')).toList();
      case 2: // Saved
        return jobs.where((job) => _isSaved(job)).toList();
      case 3: // Applications
        return jobs.where((job) => _isApplied(job)).toList();
      default: // All Jobs
        return jobs;
    }
  }

  bool _isSaved(JobModel job) => _savedState[job.id] ?? job.isSaved;
  bool _isApplied(JobModel job) => _appliedState[job.id] ?? job.isApplied;

  void _toggleSave(JobModel job) {
    setState(() {
      final current = _isSaved(job);
      _savedState[job.id] = !current;
    });
  }

  void _toggleApply(JobModel job) {
    setState(() {
      final current = _isApplied(job);
      _appliedState[job.id] = !current;
    });
  }

  void _toggleFilter(String filter) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
  }

  void _showQuickApply(JobModel job) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Quick Apply to ${job.companyName}'),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                _toggleApply(job);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Application submitted!')),
                );
              },
              child: Text('Submit Application'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPostJobDialog() {
    AppRoutes.goTo(context, AppRoutes.job_post);
  }
}

// Corrected Mock data using JobModel
