import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/models/job_model.dart';
import 'package:barberzlink/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobBoardScreen extends StatefulWidget {
  const JobBoardScreen({super.key});

  @override
  State<JobBoardScreen> createState() => _JobBoardScreenState();
}

class _JobBoardScreenState extends State<JobBoardScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _tabs = const [
    'Suggested',
    'My Jobs',
    'Saved',
    'Postings'
  ];
  final List<String> _filters = const [
    'Remote',
    'Full-time',
    'Senior',
    'Instant apply',
    'Recently posted',
  ];

  final Set<String> _selectedFilters = {'Remote', 'Full-time'};
  final Map<String, bool> _savedState = {};
  final Map<String, bool> _appliedState = {};
  int _activeTabIndex = 0;

  List<JobModel> get _allJobs => Injections.instance.jobsFeed;

  List<JobModel> get _filteredJobs {
    final base = _filterByTab(_allJobs);
    final query = _searchController.text.trim().toLowerCase();

    return base.where((job) {
      if (_selectedFilters.contains('Remote') && !job.isRemoteFriendly) {
        return false;
      }
      if (_selectedFilters.contains('Full-time') &&
          !job.employmentType.toLowerCase().contains('full')) {
        return false;
      }
      if (_selectedFilters.contains('Senior') &&
          !job.experienceLevel.toLowerCase().contains('senior')) {
        return false;
      }
      if (_selectedFilters.contains('Instant apply') && !job.isEasyApply) {
        return false;
      }
      if (_selectedFilters.contains('Recently posted') &&
          DateTime.now().difference(job.postedOn).inDays > 3) {
        return false;
      }

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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async =>
              Future.delayed(const Duration(milliseconds: 600)),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverToBoxAdapter(child: _buildHeroHeader(context)),
              SliverToBoxAdapter(child: _buildSearchField()),
              SliverToBoxAdapter(child: _buildTabs()),
              SliverToBoxAdapter(child: _buildFilters()),
              SliverToBoxAdapter(child: _buildSpotlights()),
              jobs.isEmpty
                  ? SliverFillRemaining(
                      hasScrollBody: false,
                      child: _buildEmptyState(),
                    )
                  : SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                      sliver: SliverList.separated(
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          final job = jobs[index];
                          return JobCard(
                            job: job,
                            isSaved: _isSaved(job),
                            isApplied: _isApplied(job),
                            onTap: () => AppRoutes.goTo(
                              context,
                              AppRoutes.job_detail,
                              arguments: job,
                            ),
                            onToggleSave: () => _toggleSave(job),
                            onApply: () => _toggleApply(job),
                            margin: EdgeInsets.zero,
                          );
                        },
                        separatorBuilder: (_, __) => SizedBox(height: 18.h),
                      ),
                    ),
              SliverToBoxAdapter(child: SizedBox(height: 90.h)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () => AppRoutes.goTo(context, AppRoutes.job_post),
        icon: const Icon(Icons.add),
        label: const Text('Post a job'),
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 16.h),
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF111111), Color(0xFF2A2A2A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jobs for you',
              style: AppTextStyle.bold(color: Colors.white, fontSize: 20.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              'Stay booked like LinkedIn pros — discover hires, share openings, and track applicants.',
              style:
                  AppTextStyle.regular(color: Colors.white70, fontSize: 13.sp),
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                _buildStatPill(
                  label: 'New leads',
                  value: '12',
                  icon: Icons.local_fire_department_outlined,
                ),
                SizedBox(width: 12.w),
                _buildStatPill(
                  label: 'Applicants',
                  value: '236',
                  icon: Icons.people_outline,
                ),
                SizedBox(width: 12.w),
                _buildStatPill(
                  label: 'Saved',
                  value: '${_allJobs.where((job) => job.isSaved).length}',
                  icon: Icons.bookmark_border,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatPill({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 18.sp),
            SizedBox(height: 6.h),
            Text(
              value,
              style: AppTextStyle.bold(color: Colors.white, fontSize: 16.sp),
            ),
            Text(
              label,
              style:
                  AppTextStyle.regular(color: Colors.white70, fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Search by title, company, or city',
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return SizedBox(
      height: 48.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final selected = _activeTabIndex == index;
          return ChoiceChip(
            label: Text(
              _tabs[index],
              style: AppTextStyle.semiBold(
                fontSize: 13.sp,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
            selected: selected,
            onSelected: (_) => setState(() => _activeTabIndex = index),
            selectedColor: Colors.black,
            backgroundColor: const Color(0xFFF5F5F5),
            showCheckmark: false,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemCount: _tabs.length,
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Wrap(
        spacing: 10.w,
        runSpacing: 10.h,
        children: _filters
            .map(
              (filter) => FilterChip(
                selected: _selectedFilters.contains(filter),
                label: Text(
                  filter,
                  style: AppTextStyle.medium(
                    fontSize: 12.sp,
                    color: _selectedFilters.contains(filter)
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
                onSelected: (_) => _toggleFilter(filter),
                backgroundColor: const Color(0xFFF2F2F2),
                selectedColor: Colors.black,
                showCheckmark: false,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSpotlights() {
    final spotlights = [
      {
        'title': 'Studios hiring now',
        'subtitle': '8 LA productions need on-set grooming',
      },
      {
        'title': 'Schools graduating',
        'subtitle': '120+ seniors ready for apprenticeship',
      },
      {
        'title': 'Mobile concierge',
        'subtitle': 'NYC + Miami routes expanding this month',
      },
    ];

    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 18.h, 0, 12.h),
      child: SizedBox(
        height: 120.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final spotlight = spotlights[index];
            return Container(
              width: 220.w,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spotlight['title']!,
                    style: AppTextStyle.semiBold(fontSize: 14.sp),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    spotlight['subtitle']!,
                    style: AppTextStyle.regular(
                        fontSize: 12.sp, color: Colors.grey.shade700),
                  ),
                  const Spacer(),
                  Text(
                    'View insights →',
                    style: AppTextStyle.medium(
                        fontSize: 12.sp, color: Colors.black87),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => SizedBox(width: 12.w),
          itemCount: spotlights.length,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work_outline, size: 54.sp, color: Colors.grey.shade400),
          SizedBox(height: 12.h),
          Text(
            'No roles match yet',
            style: AppTextStyle.semiBold(fontSize: 16.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            'Adjust filters or expand geography to see more roles like on LinkedIn job feeds.',
            textAlign: TextAlign.center,
            style: AppTextStyle.regular(
                fontSize: 13.sp, color: Colors.grey.shade600),
          ),
          SizedBox(height: 20.h),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedFilters.clear();
              });
            },
            child: const Text('Reset filters'),
          ),
        ],
      ),
    );
  }

  List<JobModel> _filterByTab(List<JobModel> jobs) {
    switch (_activeTabIndex) {
      case 1:
        return jobs.where((job) => _isApplied(job)).toList();
      case 2:
        return jobs.where((job) => _isSaved(job)).toList();
      case 3:
        return jobs.where((job) => job.isOwnerPosting).toList();
      default:
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
}
