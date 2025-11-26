import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/models/job_model.dart';
import 'package:barberzlink/widgets/custom_textfield.dart';
import 'package:barberzlink/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobPostScreen extends StatefulWidget {
  const JobPostScreen({super.key});

  @override
  State<JobPostScreen> createState() => _JobPostScreenState();
}

class _JobPostScreenState extends State<JobPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController =
      TextEditingController(text: 'Lead Master Barber');
  final TextEditingController _companyController =
      TextEditingController(text: 'Legends Grooming Lounge');
  final TextEditingController _taglineController = TextEditingController(
      text: 'Luxury grooming collective scaling nationwide.');
  final TextEditingController _locationController =
      TextEditingController(text: 'Atlanta, GA (Hybrid)');
  final TextEditingController _salaryController =
      TextEditingController(text: '\$80k - \$95k + tips');
  final TextEditingController _descriptionController = TextEditingController(
      text:
          'Champion the craft, lead culture, and keep our VIP waitlist short by crafting signature looks.');
  final TextEditingController _aboutController = TextEditingController(
      text:
          'Legends blends hospitality, creative studios, and top-tier grooming talent into a modern residency experience.');
  final TextEditingController _newResponsibilityController =
      TextEditingController();
  final TextEditingController _mustHaveController = TextEditingController();
  final TextEditingController _niceToHaveController = TextEditingController();

  final List<String> _employmentTypes = const [
    'Full-time',
    'Part-time',
    'Contract',
    'Freelance collective',
  ];
  String _selectedEmploymentType = 'Full-time';
  bool _isRemoteFriendly = true;
  double _experienceLevel = 2; // 0-entry, 1-mid, 2-senior, 3-director

  final List<String> _responsibilities = [
    'Host advanced cut labs & coach junior barbers.',
    'Lead premium consultations end-to-end.',
    'Capture content with creative team weekly.',
  ];

  final List<String> _mustHaveSkills = [
    'Active state license',
    '5+ years premium clientele',
  ];

  final List<String> _niceToHaves = [
    'Content creation or education experience',
    'Multi-state license transfers',
  ];

  final List<String> _perkOptions = const [
    'Profit share',
    'Education stipend',
    'Wellness fund',
    'Content studio access',
    'Equity path',
  ];

  final Set<String> _selectedPerks = {'Profit share', 'Education stipend'};

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _taglineController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    _descriptionController.dispose();
    _aboutController.dispose();
    _newResponsibilityController.dispose();
    _mustHaveController.dispose();
    _niceToHaveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a job'),
        actions: [
          TextButton(
            onPressed: _openPreviewSheet,
            child: const Text('Preview'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Job basics'),
              SizedBox(height: 12.h),
              CustomTextField(
                  label: 'Job title',
                  controller: _titleController,
                  hintText: ''),
              SizedBox(height: 12.h),
              CustomTextField(
                  label: 'Company / Shop', controller: _companyController),
              SizedBox(height: 12.h),
              CustomTextField(label: 'Tagline', controller: _taglineController),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        label: 'Location', controller: _locationController),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomTextField(
                      label: 'Compensation',
                      controller: _salaryController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text('Employment type',
                  style: AppTextStyle.semiBold(fontSize: 14.sp)),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 10.w,
                children: _employmentTypes
                    .map(
                      (type) => ChoiceChip(
                        label: Text(type),
                        selected: _selectedEmploymentType == type,
                        onSelected: (_) =>
                            setState(() => _selectedEmploymentType = type),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 16.h),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Remote friendly'),
                subtitle: const Text('Show on maps + allow remote candidates'),
                value: _isRemoteFriendly,
                onChanged: (value) => setState(() => _isRemoteFriendly = value),
              ),
              Divider(height: 32.h),
              _buildSectionTitle('Role details'),
              SizedBox(height: 12.h),
              Text('Experience level: ${_experienceLabel()}',
                  style: AppTextStyle.medium(fontSize: 14.sp)),
              Slider(
                value: _experienceLevel,
                min: 0,
                max: 3,
                divisions: 3,
                label: _experienceLabel(),
                onChanged: (value) => setState(() => _experienceLevel = value),
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                label: 'Role summary',
                controller: _descriptionController,
                maxLines: 4,
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                label: 'About the team',
                controller: _aboutController,
                maxLines: 4,
              ),
              SizedBox(height: 20.h),
              _buildSectionTitle('Responsibilities'),
              SizedBox(height: 8.h),
              ..._responsibilities
                  .map((item) => _buildBulletTile(item, onDelete: () {
                        setState(() => _responsibilities.remove(item));
                      })),
              SizedBox(height: 10.h),
              _buildComposer(
                controller: _newResponsibilityController,
                hint: 'Add responsibility',
                onAdd: () => _handleAddItem(
                    _responsibilities, _newResponsibilityController),
              ),
              SizedBox(height: 20.h),
              _buildSectionTitle('Must haves'),
              SizedBox(height: 8.h),
              _buildChipList(_mustHaveSkills, Colors.white, () {
                setState(() {});
              }),
              _buildComposer(
                controller: _mustHaveController,
                hint: 'Add requirement',
                onAdd: () =>
                    _handleAddItem(_mustHaveSkills, _mustHaveController),
              ),
              SizedBox(height: 20.h),
              _buildSectionTitle('Nice to haves'),
              SizedBox(height: 8.h),
              _buildChipList(_niceToHaves, Colors.grey.shade700, () {
                setState(() {});
              }),
              _buildComposer(
                controller: _niceToHaveController,
                hint: 'Add nice to have',
                onAdd: () =>
                    _handleAddItem(_niceToHaves, _niceToHaveController),
              ),
              SizedBox(height: 20.h),
              _buildSectionTitle('Perks & signals'),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: _perkOptions
                    .map(
                      (perk) => FilterChip(
                        selected: _selectedPerks.contains(perk),
                        label: Text(perk),
                        onSelected: (_) {
                          setState(() {
                            if (_selectedPerks.contains(perk)) {
                              _selectedPerks.remove(perk);
                            } else {
                              _selectedPerks.add(perk);
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 24.h),
              _buildSectionTitle('Live preview'),
              SizedBox(height: 10.h),
              JobCard(
                job: _buildPreviewJob(),
                isSaved: false,
                isApplied: false,
                onTap: () {},
                onToggleSave: () {},
                onApply: () {},
                margin: EdgeInsets.zero,
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _openPreviewSheet,
                  child: const Text('Save draft'),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: _openPreviewSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.semiBold(fontSize: 16.sp),
    );
  }

  Widget _buildBulletTile(String text, {required VoidCallback onDelete}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          const Text('• '),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.regular(fontSize: 13.sp),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  Widget _buildComposer({
    required TextEditingController controller,
    required String hint,
    required VoidCallback onAdd,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        IconButton(
          onPressed: onAdd,
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }

  Widget _buildChipList(
      List<String> items, Color color, VoidCallback onRemove) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: items
          .map(
            (item) => Chip(
              label: Text(item, style: TextStyle(color: color)),
              onDeleted: () {
                setState(() {
                  items.remove(item);
                });
                onRemove();
              },
            ),
          )
          .toList(),
    );
  }

  String _experienceLabel() {
    switch (_experienceLevel.round()) {
      case 0:
        return 'Entry';
      case 1:
        return 'Mid-level';
      case 2:
        return 'Senior';
      default:
        return 'Director';
    }
  }

  void _handleAddItem(List<String> target, TextEditingController controller) {
    final value = controller.text.trim();
    if (value.isEmpty) return;
    setState(() {
      target.add(value);
      controller.clear();
    });
  }

  JobModel _buildPreviewJob() {
    return JobModel(
      id: 'preview',
      title: _titleController.text,
      companyName: _companyController.text,
      companyTagline: _taglineController.text,
      location: _locationController.text,
      logo: AppStrings.barbershopImage,
      isRemoteFriendly: _isRemoteFriendly,
      employmentType: _selectedEmploymentType,
      experienceLevel: _experienceLabel(),
      salaryRange: _salaryController.text,
      postedOn: DateTime.now(),
      applicants: 0,
      description: _descriptionController.text,
      aboutCompany: _aboutController.text,
      responsibilities: List.from(_responsibilities),
      mustHaves: List.from(_mustHaveSkills),
      goodToHaves: List.from(_niceToHaves),
      perks: _selectedPerks.toList(),
      cultureHighlights: [
        'Intentional mentorship',
        if (_selectedPerks.contains('Equity path')) 'Ownership potential',
      ],
      tags: [
        _selectedEmploymentType,
        _experienceLabel(),
        if (_isRemoteFriendly) 'Remote friendly',
        ..._selectedPerks.take(2),
      ],
      isPromoted: true,
      isSaved: false,
      isApplied: false,
      isOwnerPosting: true,
      isEasyApply: true,
    );
  }

  void _openPreviewSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20.w,
            right: 20.w,
            top: 20.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text('Preview', style: AppTextStyle.semiBold(fontSize: 16.sp)),
                SizedBox(height: 10.h),
                JobCard(
                  job: _buildPreviewJob(),
                  isSaved: false,
                  isApplied: false,
                  onTap: () {},
                  onToggleSave: () {},
                  onApply: () {},
                  margin: EdgeInsets.zero,
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Draft saved.')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: const Text('Looks good'),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
